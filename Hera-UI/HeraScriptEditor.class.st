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
		'originalScript',
		'browseButton',
		'runScenarioBlock'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'accessing' }
HeraScriptEditor >> acceptanceTest [

	^ self model acceptanceTest
]

{ #category : 'private - menus' }
HeraScriptEditor >> addRunMenuGroupTo: parentGroup [

		parentGroup addGroupWith: [ :group |
			group
				beDisplayedAsGroup;
				addActionWith: [ :action |
					action		
						name: 'Run scenario';
						description: 'Run the selected feature';
						shortcutKey: $r meta;
						"actionEnabled: [ self hasSelectedFeature ];"
						action: [ self runScenario ] ];
				addActionWith: [ :action |
					action		
						name: 'Step scenario';
						description: 'Run the selected feature step by step';
						shortcutKey: $r meta shift;
						"actionEnabled: [ self hasSelectedFeature ];"
						action: [ self stepScenario ] ];
				addActionWith: [ :action |
					action		
						name: 'Debug scenario';
						description: 'Run the selected feature in debug mode';
						shortcutKey: $d meta;
						"actionEnabled: [ self hasSelectedFeature ];"
						action: [ self debugScenario ] ] ]
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

{ #category : 'actions' }
HeraScriptEditor >> browseFeatureMethod [

	self model featureMethod browse
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
		event altKeyPressed ifTrue: [ self altKeyClick: event ] ].
	self installContextMenu
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

	^ originalScript ~= self text asString
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

	browseButton := self newButton
		help: 'Browse step method';
		iconName: #nautilus;
		action: [ self browseFeatureMethod ];
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

{ #category : 'private - menus' }
HeraScriptEditor >> installContextMenu [

	script
		actionsWith: [ :rootGroup |
			self addRunMenuGroupTo: rootGroup ]
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

	| text hasModel |
	modelChangedInProgress := true.
	hasModel := self model ifNil: [ false ] ifNotNil: [ :model | model isEditable ].
	script enabled: hasModel.
	saveButton enabled: false.
	cancelButton enabled: false.
	browseButton enabled: hasModel.
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
HeraScriptEditor >> runScenario [

	| caretPosition astNode |
	self hasChanged ifTrue: [
		self inform: 'Please save the script first.'.
		^ self ].
	caretPosition := script selectionInterval first.
	astNode := HeraTextBasedAstSearcher new
		textPosition: caretPosition;
		beForSearchingScenario;
		visit: ast.
	(astNode isNil or: [ astNode isScenarioNode not ]) ifTrue: [ ^ self ].
	runScenarioBlock value: astNode
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
HeraScriptEditor >> whenRunScenarioDo: aBlock [

	runScenarioBlock := aBlock
]

{ #category : 'api' }
HeraScriptEditor >> whenSubmitDo: aBlock [

	submitBlock := aBlock
]
