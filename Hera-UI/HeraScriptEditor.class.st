Class {
	#name : 'HeraScriptEditor',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'script',
		'submitBlock',
		'ast',
		'openStepBlock',
		'parser',
		'saveButton',
		'cancelButton',
		'modelChangedInProgress',
		'originalScript'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'accessing' }
HeraScriptEditor >> acceptanceTest [

	^ self model acceptanceTest
]

{ #category : 'private' }
HeraScriptEditor >> altKeyClick: event [

	| caretPosition astNode |
	ast ifNil: [ ^ self ].
	caretPosition := script selectionInterval first.
	astNode := HeraTextBasedAstSearcher new
		textPosition: caretPosition;
		visit: ast.
	(astNode isNil or: [ astNode isStepNode not ]) ifTrue: [ ^ self ].
	openStepBlock value: astNode
]

{ #category : 'private' }
HeraScriptEditor >> astForScript: aString [

	^ self parser
		initializeParserWith: aString;
		parseFeature
]

{ #category : 'private' }
HeraScriptEditor >> buildAst: source [

	ast := self astForScript: source
]

{ #category : 'actions' }
HeraScriptEditor >> cancel [

	self modelChanged
]

{ #category : 'initialization' }
HeraScriptEditor >> connectPresenters [

	script whenTextChangedDo: [ self updateAfterScriptChange ].
	script whenSubmitDo: [ :ignoredText | self save ].
	script eventHandler whenMouseUpDo: [ :event |
		event altKeyPressed ifTrue: [ self altKeyClick: event ] ]
]

{ #category : 'layout' }
HeraScriptEditor >> defaultLayout [

	^ SpBoxLayout newVertical
		spacing: 5;
		add: self toolbar expand: false;
		add: script;
		yourself
]

{ #category : 'private' }
HeraScriptEditor >> hasChanged [

	^ originalScript ~= self text
]

{ #category : 'initialization' }
HeraScriptEditor >> initializePresenters [

	modelChangedInProgress := false.
	self initializeToolbarButtons.
	script := self newText
		addStyle: 'featureText';
		yourself
]

{ #category : 'initialization' }
HeraScriptEditor >> initializeToolbarButtons [

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
HeraScriptEditor >> lintWarnings [

	^ HeraLinter new
		acceptanceTest: self acceptanceTest;
		lint: ast;
		warnings
]

{ #category : 'initialization' }
HeraScriptEditor >> modelChanged [

	| text enabled |
	modelChangedInProgress := true.
	enabled := self model ifNil: [ false ] ifNotNil: [ :model | model isEditable ].
	script enabled: enabled.
	saveButton enabled: false.
	cancelButton enabled: false.
	self model
		ifNil: [ self text: '' ]
		ifNotNil: [
			text := self model richScript.
			self
				text: text;
				selectionInterval: (text size + 1 to: text size + 1) ].
	originalScript := self text copy asString.
	modelChangedInProgress := false
]

{ #category : 'private' }
HeraScriptEditor >> parser [

	^ parser ifNil: [ parser := HeraParser new ]
]

{ #category : 'actions' }
HeraScriptEditor >> save [

	self hasChanged ifFalse: [ ^ self ].
	self submit: script text
]

{ #category : 'api' }
HeraScriptEditor >> selectionInterval: anInterval [

	script selectionInterval: anInterval
]

{ #category : 'initialization' }
HeraScriptEditor >> setupAfterOpening [

	script withAdapterDo: [ :textAdapter |
		textAdapter widget
			withTextSegmentIcons;
			withLineNumbers ]
]

{ #category : 'private' }
HeraScriptEditor >> showParseError [

	| decorator error |
	error := parser parseError.
	decorator := SpTextPresenterDecorator new.
	"decorator highlightColor: Color red."
	decorator underlineColor: Color red.
	decorator title: error messageText.
	decorator icon: (self iconNamed: #halt).
	decorator iconBlock: [ :seg| seg ].
	decorator interval: (error start to: error end + 1).
	script removeAllTextSegmentDecorations.
	script addTextSegmentDecoration: decorator
]

{ #category : 'private' }
HeraScriptEditor >> showWarnings [

	| decorator warnings |
	script removeAllTextSegmentDecorations.
	warnings := self lintWarnings.
	warnings ifEmpty: [ ^ self ].
	warnings do: [ :warning |
		decorator := SpTextPresenterDecorator new.
		decorator underlineColor: warning color.
		decorator title: warning message.
		decorator icon: (self iconNamed: warning iconName).
		decorator iconBlock: [ :seg| seg ].
		decorator interval: (warning start to: warning end + 1).
		script addTextSegmentDecoration: decorator ]
]

{ #category : 'private' }
HeraScriptEditor >> submit: source [

	(self astForScript: source)
		ifNil: [ self showParseError ]
		ifNotNil: [ :featureAstNode |
			submitBlock value: featureAstNode.
			self buildAst: script text asString.
			self showWarnings ]
]

{ #category : 'api' }
HeraScriptEditor >> text [

	^ script text
]

{ #category : 'api' }
HeraScriptEditor >> text: aText [

	script removeAllTextSegmentDecorations.
	script text: aText.
	aText ifEmpty: [ ^ self ].
	self buildAst: aText string.
	self showWarnings
]

{ #category : 'layout' }
HeraScriptEditor >> toolbar [

	^ SpBoxLayout newLeftToRight
		spacing: 10;
		hAlignEnd;
		add: saveButton width: 40;
		add: cancelButton width: 40;
		yourself
]

{ #category : 'private' }
HeraScriptEditor >> updateAfterScriptChange [

	| enabled |
	modelChangedInProgress ifTrue: [ ^ self ].
	enabled := self hasChanged.
	saveButton enabled: enabled.
	cancelButton enabled: enabled
]

{ #category : 'api' }
HeraScriptEditor >> updateWarnings [

	self showWarnings
]

{ #category : 'api' }
HeraScriptEditor >> whenOpenStepDo: aBlock [

	openStepBlock := aBlock
]

{ #category : 'api' }
HeraScriptEditor >> whenSubmitDo: aBlock [

	submitBlock := aBlock
]
