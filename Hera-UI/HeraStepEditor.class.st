Class {
	#name : 'HeraStepEditor',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'code',
		'description',
		'type',
		'saveButton',
		'cancelButton',
		'originalCode',
		'modelChangedInProgress',
		'originalDescription',
		'pattern'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'actions' }
HeraStepEditor >> cancel [

	self modelChanged
]

{ #category : 'initialization' }
HeraStepEditor >> connectPresenters [

	code whenTextChangedDo: [ self updateAfterCodeChange ].
	description whenTextChangedDo: [ self updateAfterCodeChange ].
	type whenSelectionChangedDo: [ self updateAfterCodeChange ].
	pattern whenSelectionChangedDo: [ self updateAfterCodeChange ].
	code whenSubmitDo: [ :ignoredText | self save ]
]

{ #category : 'layout' }
HeraStepEditor >> defaultLayout [

	| definition |
	definition := SpBoxLayout newHorizontal
		spacing: 5;
		add: type width: 70;
		add: description;
		add: pattern width: 55;
		yourself.
	^ SpBoxLayout newVertical
		spacing: 5;
		add: self toolbar expand: false;
		add: definition expand: false;
		add: code;
		yourself
]

{ #category : 'private' }
HeraStepEditor >> hasChanged [

	^ type selectedItem ~= self model stepType
		or: [ pattern selectedItem ~= (self labelForPattern: self model stepPattern)
		or: [ originalDescription ~= description text
		or: [ originalCode ~= code text ] ] ]
]

{ #category : 'initialization' }
HeraStepEditor >> initializePresenters [

	self model: nil. "Otherwise the announcing object is not set."
	self initializeToolbarButtons.
	type := self newDropList
		items: { 'Given' . 'When' . 'Then' };
		startWithoutSelection;
		yourself.
	pattern := self newDropList
		items: { '=' . '{}' . '.*' };
		startWithoutSelection;
		yourself.
	description := self newTextInput.
	code := self newCode
]

{ #category : 'initialization' }
HeraStepEditor >> initializeToolbarButtons [

	saveButton := self newButton
		help: 'Save';
		iconName: #accept;
		action: [ self save ];
		yourself.
	cancelButton := self newButton
		help: 'Cancel';
		iconName: #cancel;
		action: [ self cancel ];
		yourself
]

{ #category : 'private' }
HeraStepEditor >> labelForPattern: aPattern [

	aPattern = 'match' ifTrue: [ ^ '{}' ].
	aPattern = 'regex' ifTrue: [ ^ '.*' ].
	^ '='
]

{ #category : 'initialization' }
HeraStepEditor >> modelChanged [

	| stepMethodItem enabled |
	stepMethodItem := self model.
	modelChangedInProgress := true.
	saveButton enabled: false.
	cancelButton enabled: false.
	enabled := stepMethodItem isNotNil.
	type enabled: enabled.
	description enabled: enabled.
	code enabled: enabled.
	stepMethodItem
		ifNil: [
			type resetSelection.
			description text: ''.
			pattern resetSelection.
			code text: '' ]
		ifNotNil: [
			type selectItem: stepMethodItem stepType.
			description text: stepMethodItem stepDescription.
			pattern selectItem: (self labelForPattern: stepMethodItem stepPattern).
			code
				beForMethod: stepMethodItem stepMethod;
				text: (self sourceFor: stepMethodItem);
				selectionInterval: (0 to: 0). ].
	originalDescription := description text copy asString.
	originalCode := code text copy asString.
	modelChangedInProgress := false
]

{ #category : 'private' }
HeraStepEditor >> patternForLabel: label [

	label = '{}' ifTrue: [ ^ 'match' ].
	label = '.*' ifTrue: [ ^ 'regex' ].
	^ nil
]

{ #category : 'actions' }
HeraStepEditor >> save [

	| stepMethodSource stepMethod |
	self hasChanged ifFalse: [ ^ self ].
	stepMethodSource := HeraStepMethodGenerator new
		type: type selectedItem;
		pattern: (self patternForLabel: pattern selectedItem);
		description: description text;
		source: code text;
		acceptanceTestClass: self model acceptanceTestClass;
		generatedCode.
	stepMethod := self model saveSource: stepMethodSource.
	self model: (HeraStepMethodItem new stepMethod: stepMethod)
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

{ #category : 'layout' }
HeraStepEditor >> toolbar [

	^ SpBoxLayout newLeftToRight
		spacing: 10;
		hAlignEnd;
		add: saveButton width: 40;
		add: cancelButton width: 40;
		yourself
]

{ #category : 'private' }
HeraStepEditor >> updateAfterCodeChange [

	| enabled |
	modelChangedInProgress ifTrue: [ ^ self ].
	enabled := self hasChanged.
	saveButton enabled: enabled.
	cancelButton enabled: enabled
]
