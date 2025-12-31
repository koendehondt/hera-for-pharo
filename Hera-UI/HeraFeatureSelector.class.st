Class {
	#name : 'HeraFeatureSelector',
	#superclass : 'SpPresenter',
	#instVars : [
		'addAcceptanceTestClassButton',
		'addFeatureButton',
		'browseStepsButton',
		'classesAndFeatures',
		'scope',
		'featureSelectionChangedBlock',
		'runSelectedFeaturesButton',
		'runAllFeaturesButton',
		'stepSelectedFeaturesButton',
		'debugSelectedFeaturesButton',
		'saveFeaturesButton',
		'documentationButton',
		'browseButton',
		'toolbar'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'initialization' }
HeraFeatureSelector >> acceptanceTestClassItems [

	| items |
	items := self scope allForBrowsing collect: [ :each |
		HeraAcceptanceTestClassItem new acceptanceTestClass: each ].
	items sort: [ :some :other | some nameInBrowser < other nameInBrowser ].
	^ items
]

{ #category : 'actions' }
HeraFeatureSelector >> addAcceptanceTestClass [

	| dialog modal acceptanceTestClass |
	dialog := HeraAcceptanceTestClassCreationDialog new.
	modal := dialog openModal.
	modal isCancelled ifTrue: [ ^ self ].
	acceptanceTestClass := dialog classCreator createClass.
	self scope addClass: acceptanceTestClass.
	self updateClassesAndFeaturesAfterAddingClass: acceptanceTestClass
]

{ #category : 'private - menus' }
HeraFeatureSelector >> addBrowseGroupTo: parentGroup [
	
		parentGroup addGroupWith: [ :group |
			group
				beDisplayedAsGroup;
				addActionWith: [ :action |
					action	
						name: 'Browse';
						description: 'Browse the selected class or feature.';
						shortcutKey: $b meta;
						actionEnabled: [ self hasSingleSelection ];
						action: [ self browseSelectionInClassesAndFeatures ] ];
				addActionWith: [ :action |
					action	
						name: 'Open in Feature Browser';
						description: 'Open the acceptance classes in another Feature Browser.';
						shortcutKey: $f meta;
						actionEnabled: [ self hasSelection ];
						action: [ self openFeatureBrowserOnSelectedAcceptanceTestClasses ] ]]
]

{ #category : 'actions' }
HeraFeatureSelector >> addFeature [

	| name featureMethod |
	name := [ self
		request: 'Please enter the name of the feature.'
		initialAnswer: 'My awesome feature'
		title: 'New Feature' ]
		on: SpCancelledInteractionError do: [ ^ self ].
	featureMethod := classesAndFeatures selectedItem addFeatureNamed: name.
	self updateClassesAndFeaturesAfterAddingFeatureMethod: featureMethod
]

{ #category : 'private - menus' }
HeraFeatureSelector >> addManagementMenuGroupTo: parentGroup [

	parentGroup
		addActionWith: [ :action |
			action
				name: 'New acceptance test class…';
				description: 'Add a new class to hold features.';
				shortcutKey: $n meta;
				action: [ self addAcceptanceTestClass ] ];
		addActionWith: [ :action |
			action
				name: 'New feature…';
				description: 'Add a new feature.';
				shortcutKey: $n meta shift;
				action: [ self addFeature ];
				actionEnabled: [ self hasSingleSelection ] ];
		addActionWith: [ :action |
			action		
				name: 'Remove';
				description: 'Remove the selected class or feature.';
				actionEnabled: [ self hasSingleSelection ];
				action: [ self removeSelectionInClassesAndFeatures ] ]
]

{ #category : 'private - menus' }
HeraFeatureSelector >> addRunMenuGroupTo: parentGroup [

		parentGroup addGroupWith: [ :group |
			group
				beDisplayedAsGroup;
				addActionWith: [ :action |
					action		
						name: 'Run';
						description: 'Run selected features';
						shortcutKey: $r meta;
						actionEnabled: [ self hasSelection ];
						action: [ self runSelectedFeatures ] ];
				addActionWith: [ :action |
					action		
						name: 'Step';
						description: 'Run selected features step by step';
						shortcutKey: $r meta shift;
						actionEnabled: [ self hasSelection ];
						action: [ self stepSelectedFeatures ] ];
				addActionWith: [ :action |
					action		
						name: 'Debug';
						description: 'Run selected features in debug mode';
						shortcutKey: $d meta;
						actionEnabled: [ self hasSelection ];
						action: [ self debugSelectedFeatures ] ] ]
]

{ #category : 'actions' }
HeraFeatureSelector >> browseSelectionInClassesAndFeatures [

	classesAndFeatures selectedItem browse
]

{ #category : 'actions' }
HeraFeatureSelector >> browseSteps [

	HeraStepBrowser new
		scope: self scope;
		open
]

{ #category : 'test api' }
HeraFeatureSelector >> clickDebugButton [

	debugSelectedFeaturesButton performAction
]

{ #category : 'test api' }
HeraFeatureSelector >> clickRunButton [

	runSelectedFeaturesButton performAction
]

{ #category : 'test api' }
HeraFeatureSelector >> clickStepByStepButton [

	stepSelectedFeaturesButton performAction
]

{ #category : 'initialization' }
HeraFeatureSelector >> connectPresenters [

	classesAndFeatures
		children: [ :item | item subitems ];
		display: [ :item | item nameInBrowser ];
		whenSelectionChangedDo: [ :selection | self featureSelectionChanged ].
	self installContextMenu
]

{ #category : 'actions' }
HeraFeatureSelector >> debugSelectedFeatures [

	(self instantiate: HeraRunner)
		open;
		debugScope: self runnerScopeForSelectedFeatures
]

{ #category : 'layout' }
HeraFeatureSelector >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		spacing: 5;
		add: toolbar height: 24;
		add: classesAndFeatures;
		yourself
]

{ #category : 'test api' }
HeraFeatureSelector >> displayedTreeItems [

	| items |
	items := classesAndFeatures roots collect: [ :each |
		each nameInBrowser -> ((classesAndFeatures childrenFor: each) collect: #nameInBrowser) ].
	^ items asArray
]

{ #category : 'private' }
HeraFeatureSelector >> featureSelectionChanged [

	featureSelectionChangedBlock value: classesAndFeatures selectedItem.
	self updateAfterSelectionChange
]

{ #category : 'layout' }
HeraFeatureSelector >> globalToolbar [

	| manageGroup browseGroup runGroup |
	manageGroup := SpBoxLayout newLeftToRight
		spacing: 10;
		add: addAcceptanceTestClassButton width: 40;
		add: addFeatureButton width: 40;
		add: browseStepsButton width: 40;
		add: browseButton width: 40;
		yourself.
	runGroup := SpBoxLayout newLeftToRight
		spacing: 10;
		add: runSelectedFeaturesButton width: 40;
		add: stepSelectedFeaturesButton width: 40;
		add: debugSelectedFeaturesButton width: 40;
		add: runAllFeaturesButton width: 40;
		yourself.
	browseGroup := SpBoxLayout newLeftToRight
		spacing: 10;
		add: saveFeaturesButton width: 40;
		add: documentationButton width: 40;
		yourself.
	^ SpBoxLayout newLeftToRight
		add: manageGroup width: 220;
		add: runGroup width: 220;
		add: browseGroup;
		yourself
]

{ #category : 'test api' }
HeraFeatureSelector >> hasNoFeatures [

	^ classesAndFeatures roots isEmpty
]

{ #category : 'private' }
HeraFeatureSelector >> hasSelectedFeature [

	^ classesAndFeatures selectedItem isMemberOf: HeraFeatureMethodItem
]

{ #category : 'private' }
HeraFeatureSelector >> hasSelection [

	^ classesAndFeatures selectedItems isNotEmpty
]

{ #category : 'private' }
HeraFeatureSelector >> hasSingleSelection [

	^ classesAndFeatures selectedItems size = 1
]

{ #category : 'initialization' }
HeraFeatureSelector >> initializeGlobalToolbarButtons [

	addAcceptanceTestClassButton := self newButton
		help: 'Add acceptance test class';
		iconName: #add;
		action: [ self addAcceptanceTestClass ];
		yourself.
	addFeatureButton := self newButton
		help: 'Add feature';
		icon: (Hera settings iconNamed: #addFeature);
		action: [ self addFeature ];
		yourself.
	browseStepsButton := self newButton
		help: 'Browse steps';
		icon: (Hera settings iconNamed: #book);
		action: [ self browseSteps ];
		yourself.
	browseButton := self newButton
		help: 'Browse selected class or feature';
		iconName: #nautilus;
		action: [ self browseSelectionInClassesAndFeatures ];
		yourself.
	runSelectedFeaturesButton := self newButton
		help: 'Run selected features';
		icon: (Hera settings iconNamed: #run);
		action: [ self runSelectedFeatures ];
		yourself.
	stepSelectedFeaturesButton := self newButton
		help: 'Step selected features';
		icon: (Hera settings iconNamed: #runAndPause);
		action: [ self stepSelectedFeatures ];
		yourself.
	debugSelectedFeaturesButton := self newButton
		help: 'Debug selected features';
		iconName: #bug;
		action: [ self debugSelectedFeatures ];
		yourself.
	runAllFeaturesButton := self newButton
		help: 'Run all features';
		icon: (Hera settings iconNamed: #runAll);
		action: [ self runAllFeatures ];
		yourself.
	saveFeaturesButton := self newButton
		help: 'Save features';
		icon: (Hera settings iconNamed: #saveFeatures);
		action: [ self saveFeatures ];
		yourself.
	documentationButton := self newButton
		help: 'Documentation & examples';
		icon: (Hera settings iconNamed: #help);
		action: [ self openDocumentation ];
		yourself
]

{ #category : 'initialization' }
HeraFeatureSelector >> initializePresenters [

	featureSelectionChangedBlock := [ :feaureMethodItem | ].
	self initializeGlobalToolbarButtons.
	self initializeToolbar.
	classesAndFeatures := self newTree beMultipleSelection
]

{ #category : 'initialization' }
HeraFeatureSelector >> initializeToolbar [

	toolbar := self instantiate: HeraToolbar
]

{ #category : 'private - menus' }
HeraFeatureSelector >> installContextMenu [

	classesAndFeatures
		actionsWith: [ :rootGroup |
			self addManagementMenuGroupTo: rootGroup.
			self addRunMenuGroupTo: rootGroup.
			self addBrowseGroupTo: rootGroup ]
]

{ #category : 'test api' }
HeraFeatureSelector >> isAddAcceptanceTestClassButtonEnabled [

	^ addAcceptanceTestClassButton isEnabled
]

{ #category : 'test api' }
HeraFeatureSelector >> isAddFeatureButtonEnabled [

	^ addFeatureButton isEnabled
]

{ #category : 'test api' }
HeraFeatureSelector >> isBrowseStepsButtonEnabled [

	^ browseStepsButton isEnabled
]

{ #category : 'test api' }
HeraFeatureSelector >> isDebugSelectedFeaturesButtonEnabled [

	^ debugSelectedFeaturesButton isEnabled
]

{ #category : 'test api' }
HeraFeatureSelector >> isRunAllFeaturesButtonEnabled [

	^ runAllFeaturesButton isEnabled
]

{ #category : 'test api' }
HeraFeatureSelector >> isRunSelectedFeaturesButtonEnabled [

	^ runSelectedFeaturesButton isEnabled
]

{ #category : 'test api' }
HeraFeatureSelector >> isStepSelectedFeaturesButtonEnabled [

	^ stepSelectedFeaturesButton isEnabled
]

{ #category : 'actions' }
HeraFeatureSelector >> openDocumentation [

	| documentationBrowser |
	documentationBrowser := self application openFeatureBrowserOnScope: (HeraScope new addClass: HeraSpecExamplesAcceptanceTest).
	documentationBrowser windowTitle: 'Documentation & examples'
]

{ #category : 'actions' }
HeraFeatureSelector >> openFeatureBrowserOnSelectedAcceptanceTestClasses [

	| acceptanceTestClasses |
	acceptanceTestClasses := (classesAndFeatures selectedItems collect: [ :each | each acceptanceTestClass ]) asSet.
	self application openFeatureBrowserOnScope: (HeraScope new addClasses: acceptanceTestClasses)
]

{ #category : 'actions' }
HeraFeatureSelector >> removeSelectionInClassesAndFeatures [

	| selectedItem |
	selectedItem := classesAndFeatures selectedItem.
	(self confirm: selectedItem removalConfirmationQuestion) ifFalse: [ ^ self ].
	selectedItem removeFromScope: self scope.
	selectedItem remove.
	self updateClassesAndFeatures
]

{ #category : 'actions' }
HeraFeatureSelector >> runAllFeatures [

	(self instantiate: HeraRunner)
		open;
		runScope: self scope asRunnerScope
]

{ #category : 'actions' }
HeraFeatureSelector >> runSelectedFeatures [

	(self instantiate: HeraRunner)
		open;
		runScope: self runnerScopeForSelectedFeatures
]

{ #category : 'private' }
HeraFeatureSelector >> runnerScopeForSelectedFeatures [

	| acceptanceTests selectedItems |
	selectedItems := classesAndFeatures selection selectedItems.
	selectedItems ifEmpty: [ ^ self scope asRunnerScope ].
	acceptanceTests := selectedItems flatCollect: [ :each | each acceptanceTests ].
	^ HeraRunnerScope withAll: acceptanceTests
]

{ #category : 'actions' }
HeraFeatureSelector >> saveFeatures [
	"Let the user select a root folder and save all features in separate .feature files, organized in folders per acceptance test class."

	| folderReference |
	folderReference := self application newOpenFile 
		title: 'Choose a folder to save the features';
		beOpenDirectory;
		openModal.
	folderReference ifNil: [ ^ self ].
	HeraFeatureExporter new
		scope: self scope;
		exportFeaturesTo: folderReference
]

{ #category : 'accessing' }
HeraFeatureSelector >> scope [

	^ scope ifNil: [ scope := HeraScope default ]
]

{ #category : 'accessing' }
HeraFeatureSelector >> scope: aScope [

	scope := aScope
]

{ #category : 'test api' }
HeraFeatureSelector >> selectAcceptanceTestClassNamed: classNameInBrowser [

	| items classIndex |
	items := self displayedTreeItems.
	classIndex := classesAndFeatures roots detectIndex: [ :classItem | classItem nameInBrowser = classNameInBrowser ].
	self selectPaths: { { classIndex } }
]

{ #category : 'test api' }
HeraFeatureSelector >> selectFeature: featureTitle in: classNameInBrowser [

	| items classIndex featureIndex |
	items := self displayedTreeItems.
	classIndex := classesAndFeatures roots detectIndex: [ :classItem | classItem nameInBrowser = classNameInBrowser ].
	featureIndex := (classesAndFeatures childrenFor: (classesAndFeatures roots at: classIndex)) detectIndex: [ :featureItem | featureItem nameInBrowser = featureTitle ].
	self selectPaths: { { classIndex . featureIndex } }
]

{ #category : 'test api' }
HeraFeatureSelector >> selectPaths: pathArray [

	^ classesAndFeatures selectPaths: pathArray
]

{ #category : 'accessing' }
HeraFeatureSelector >> selectedItem [

	^ classesAndFeatures selectedItem
]

{ #category : 'initialization' }
HeraFeatureSelector >> setupAfterOpening [

	classesAndFeatures 
		roots: self acceptanceTestClassItems;
		expandAll.
	self updateAfterSelectionChange
]

{ #category : 'actions' }
HeraFeatureSelector >> stepSelectedFeatures [

	(self instantiate: HeraRunner)
		open;
		stepScope: self runnerScopeForSelectedFeatures
]

{ #category : 'private' }
HeraFeatureSelector >> updateAfterSelectionChange [

	| hasSelection |
	addFeatureButton enabled: self hasSingleSelection.
	hasSelection := self hasSelection.
	browseButton enabled: hasSelection.
	runSelectedFeaturesButton enabled: hasSelection.
	stepSelectedFeaturesButton enabled: hasSelection.
	debugSelectedFeaturesButton enabled: hasSelection
]

{ #category : 'private' }
HeraFeatureSelector >> updateClassesAndFeatures [

	classesAndFeatures
		roots: self acceptanceTestClassItems;
		expandAll
]

{ #category : 'private' }
HeraFeatureSelector >> updateClassesAndFeaturesAfterAddingClass: acceptanceTestClass [

	self flag: 'Brute force update for now. Better: insert acceptanceTestClass.'.
	self updateClassesAndFeatures.
	classesAndFeatures selection selectItem: (HeraAcceptanceTestClassItem new acceptanceTestClass: acceptanceTestClass)
]

{ #category : 'private' }
HeraFeatureSelector >> updateClassesAndFeaturesAfterAddingFeatureMethod: featureMethod [

	self flag: 'Brute force update for now. Better: insert featureMethod.'.
	self updateClassesAndFeatures.
	classesAndFeatures selection selectItem: (HeraFeatureMethodItem new acceptanceTestClass: featureMethod methodClass; featureMethodSelector: featureMethod selector)
]

{ #category : 'api' }
HeraFeatureSelector >> whenFeatureSelectionChangedDo: aBlock [

	featureSelectionChangedBlock := aBlock
]
