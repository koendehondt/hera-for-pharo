Class {
	#name : 'HeraFeatureSelector',
	#superclass : 'SpPresenter',
	#instVars : [
		'addAcceptanceTestClassButton',
		'addFeatureButton',
		'runButton',
		'stepByStepButton',
		'debugButton',
		'browseStepsButton',
		'classesAndFeatures',
		'scope',
		'featureSelectionChangedBlock'
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
	self scope includeClass: acceptanceTestClass.
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
						action: [ self run ] ];
				addActionWith: [ :action |
					action		
						name: 'Step';
						description: 'Run the selected feature step by step';
						shortcutKey: $r meta shift;
						actionEnabled: [ self hasSelectedFeature ];
						action: [ self stepByStep ] ];
				addActionWith: [ :action |
					action		
						name: 'Debug';
						description: 'Run the selected feature in debug mode';
						shortcutKey: $d meta;
						actionEnabled: [ self hasSelectedFeature ];
						action: [ self debug ] ] ]
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

	debugButton performAction
]

{ #category : 'test api' }
HeraFeatureSelector >> clickRunButton [

	runButton performAction
]

{ #category : 'test api' }
HeraFeatureSelector >> clickStepByStepButton [

	stepByStepButton performAction
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
HeraFeatureSelector >> debug [

	| runner acceptanceTest featureMethodItem |
	featureMethodItem := classesAndFeatures selectedItem.
	acceptanceTest := featureMethodItem acceptanceTest.
	runner := self instantiate: HeraRunner.
	runner open.
	runner debugAcceptanceTest: acceptanceTest
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
		iconName: #scriptManager;
		action: [ self addFeature ];
		yourself.
	runButton := self newButton
		help: 'Run';
		iconName: #go;
		action: [ self run ];
		yourself.
	stepByStepButton := self newButton
		help: 'Step';
		iconName: #into;
		action: [ self stepByStep ];
		yourself.
	debugButton := self newButton
		help: 'Debug';
		iconName: #bug;
		action: [ self debug ];
		yourself.
	browseStepsButton := self newButton
		help: 'Browse steps';
		iconName: #bookmark;
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
HeraFeatureSelector >> run [

	| runner acceptanceTest featureMethodItem |
	featureMethodItem := classesAndFeatures selectedItem.
	acceptanceTest := featureMethodItem acceptanceTest.
	runner := self instantiate: HeraRunner.
	runner open.
	runner runAcceptanceTest: acceptanceTest
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
HeraFeatureSelector >> stepByStep [

	| runner acceptanceTest featureMethodItem |
	featureMethodItem := classesAndFeatures selectedItem.
	acceptanceTest := featureMethodItem acceptanceTest.
	runner := self instantiate: HeraRunner.
	runner open.
	runner stepAcceptanceTest: acceptanceTest
]

{ #category : 'layout' }
HeraFeatureSelector >> toolbar [

	| manageGroup runGroup browseGroup |
	manageGroup := SpBoxLayout newLeftToRight
		spacing: 10;
		add: addAcceptanceTestClassButton width: 40;
		add: addFeatureButton width: 40;
		yourself.
	runGroup := SpBoxLayout newLeftToRight
		spacing: 10;
		add: runButton width: 40;
		add: stepByStepButton width: 40;
		add: debugButton width: 40;
		yourself.
	browseGroup := SpBoxLayout newLeftToRight
		spacing: 10;
		hAlignEnd;
		add: browseStepsButton width: 40;
		yourself.
	^ SpBoxLayout newLeftToRight
		add: manageGroup width: 120;
		add: runGroup;
		add: browseGroup;
		yourself
]

{ #category : 'private' }
HeraFeatureSelector >> updateAfterSelectionChange [

	| enabled |
	enabled := classesAndFeatures selectedItem ifNil: [ false ] ifNotNil: [ :browserItem | browserItem isRunnable ].
	runButton enabled: enabled.
	stepByStepButton enabled: enabled.
	debugButton enabled: enabled
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
