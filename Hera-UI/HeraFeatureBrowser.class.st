Class {
	#name : 'HeraFeatureBrowser',
	#superclass : 'SpPresenter',
	#instVars : [
		'runButton',
		'classesAndFeatures',
		'scriptEditor',
		'stepEditor',
		'debugButton',
		'stepByStepButton',
		'scope'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'accessing' }
HeraFeatureBrowser class >> defaultPreferredExtent [

	^ 800@400
]

{ #category : 'initialization' }
HeraFeatureBrowser >> acceptanceTestClassItems [

	| items |
	items := self scope allForBrowsing collect: [ :each |
		HeraAcceptanceTestClassItem new acceptanceTestClass: each ].
	items sort: [ :some :other | some nameInBrowser < other nameInBrowser ].
	^ items
]

{ #category : 'actions' }
HeraFeatureBrowser >> addAcceptanceTestClass [

	| className packageName acceptanceTestClass |
	self flag: 'This UI interaction can be improved a lot by using a dedicated dialog'.
	className := [ self
		request: 'Please enter the name of the class.'
		initialAnswer: 'MyAcceptanceTest'
		title: 'New Acceptance Test Class' ]
		on: SpCancelledInteractionError do: [ ^ self ].
	packageName := [ self
		request: 'Please enter the name of the package of the class.'
		initialAnswer: 'MyPackage'
		title: 'New Acceptance Test Class' ]
		on: SpCancelledInteractionError do: [ ^ self ].
	self flag: 'TODO: check validity of the class name and the package name'.
	acceptanceTestClass := Smalltalk classInstaller make: [ :classBuilder |
		classBuilder
			name: className;
			superclass: HeraAcceptanceTest;
			package: packageName ].
	self updateClassesAndFeaturesAfterAddingClass: acceptanceTestClass
]

{ #category : 'actions' }
HeraFeatureBrowser >> addFeature [

	| name featureMethod |
	name := [ self
		request: 'Please enter the name of the feature.'
		initialAnswer: 'My awesome feature'
		title: 'New Feature' ]
		on: SpCancelledInteractionError do: [ ^ self ].
	featureMethod := classesAndFeatures selectedItem addFeatureNamed: name.
	self updateClassesAndFeaturesAfterAddingFeatureMethod: featureMethod
]

{ #category : 'private' }
HeraFeatureBrowser >> addStepDefinitionMethodFor: aStepAstNode [

	| methodSelector message invalidMessage |
	methodSelector := self suggestedStepMethodSelectorFor: aStepAstNode.
	invalidMessage := ''.
	[ message := 'The step "{1}" has no definition yet. If you want to create it, please enter a method selector.{2}' format: { aStepAstNode description . invalidMessage }.
		[ methodSelector := self request: message initialAnswer: methodSelector title: 'Missing step definition' ]
		on: SpCancelledInteractionError
		do: [ ^ self ].
		invalidMessage := ' That is not a valid method selector. Only letters, digits, and underscores are allowed.'.
		self allowedMethodSelector: methodSelector ] whileFalse.
	classesAndFeatures selectedItem addStepDefinitionMethodFor: aStepAstNode as: methodSelector
]

{ #category : 'private' }
HeraFeatureBrowser >> allowedMethodSelector: methodSelector [

	^ methodSelector allSatisfy: [ :char | self allowedMethodSelectorCharacter: char ]
]

{ #category : 'private' }
HeraFeatureBrowser >> allowedMethodSelectorCharacter: aCharacter [

	^ aCharacter isLetter or: [ aCharacter isDigit or: [ aCharacter = $_ ] ]
]

{ #category : 'actions' }
HeraFeatureBrowser >> browseSelectionInClassesAndFeatures [

	classesAndFeatures selectedItem browse
]

{ #category : 'private - menus' }
HeraFeatureBrowser >> configureBrowseAction: action withHelp: helpString [

	action		
		name: 'Browse';
		description: helpString;
		shortcutKey: $b meta;
		actionEnabled: [ self hasSelectedClassOrFeature ];
		action: [ self browseSelectionInClassesAndFeatures ]
]

{ #category : 'private - menus' }
HeraFeatureBrowser >> configureRemoveAction: action withHelp: helpString [

	action		
		name: 'Remove';
		description: helpString;
		shortcutKey: $d meta;
		actionEnabled: [ self hasSelectedClassOrFeature ];
		action: [ self removeSelectionInClassesAndFeatures ]
]

{ #category : 'initialization' }
HeraFeatureBrowser >> connectPresenters [

	classesAndFeatures
		children: [ :item | item subitems ];
		display: [ :item | item nameInBrowser ];
		whenSelectionChangedDo: [ :selection | self featureSelectionChanged ].
	self installClassesAndFeaturesContextMenu.
	scriptEditor whenSubmitDo: [ :featureAstNode | self updateSelectedFeature: featureAstNode ].
	scriptEditor whenOpenStepDo: [ :stepAstNode | self updateStepEditor: stepAstNode ]
]

{ #category : 'actions' }
HeraFeatureBrowser >> debug [

	| runner acceptanceTest featureMethodItem |
	featureMethodItem := classesAndFeatures selectedItem.
	acceptanceTest := featureMethodItem acceptanceTest.
	runner := self instantiate: HeraRunner.
	runner open.
	runner debugAcceptanceTest: acceptanceTest
]

{ #category : 'layout' }
HeraFeatureBrowser >> defaultLayout [

	| featureEditorAndButton buttonBar leftPanes |
	buttonBar := SpBoxLayout newLeftToRight
		hAlignCenter;
		spacing: 10;
		add: runButton expand: false;
		add: stepByStepButton expand: false;
		add: debugButton expand: false;
		yourself.
	featureEditorAndButton := SpBoxLayout newTopToBottom
		spacing: 5;
		add: scriptEditor;
		add: buttonBar expand: false;
		yourself.
	leftPanes := SpPanedLayout newLeftToRight
		add: classesAndFeatures;
		add: featureEditorAndButton;
		yourself.
	^ SpPanedLayout newLeftToRight
		positionOfSlider: 66 percent;
		add: leftPanes;
		add: stepEditor;
		yourself
]

{ #category : 'test api' }
HeraFeatureBrowser >> displayedTreeItems [

	| items |
	items := classesAndFeatures roots collect: [ :each |
		each nameInBrowser -> ((classesAndFeatures childrenFor: each) collect: #nameInBrowser) ].
	^ items asArray
]

{ #category : 'private' }
HeraFeatureBrowser >> featureSelectionChanged [

	scriptEditor
		text: (classesAndFeatures selectedItem ifNil: [ '' ] ifNotNil: [ :item | item richScript]);
		selectionInterval: (0 to: 0).
	self updateAfterSelectionChange
]

{ #category : 'test api' }
HeraFeatureBrowser >> hasNoFeatures [

	^ classesAndFeatures roots isEmpty
]

{ #category : 'private' }
HeraFeatureBrowser >> hasSelectedClass [

	^ classesAndFeatures selectedItem isMemberOf: HeraAcceptanceTestClassItem
]

{ #category : 'private' }
HeraFeatureBrowser >> hasSelectedClassOrFeature [

	^ classesAndFeatures selectedItem isNotNil
]

{ #category : 'private' }
HeraFeatureBrowser >> hasSelectedFeature [

	^ classesAndFeatures selectedItem isMemberOf: HeraFeatureMethodItem
]

{ #category : 'private' }
HeraFeatureBrowser >> heraApplication [

	^ HeraApplication new
		addStyleSheetFromString: '.application [
			.total [ Draw { #backgroundColor: #white} ],
			.passed [ Draw { #backgroundColor: #green } ],
			.failed [ Draw { #backgroundColor: #yellow } ],
			.error [ Draw { #backgroundColor: #red } ],
			.runButton [ Geometry { #hResizing: false }, Container { #borderColor: #transparent, #borderWidth: 1 } ],
			.activeButton [ Container { #borderColor: #darkGray } ],
			.featureText [ Font { #name: EnvironmentFont(#code) } ]
		]';
		yourself
]

{ #category : 'initialization' }
HeraFeatureBrowser >> initialize [

	super initialize.
	self application: self heraApplication
]

{ #category : 'initialization' }
HeraFeatureBrowser >> initializePresenters [

	classesAndFeatures := self newTree.
	scriptEditor := self instantiate: HeraScriptEditor.
	stepByStepButton := self newButton
		label: 'Step';
		action: [ self stepByStep ];
		yourself.
	debugButton := self newButton
		label: 'Debug';
		action: [ self debug ];
		yourself.
	runButton := self newButton
		label: 'Run';
		action: [ self run ];
		yourself.
	stepEditor := self instantiate: HeraStepEditor
]

{ #category : 'initialization' }
HeraFeatureBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenOpenedDo: [
		classesAndFeatures
			roots: self acceptanceTestClassItems;
			expandAll.
		scriptEditor setupAfterOpening.
		self updateAfterSelectionChange ]
]

{ #category : 'private - menus' }
HeraFeatureBrowser >> installClassesAndFeaturesContextMenu [

	classesAndFeatures
		actionsWith: [ :rootGroup |
			rootGroup
				addActionWith: [ :action |
					action
						name: 'New acceptance test class…';
						description: 'Add a new class to hold features.';
						action: [ self addAcceptanceTestClass ] ];
				addActionWith: [ :action |
					action
						name: 'New feature…';
						description: 'Add a new feature.';
						action: [ self addFeature ];
						actionEnabled: [ self hasSelectedClassOrFeature ] ];
				addGroupWith: [ :group |
					group
						beDisplayedAsGroup;
						addActionWith: [ :action | self configureRemoveAction: action withHelp: 'Remove the selected class or feature.' ] ];
				addGroupWith: [ :group |
					group
						beDisplayedAsGroup;
						addActionWith: [ :action | self configureBrowseAction: action withHelp: 'Browse the selected class or feature.' ] ] ]
]

{ #category : 'private' }
HeraFeatureBrowser >> methodFor: aStepAstNode [

	^ self selectedMethodItem acceptanceTest methodForStepDescription: aStepAstNode description
]

{ #category : 'actions' }
HeraFeatureBrowser >> removeSelectionInClassesAndFeatures [

	| selectedItem |
	selectedItem := classesAndFeatures selectedItem.
	(self confirm: selectedItem removalConfirmationQuestion) ifFalse: [ ^ self ].
	selectedItem remove.
	self updateClassesAndFeatures
]

{ #category : 'actions' }
HeraFeatureBrowser >> run [

	| runner acceptanceTest featureMethodItem |
	featureMethodItem := classesAndFeatures selectedItem.
	acceptanceTest := featureMethodItem acceptanceTest.
	runner := self instantiate: HeraRunner.
	runner open.
	runner runAcceptanceTest: acceptanceTest
]

{ #category : 'initialization' }
HeraFeatureBrowser >> scope [

	^ scope ifNil: [ scope := HeraScope default ]
]

{ #category : 'initialization' }
HeraFeatureBrowser >> scope: aScope [

	scope := aScope
]

{ #category : 'test api' }
HeraFeatureBrowser >> script [

	^ scriptEditor text
]

{ #category : 'test api' }
HeraFeatureBrowser >> selectPath: anArray [

	classesAndFeatures selectPath: anArray
]

{ #category : 'private' }
HeraFeatureBrowser >> selectedMethodItem [

	^ classesAndFeatures selectedItem
]

{ #category : 'actions' }
HeraFeatureBrowser >> stepByStep [

	| runner acceptanceTest featureMethodItem |
	featureMethodItem := classesAndFeatures selectedItem.
	acceptanceTest := featureMethodItem acceptanceTest.
	runner := self instantiate: HeraRunner.
	runner open.
	runner stepAcceptanceTest: acceptanceTest
]

{ #category : 'private' }
HeraFeatureBrowser >> suggestedStepMethodSelectorFor: aStepAstNode [

	| colonOrNothing suggestion |
	self flag: 'Take step arguments into account'.
	colonOrNothing := aStepAstNode argument ifNil: [ '' ] ifNotNil: [ ':' ].
	suggestion := aStepAstNode description asCamelCase select: [ :char | self allowedMethodSelectorCharacter: char ].
	^ 'step{1}{2}' format: { suggestion . colonOrNothing }
]

{ #category : 'private' }
HeraFeatureBrowser >> updateAfterSelectionChange [

	| enabled |
	enabled := classesAndFeatures selectedItem ifNil: [ false ] ifNotNil: [ :browserItem | browserItem isRunnable ].
	runButton enabled: enabled.
	stepByStepButton enabled: enabled.
	debugButton enabled: enabled.
	scriptEditor enabled: enabled
]

{ #category : 'private' }
HeraFeatureBrowser >> updateClassesAndFeatures [

	classesAndFeatures
		roots: self acceptanceTestClassItems;
		expandAll
]

{ #category : 'private' }
HeraFeatureBrowser >> updateClassesAndFeaturesAfterAddingClass: acceptanceTestClass [

	self flag: 'Brute force update for now. Better: insert acceptanceTestClass.'.
	self updateClassesAndFeatures.
	classesAndFeatures selection selectItem: (HeraAcceptanceTestClassItem new acceptanceTestClass: acceptanceTestClass)
]

{ #category : 'private' }
HeraFeatureBrowser >> updateClassesAndFeaturesAfterAddingFeatureMethod: featureMethod [

	self flag: 'Brute force update for now. Better: insert featureMethod.'.
	self updateClassesAndFeatures.
	classesAndFeatures selection selectItem: (HeraFeatureMethodItem new featureMethod: featureMethod)
]

{ #category : 'private' }
HeraFeatureBrowser >> updateSelectedFeature: aFeatureAstNode [

	self selectedMethodItem saveSource: aFeatureAstNode
]

{ #category : 'private' }
HeraFeatureBrowser >> updateStepEditor: aStepAstNode [

	(self methodFor: aStepAstNode)
		ifNil: [ self addStepDefinitionMethodFor: aStepAstNode ]
		ifNotNil: [ :stepMethod |
			stepEditor methodItem: (HeraStepMethodItem new stepMethod: stepMethod) ]
]

{ #category : 'accessing' }
HeraFeatureBrowser >> windowTitle [

	^ 'Hera Feature Browser'
]
