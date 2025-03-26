Class {
	#name : 'HeraStepEditor',
	#superclass : 'SpPresenter',
	#instVars : [
		'code',
		'step'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'layout' }
HeraStepEditor >> defaultLayout [

	^ SpBoxLayout newVertical
		spacing: 5;
		add: step expand: false;
		add: code;
		yourself
]

{ #category : 'initialization' }
HeraStepEditor >> initializePresenters [

	step := self newTextInput.
	code := self newCode
]

{ #category : 'api' }
HeraStepEditor >> method: aCompiledMethod [

	| source description sourceLines |
	aCompiledMethod ifNil: [
		step text: ''.
		code text: ''.
		^ self ].
	description := (aCompiledMethod pragmaAt: #heraStepDefinition:) arguments first second.
	step text: description.
	sourceLines := aCompiledMethod sourceCode lines.
	sourceLines := sourceLines size < 5
		ifTrue: [ #() ]
		ifFalse: [ (sourceLines copyFrom: 5 to: sourceLines size) collect: #trimBoth ].
	source := Character cr join: sourceLines.
	code
		text: source;
		selectionInterval: (0 to: 0)
]

{ #category : 'api' }
HeraStepEditor >> methodItem: aStepMethodItem [

	| description |
	aStepMethodItem ifNil: [
		step text: ''.
		code text: ''.
		^ self ].
	
	description := aStepMethodItem stepDescription.
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
