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
		'runScenarioBlock',
		'stepScenarioBlock',
		'debugScenarioBlock',
		'runButton',
		'stepByStepButton',
		'debugButton'
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

	| astNode |
	ast ifNil: [ ^ self ].
	astNode := HeraTextBasedAstSearcher new
		textPosition: self caretPositionForAltClick;
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

{ #category : 'private' }
HeraScriptEditor >> caretPositionForAltClick [
	"Answer a position inside an AST node, even if the real caret position is located after the last character of the node.
	 This allows Alt-Clicking after a step to select it."

	| caretPosition |
	caretPosition := script selectionInterval first.
	caretPosition := caretPosition min: script text size.
	(script text at: caretPosition) = Character cr ifTrue: [ ^ caretPosition - 1 ].
	^ caretPosition
]

{ #category : 'test api' }
HeraScriptEditor >> clickDebugButton [

	debugButton performAction
]

{ #category : 'test api' }
HeraScriptEditor >> clickRunButton [

	runButton performAction
]

{ #category : 'test api' }
HeraScriptEditor >> clickStepByStepButton [

	stepByStepButton performAction
]

{ #category : 'initialization' }
HeraScriptEditor >> connectPresenters [

	script whenTextChangedDo: [ self updateAfterScriptChange ].
	script whenSubmitDo: [ :ignoredText | self save ].
	script eventHandler whenMouseUpDo: [ :event |
		event altKeyPressed ifTrue: [ self altKeyClick: event ] ].
	self installContextMenu
]

{ #category : 'actions' }
HeraScriptEditor >> debugFeature [

	(self instantiate: HeraRunner)
		open;
		debugAcceptanceTest: self acceptanceTest
]

{ #category : 'actions' }
HeraScriptEditor >> debugScenario [

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
	debugScenarioBlock value: astNode
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
	runButton := self newButton
		help: 'Run';
		iconName: #go;
		action: [ self runFeature ];
		yourself.
	stepByStepButton := self newButton
		help: 'Step';
		iconName: #into;
		action: [ self stepFeature ];
		yourself.
	debugButton := self newButton
		help: 'Debug';
		iconName: #bug;
		action: [ self debugFeature ];
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

{ #category : 'test api' }
HeraScriptEditor >> isBrowseButtonEnabled [

	^ browseButton isEnabled
]

{ #category : 'test api' }
HeraScriptEditor >> isDebugButtonEnabled [

	^ debugButton isEnabled
]

{ #category : 'test api' }
HeraScriptEditor >> isRunButtonEnabled [

	^ runButton isEnabled
]

{ #category : 'test api' }
HeraScriptEditor >> isStepByStepButtonEnabled [

	^ stepByStepButton isEnabled
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
	runButton enabled: hasModel.
	stepByStepButton enabled: hasModel.
	debugButton enabled: hasModel.
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
HeraScriptEditor >> runFeature [

	(self instantiate: HeraRunner)
		open;
		runAcceptanceTest: self acceptanceTest
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

{ #category : 'test api' }
HeraScriptEditor >> setCaretAt: caretPosition [

	script takeKeyboardFocus.
	self selectionInterval: (caretPosition to: caretPosition - 1)
]

{ #category : 'initialization' }
HeraScriptEditor >> setupAfterOpening [

	script withAdapterDo: [ :textAdapter |
		textAdapter widget
			withTextSegmentIcons;
			withLineNumbers ].
	self modelChanged
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

{ #category : 'actions' }
HeraScriptEditor >> stepFeature [

	(self instantiate: HeraRunner)
		open;
		stepAcceptanceTest: self acceptanceTest
]

{ #category : 'actions' }
HeraScriptEditor >> stepScenario [

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
	stepScenarioBlock value: astNode
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

	| browseGroup saveGroup runGroup spacer |
	runGroup := SpBoxLayout newLeftToRight
		spacing: 10;
		add: runButton width: 40;
		add: stepByStepButton width: 40;
		add: debugButton width: 40;
		yourself.
	browseGroup := SpBoxLayout newLeftToRight
		spacing: 10;
		hAlignEnd;
		add: browseButton width: 40;
		yourself.
	saveGroup := SpBoxLayout newLeftToRight
		spacing: 10;
		hAlignEnd;
		add: saveButton width: 40;
		add: cancelButton width: 40;
		yourself.
	spacer := SpPresenter new layout: SpBoxLayout newLeftToRight; yourself.
	^ SpBoxLayout newLeftToRight
		add: runGroup;
		add: browseGroup;
		add: saveGroup width: 140;
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

{ #category : 'updating' }
HeraScriptEditor >> updatePresenter [

	"Do not send #modelChanged because the adapter of the script text presenter does not exist yet."
]

{ #category : 'api' }
HeraScriptEditor >> updateWarnings [

	self showWarnings
]

{ #category : 'api' }
HeraScriptEditor >> whenDebugScenarioDo: aBlock [

	debugScenarioBlock := aBlock
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
HeraScriptEditor >> whenStepScenarioDo: aBlock [

	stepScenarioBlock := aBlock
]

{ #category : 'api' }
HeraScriptEditor >> whenSubmitDo: aBlock [

	submitBlock := aBlock
]
