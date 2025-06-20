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
		'pattern',
		'browseButton'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'actions' }
HeraStepEditor >> browseStepMethod [

	self model stepMethod browse
]

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

{ #category : 'notification' }
HeraStepEditor >> correctFrom: start to: stop with: aString [

	code withAdapterDo: [ :textAdapter | textAdapter widgetDo: [ :textArea | textArea correctFrom: start to: stop with: aString ] ]
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

	^ self model isNotNil and: [ type selectedItem ~= self model stepType
		or: [ pattern selectedItem ~= (self labelForPattern: self model stepPattern)
		or: [ originalDescription ~= description text
		or: [ originalCode ~= code text ] ] ] ]
]

{ #category : 'initialization' }
HeraStepEditor >> initializePresenters [

	modelChangedInProgress := false.
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

	browseButton := self newButton
		help: 'Browse step method';
		iconName: #nautilus;
		action: [ self browseStepMethod ];
		yourself.
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

	| stepMethodItem hasModel |
	stepMethodItem := self model.
	modelChangedInProgress := true.
	saveButton enabled: false.
	cancelButton enabled: false.
	hasModel := stepMethodItem isNotNil.
	browseButton enabled: hasModel.
	type enabled: hasModel.
	description enabled: hasModel.
	pattern enabled: hasModel.
	code enabled: hasModel.
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
				selectionInterval: (0 to: 0) ].
	originalDescription := description text copy asString.
	originalCode := code text copy asString.
	modelChangedInProgress := false
]

{ #category : 'notification' }
HeraStepEditor >> notify: aString at: anIteger in: source [

	code notify: aString at: anIteger in: source
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
	stepMethod := self model compileSourceWithoutPragma: self text notifying: self.
	stepMethod ifNil: [ ^ self ].
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

{ #category : 'initialization' }
HeraStepEditor >> setupAfterOpening [

	self modelChanged
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

{ #category : 'accessing' }
HeraStepEditor >> text [

	^ code text
]

{ #category : 'layout' }
HeraStepEditor >> toolbar [

	| leftSide rightSide |
	leftSide := SpBoxLayout newLeftToRight
		spacing: 10;
		add: browseButton width: 40;
		yourself.
	rightSide := SpBoxLayout newLeftToRight
		spacing: 10;
		hAlignEnd;
		add: saveButton width: 40;
		add: cancelButton width: 40;
		yourself.
	^ SpBoxLayout newLeftToRight
		add: leftSide;
		add: rightSide;
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

{ #category : 'updating' }
HeraStepEditor >> updatePresenter [

	"Do not send #modelChanged because the adapter of the script text presenter does not exist yet."
]
