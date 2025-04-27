Class {
	#name : 'HeraStepEditor',
	#superclass : 'SpPresenter',
	#instVars : [
		'code',
		'step',
		'stepType'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'layout' }
HeraStepEditor >> defaultLayout [

	| definition |
	definition := SpBoxLayout newHorizontal
		spacing: 5;
		add: stepType width: 70;
		add: step;
		yourself.
	^ SpBoxLayout newVertical
		spacing: 5;
		add: definition expand: false;
		add: code;
		yourself
]

{ #category : 'initialization' }
HeraStepEditor >> initializePresenters [

	stepType := self newDropList
		items: { 'Given' . 'When' . 'Then' };
		startWithoutSelection;
		yourself.
	step := self newTextInput.
	code := self newCode
]

{ #category : 'api' }
HeraStepEditor >> methodItem: aStepMethodItem [

	| description |
	aStepMethodItem ifNil: [
		stepType resetSelection.
		step text: ''.
		code text: ''.
		^ self ].
	
	description := aStepMethodItem stepDescription.
	stepType selectItem: aStepMethodItem stepType.
	step text: description.
	code
		beForMethod: aStepMethodItem stepMethod;
		text: (self sourceFor: aStepMethodItem);
		selectionInterval: (0 to: 0)
]

{ #category : 'private' }
HeraStepEditor >> sourceFor: aStepMethodItem [
	"Answer the source of the step method without the pragma section.
	 The pragma section consists of the lines of the pragma and the empty line above.
	 Take into account that the step method could have been changed outside Hera,
	 which means that we cannot rely on the position of the pragma, nor on the empty line above."

	| sourceLinesWithoutPragmaSection pramaNode source pragmaSectionEndLineIndex sourceWithoutPragma pragmaSectionStartLineIndex |
	pramaNode := aStepMethodItem stepMethod parseTree pragmaNamed: #heraStepDefinition:.
	source := aStepMethodItem sourceCode.
	pragmaSectionEndLineIndex := source lineNumberCorrespondingToIndex: pramaNode left.
	sourceWithoutPragma := source copyReplaceFrom: pramaNode left to: pramaNode right with: ''.
	sourceLinesWithoutPragmaSection := sourceWithoutPragma lines.
	pragmaSectionStartLineIndex := (sourceLinesWithoutPragmaSection at: pragmaSectionEndLineIndex - 1) trimBoth isEmpty
		ifTrue: [ pragmaSectionEndLineIndex - 1 ]
		ifFalse: [ pragmaSectionEndLineIndex ].
	sourceLinesWithoutPragmaSection := (sourceLinesWithoutPragmaSection at: pragmaSectionEndLineIndex) trimBoth isEmpty
		ifTrue: [ sourceLinesWithoutPragmaSection copyReplaceFrom: pragmaSectionStartLineIndex to: pragmaSectionEndLineIndex with: #() ].
	^ Character cr join: sourceLinesWithoutPragmaSection
]
