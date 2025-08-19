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
		'runAllFeaturesButton'
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
						actionEnabled: [ self hasSelectedClassOrFeature ];
						action: [ self browseSelectionInClassesAndFeatures ] ] ]
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
				actionEnabled: [ self hasSelectedClassOrFeature ] ];
		addActionWith: [ :action |
			action		
				name: 'Remove';
				description: 'Remove the selected class or feature.';
				actionEnabled: [ self hasSelectedClassOrFeature ];
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
						description: 'Run the selected feature';
						shortcutKey: $r meta;
						actionEnabled: [ self hasSelectedFeature ];
						action: [ self runFeature ] ];
				addActionWith: [ :action |
					action		
						name: 'Step';
						description: 'Run the selected feature step by step';
						shortcutKey: $r meta shift;
						actionEnabled: [ self hasSelectedFeature ];
						action: [ self stepFeature ] ];
				addActionWith: [ :action |
					action		
						name: 'Debug';
						description: 'Run the selected feature in debug mode';
						shortcutKey: $d meta;
						actionEnabled: [ self hasSelectedFeature ];
						action: [ self debugFeature ] ] ]
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

{ #category : 'initialization' }
HeraFeatureSelector >> connectPresenters [

	classesAndFeatures
		children: [ :item | item subitems ];
		display: [ :item | item nameInBrowser ];
		whenSelectionChangedDo: [ :selection | self featureSelectionChanged ].
	self installContextMenu
]

{ #category : 'actions' }
HeraFeatureSelector >> debugFeature [

	(self instantiate: HeraRunner)
		open;
		debugAcceptanceTest: classesAndFeatures selectedItem acceptanceTest
]

{ #category : 'layout' }
HeraFeatureSelector >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		spacing: 5;
		add: self toolbar expand: false;
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

{ #category : 'test api' }
HeraFeatureSelector >> hasNoFeatures [

	^ classesAndFeatures roots isEmpty
]

{ #category : 'private' }
HeraFeatureSelector >> hasSelectedClassOrFeature [

	^ classesAndFeatures selectedItem isNotNil
]

{ #category : 'private' }
HeraFeatureSelector >> hasSelectedFeature [

	^ classesAndFeatures selectedItem isMemberOf: HeraFeatureMethodItem
]

{ #category : 'initialization' }
HeraFeatureSelector >> initializePresenters [

	featureSelectionChangedBlock := [ :feaureMethodItem | ].
	self initializeToolbarButtons.
	classesAndFeatures := self newTree
]

{ #category : 'initialization' }
HeraFeatureSelector >> initializeToolbarButtons [

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
	runAllFeaturesButton := self newButton
		help: 'Run all features';
		icon: (Hera settings iconNamed: #runAll);
		action: [ self runAllFeatures ];
		yourself.
	browseStepsButton := self newButton
		help: 'Browse steps';
		icon: (Hera settings iconNamed: #book);
		action: [ self browseSteps ];
		yourself
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
]

{ #category : 'actions' }
HeraFeatureSelector >> runFeature [

	(self instantiate: HeraRunner)
		open;
		runAcceptanceTest: classesAndFeatures selectedItem acceptanceTest
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
HeraFeatureSelector >> selectFeature: featureTitle in: classNameInBrowser [

	| items classIndex featureIndex |
	items := self displayedTreeItems.
	classIndex := classesAndFeatures roots detectIndex: [ :classItem | classItem nameInBrowser = classNameInBrowser ].
	featureIndex := (classesAndFeatures childrenFor: (classesAndFeatures roots at: classIndex)) detectIndex: [ :featureItem | featureItem nameInBrowser = featureTitle ].
	self selectPath: { classIndex . featureIndex }
]

{ #category : 'test api' }
HeraFeatureSelector >> selectPath: anArray [

	^ classesAndFeatures selectPath: anArray
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
HeraFeatureSelector >> stepFeature [

	(self instantiate: HeraRunner)
		open;
		stepAcceptanceTest: classesAndFeatures selectedItem acceptanceTest
]

{ #category : 'layout' }
HeraFeatureSelector >> toolbar [

	| manageGroup browseGroup runGroup |
	manageGroup := SpBoxLayout newLeftToRight
		spacing: 10;
		add: addAcceptanceTestClassButton width: 40;
		add: addFeatureButton width: 40;
		yourself.
	runGroup := SpBoxLayout newLeftToRight
		spacing: 10;
		add: runAllFeaturesButton width: 40;
		yourself.
	browseGroup := SpBoxLayout newLeftToRight
		spacing: 10;
		add: browseStepsButton width: 40;
		yourself.
	^ SpBoxLayout newLeftToRight
		add: manageGroup width: 120;
		add: runGroup width: 70;
		add: browseGroup;
		yourself
]

{ #category : 'private' }
HeraFeatureSelector >> updateAfterSelectionChange [

	| enabled selectedItem |
	selectedItem := classesAndFeatures selectedItem.
	enabled := selectedItem ifNil: [ false ] ifNotNil: [ :browserItem | browserItem isRunnable ].
	addFeatureButton enabled: selectedItem isNotNil
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
