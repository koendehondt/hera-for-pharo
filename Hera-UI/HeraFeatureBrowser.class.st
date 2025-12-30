Class {
	#name : 'HeraFeatureBrowser',
	#superclass : 'HeraPresenter',
	#instVars : [
		'scriptEditor',
		'stepEditor',
		'scope',
		'featureSelector'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'accessing' }
HeraFeatureBrowser class >> defaultPreferredExtent [

	^ 800@400
]

{ #category : 'world menu' }
HeraFeatureBrowser class >> featureBrowserMenuItemOn: aBuilder [
	<worldMenu>
	
	"See ToolShortcutsCategory>>#openHeraFeatureBrowser for the registration of the shortcut."

	(aBuilder item: #Hera)
		parent: #Testing;
		order: 99;
		keyText: 'o, f';
		label: self windowTitle;
		icon: self windowIcon;
		action: [ HeraApplication new openFeatureBrowser ]
]

{ #category : 'world menu' }
HeraFeatureBrowser class >> featureBrowserOnAllMenuItemOn: aBuilder [
	<worldMenu>
	
	"See ToolShortcutsCategory>>#openHeraFeatureBrowserOnAll for the registration of the shortcut."

	(aBuilder item: #Hera)
		parent: #Testing;
		order: 100;
		label: self windowTitle , ' on all';
		icon: self windowIcon;
		action: [ HeraApplication new openFeatureBrowserOnAll ];
		withSeparatorAfter
]

{ #category : 'accessing' }
HeraFeatureBrowser class >> windowIcon [

	^ Hera settings iconNamed: #crown
]

{ #category : 'accessing' }
HeraFeatureBrowser class >> windowTitle [

	^ 'Hera Feature Browser'
]

{ #category : 'private' }
HeraFeatureBrowser >> addStepDefinitionMethodFor: aStepAstNode [

	| methodSelector message invalidMessage |
	methodSelector := self suggestedStepMethodSelectorFor: aStepAstNode.
	invalidMessage := ''.
	[ message := 'The step "{1}" has no definition yet. If you want to create it, please enter a method selector.{2}' format: { aStepAstNode description . invalidMessage }.
		[ methodSelector := self request: message initialAnswer: methodSelector title: 'Missing step definition' ]
		on: SpCancelledInteractionError
		do: [ ^ nil ].
		invalidMessage := ' That is not a valid method selector. Only letters, digits, and underscores are allowed.'.
		self allowedMethodSelector: methodSelector ] whileFalse.
	^ featureSelector selectedItem addStepDefinitionMethodFor: aStepAstNode as: methodSelector asSymbol
]

{ #category : 'private' }
HeraFeatureBrowser >> allowedMethodSelector: methodSelector [

	| selector |
	selector := methodSelector asSymbol.
	^ selector isUnary or: [ selector isKeyword ]
]

{ #category : 'private' }
HeraFeatureBrowser >> allowedMethodSelectorCharacter: aCharacter [

	^ aCharacter isLetter or: [ aCharacter isDigit or: [ aCharacter = $_ ] ]
]

{ #category : 'private' }
HeraFeatureBrowser >> browseReferences: aStepAstNode [

	| stepMethodItem |
	aStepAstNode description = 'I pause' ifTrue: [
		self inform: 'This step is implemented by Hera. References cannot be browsed.'.
		^ self ].
	self flag: 'It is impossible to find references of a step with parameters.'.
	stepMethodItem := HeraStepMethodItem new stepMethod: (self methodFor: aStepAstNode in: nil).
	Hera browseReferencesTo: stepMethodItem inScope: scope
]

{ #category : 'test api' }
HeraFeatureBrowser >> clickDebugButton [

	featureSelector clickDebugButton
]

{ #category : 'test api' }
HeraFeatureBrowser >> clickRunButton [

	featureSelector clickRunButton
]

{ #category : 'test api' }
HeraFeatureBrowser >> clickStepByStepButton [

	featureSelector clickStepByStepButton
]

{ #category : 'initialization' }
HeraFeatureBrowser >> connectPresenters [

	featureSelector whenFeatureSelectionChangedDo: [ :featureMethodItem |
		scriptEditor model: featureMethodItem.
		self updateWindowTitle ].
	scriptEditor
		whenSubmitDo: [ :featureAstNode | self updateSelectedFeature: featureAstNode ];
		whenOpenStepDo: [ :stepAstNode :scenarioOutlineAstNode | self updateStepEditorFor: stepAstNode in: scenarioOutlineAstNode ];
		whenRunScenarioDo: [ :scenarioAstNode | self runScenario: scenarioAstNode ];
		whenStepScenarioDo: [ :scenarioAstNode | self stepScenario: scenarioAstNode ];
		whenDebugScenarioDo: [ :scenarioAstNode | self debugScenario: scenarioAstNode ];
		whenBrowseReferencesDo: [ :stepAstNode | self browseReferences: stepAstNode ]
]

{ #category : 'test api' }
HeraFeatureBrowser >> currentWindowTitle [

	^ self withWindowDo: [ :window | window title ]
]

{ #category : 'private' }
HeraFeatureBrowser >> debugScenario: scenarioAstNode [

	| scenarioFilter |
	scenarioFilter := HeraScenarioFilter new title: scenarioAstNode title text.
	(self instantiate: HeraRunner)
		open;
		debugScope: self selectedMethodItem acceptanceTest asRunnerScope filteredBy: scenarioFilter
]

{ #category : 'layout' }
HeraFeatureBrowser >> defaultLayout [

	| rightPanes allPanes |
	rightPanes := SpPanedLayout newLeftToRight
		add: scriptEditor;
		add: stepEditor;
		yourself.
	allPanes := SpPanedLayout newLeftToRight
		positionOfSlider: 33 percent;
		add: featureSelector;
		add: rightPanes;
		yourself.
	^ SpBoxLayout newTopToBottom
		spacing: 5;
		add: featureSelector globalToolbar expand: false;
		add: allPanes;
		yourself
]

{ #category : 'test api' }
HeraFeatureBrowser >> displayedTreeItems [

	^ featureSelector displayedTreeItems
]

{ #category : 'private' }
HeraFeatureBrowser >> featureSelectionChanged [

	scriptEditor model: self selectedMethodItem
]

{ #category : 'test api' }
HeraFeatureBrowser >> hasNoFeatures [

	^ featureSelector hasNoFeatures
]

{ #category : 'initialization' }
HeraFeatureBrowser >> initializePresenters [

	featureSelector := self instantiate: HeraFeatureSelector.
	scriptEditor := self instantiate: HeraScriptEditor.
	stepEditor := self instantiate: HeraStepEditor
]

{ #category : 'initialization' }
HeraFeatureBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenOpenedDo: [
		featureSelector setupAfterOpening.
		scriptEditor setupAfterOpening.
		stepEditor setupAfterOpening ]
]

{ #category : 'test api' }
HeraFeatureBrowser >> isAddAcceptanceTestClassButtonEnabled [

	^ featureSelector isAddAcceptanceTestClassButtonEnabled
]

{ #category : 'test api' }
HeraFeatureBrowser >> isAddFeatureButtonEnabled [

	^ featureSelector isAddFeatureButtonEnabled
]

{ #category : 'test api' }
HeraFeatureBrowser >> isBrowseStepsButtonEnabled [

	^ featureSelector isBrowseStepsButtonEnabled
]

{ #category : 'private' }
HeraFeatureBrowser >> methodFor: aStepAstNode in: aScenarioOutlineAstNode [

	^ self selectedMethodItem acceptanceTest methodFor: aStepAstNode in: aScenarioOutlineAstNode
]

{ #category : 'private' }
HeraFeatureBrowser >> runScenario: scenarioAstNode [

	| scenarioFilter |
	self flag: 'We are not sure that we are running the right scenario because 2 scenarios could have the same title.'.
	scenarioFilter := HeraScenarioFilter new title: scenarioAstNode title text.
	(self instantiate: HeraRunner)
		open;
		runScope: self selectedMethodItem acceptanceTest asRunnerScope filteredBy: scenarioFilter
]

{ #category : 'accessing' }
HeraFeatureBrowser >> scope [

	^ scope ifNil: [ scope := HeraScope default ]
]

{ #category : 'accessing' }
HeraFeatureBrowser >> scope: aScope [

	scope := aScope.
	featureSelector scope: aScope
]

{ #category : 'test api' }
HeraFeatureBrowser >> script [

	^ scriptEditor text
]

{ #category : 'test api' }
HeraFeatureBrowser >> selectAcceptanceTestClassNamed: classNameInBrowser [

	featureSelector selectAcceptanceTestClassNamed: classNameInBrowser
]

{ #category : 'test api' }
HeraFeatureBrowser >> selectFeature: featureTitle in: classNameInBrowser [

	featureSelector selectFeature: featureTitle in: classNameInBrowser
]

{ #category : 'test api' }
HeraFeatureBrowser >> selectPaths: pathArray [

	featureSelector selectPaths: pathArray
]

{ #category : 'private' }
HeraFeatureBrowser >> selectedMethodItem [

	^ featureSelector selectedItem
]

{ #category : 'test api' }
HeraFeatureBrowser >> setCaretAt: caretPosition [

	scriptEditor setCaretAt: caretPosition
]

{ #category : 'test api' }
HeraFeatureBrowser >> simulateEventInScriptEditor: event [

	scriptEditor withAdapterDo: [ :anAdapter |
		anAdapter widgetDo: [ :widget|
			widget activeHand handleEvent: event ] ]
]

{ #category : 'private' }
HeraFeatureBrowser >> stepScenario: scenarioAstNode [

	| scenarioFilter |
	scenarioFilter := HeraScenarioFilter new title: scenarioAstNode title text.
	(self instantiate: HeraRunner)
		open;
		stepScope: self selectedMethodItem acceptanceTest asRunnerScope filteredBy: scenarioFilter
]

{ #category : 'private' }
HeraFeatureBrowser >> suggestedStepMethodSelectorFor: aStepAstNode [

	| colonOrNothing suggestion descriptionWithoutParameters |
	self flag: 'Take step arguments into account'.
	colonOrNothing := aStepAstNode argument ifNil: [ '' ] ifNotNil: [ ':' ].
	descriptionWithoutParameters := aStepAstNode description reject: [ :char | char = $< or: [ char = $> ] ].
	suggestion := descriptionWithoutParameters asCamelCase select: [ :char | self allowedMethodSelectorCharacter: char ].
	^ 'step{1}{2}' format: { suggestion . colonOrNothing }
]

{ #category : 'private' }
HeraFeatureBrowser >> updateSelectedFeature: aFeatureAstNode [

	self selectedMethodItem saveSource: aFeatureAstNode.
	self featureSelectionChanged
]

{ #category : 'private' }
HeraFeatureBrowser >> updateStepEditorFor: aStepAstNode in: aScenarioOutlineAstNode [

	| stepMethod |
	aStepAstNode description = 'I pause' ifTrue: [
		self inform: 'This step is implemented by Hera. There is no step implementation.'.
		^ self ].
	stepMethod := self methodFor: aStepAstNode in: aScenarioOutlineAstNode.
	stepMethod ifNil: [ stepMethod := self addStepDefinitionMethodFor: aStepAstNode ].
	stepMethod ifNil: [ ^ self ].
	stepEditor model: (HeraStepMethodItem new stepMethod: stepMethod).
	scriptEditor updateWarnings
]

{ #category : 'private' }
HeraFeatureBrowser >> updateWindowTitle [

	| title |
	title := featureSelector hasSingleSelection
		ifTrue: [ featureSelector selectedItem windowTitle ]
		ifFalse: [ self windowTitle ].
	self windowTitle: title
]

{ #category : 'accessing' }
HeraFeatureBrowser >> windowIcon [

	^ self class windowIcon
]

{ #category : 'accessing' }
HeraFeatureBrowser >> windowTitle [

	^ self class windowTitle
]

{ #category : 'accessing' }
HeraFeatureBrowser >> windowTitle: aString [

	self withWindowDo: [ :window | window title: aString ]
]
