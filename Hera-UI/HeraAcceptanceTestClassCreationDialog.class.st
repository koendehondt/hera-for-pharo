Class {
	#name : 'HeraAcceptanceTestClassCreationDialog',
	#superclass : 'SpPresenter',
	#instVars : [
		'classNameField',
		'superclassTree',
		'packageList',
		'tagList',
		'cancelButton',
		'okButton',
		'message'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'accessing' }
HeraAcceptanceTestClassCreationDialog >> classCreator [

	^ HeraClassCreator new
		targetClassName: classNameField text;
		targetSuperclass: superclassTree selectedItem;
		targetPackage: packageList selectedItem;
		targetTag: tagList selectedItem
]

{ #category : 'accessing' }
HeraAcceptanceTestClassCreationDialog >> clickCancelButton [

	cancelButton click
]

{ #category : 'accessing' }
HeraAcceptanceTestClassCreationDialog >> clickOkButton [

	okButton click
]

{ #category : 'initialization' }
HeraAcceptanceTestClassCreationDialog >> connectPresenters [

	packageList whenSelectionChangedDo: [ :selectionMode | | selectedPackage |
		selectedPackage := selectionMode selectedItem.
		tagList items: (selectedPackage ifNil: [ #() ] ifNotNil: [ self tagsOfPackage: selectedPackage ] ).
		self updateMessageAndOkButton ].
	classNameField whenTextChangedDo: [ :text |
		self updateMessageAndOkButton ]
]

{ #category : 'layout' }
HeraAcceptanceTestClassCreationDialog >> defaultLayout [

	| listsLayout superclassesLayout packagesLayout tagsLayout buttonBarLayout packagesAndTagsLayout |
	superclassesLayout := SpBoxLayout newTopToBottom
		spacing: 5;
		add: (self newLabel label: 'Superclass:'; yourself) expand: false;
		add: superclassTree;
		yourself.
	packagesLayout := SpBoxLayout newTopToBottom
		spacing: 5;
		add: (self newLabel label: 'Package:'; yourself) expand: false;
		add: packageList;
		yourself.
	tagsLayout := SpBoxLayout newTopToBottom
		spacing: 5;
		add: (self newLabel label: 'Tag:'; yourself) expand: false;
		add: tagList;
		yourself.
	packagesAndTagsLayout := SpPanedLayout newHorizontal
		positionOfSlider: 50 percent;
		add: packagesLayout;
		add: tagsLayout;
		yourself.	
	listsLayout := SpPanedLayout newHorizontal
		positionOfSlider: 33 percent;
		add: superclassesLayout;
		add: packagesAndTagsLayout;
		yourself.	
	buttonBarLayout := SpBoxLayout newLeftToRight
		spacing: 5;
		vAlignCenter;
		add: message;
		add: cancelButton expand: false;
		add: okButton expand: false;
		yourself.
	^ SpBoxLayout newTopToBottom
		spacing: 5;
		add: (self newLabel label: 'Class name:'; yourself) expand: false;
		add: classNameField expand: false;
		add: listsLayout;
		add: buttonBarLayout expand: false;
		yourself
]

{ #category : 'test api' }
HeraAcceptanceTestClassCreationDialog >> enterClassName: aString [

	classNameField text: aString
]

{ #category : 'test api' }
HeraAcceptanceTestClassCreationDialog >> hasDisabledOkButton [

	^ self hasEnabledOkButton not
]

{ #category : 'test api' }
HeraAcceptanceTestClassCreationDialog >> hasEnabledCancelButton [

	^ cancelButton isEnabled
]

{ #category : 'test api' }
HeraAcceptanceTestClassCreationDialog >> hasEnabledOkButton [

	^ okButton isEnabled
]

{ #category : 'initialization' }
HeraAcceptanceTestClassCreationDialog >> initializeDialogWindow: aDialogWindowPresenter [

	aDialogWindowPresenter title: 'Create new acceptance test class'.
	aDialogWindowPresenter whenOpenedDo: [
		superclassTree selectItem: HeraSpecAcceptanceTest.
		classNameField
			takeKeyboardFocus;
			selectionInterval: (1 to: 3).
		self updateMessageAndOkButton ].
	cancelButton action: [
		aDialogWindowPresenter
			beCancel; 
			triggerCancelAction;
			close ].
	okButton action: [
		aDialogWindowPresenter
			beOk; 
			triggerOkAction;
			close ]
]

{ #category : 'initialization' }
HeraAcceptanceTestClassCreationDialog >> initializePresenters [

	classNameField := self newTextInput
		text: 'NewAcceptanceTest';
		yourself.
	superclassTree := self newTree
		roots: { HeraAcceptanceTest };
		children: [ :aNode | aNode subclasses sorted: [ :some :other | some name < other name ] ];
		display: [ :aNode | aNode name ];
		expandRoots;
		yourself.
	packageList := self newFilteringList
		items: self packages;
		display: [ :aNode | aNode name ];
		yourself.
	tagList := self newList
		display: [ :aNode | aNode name ];
		yourself.
	message := self newLabel.
	cancelButton := self newButton
		label: 'Cancel';
		yourself.
	okButton := self newButton
		label: 'OK';
		yourself
]

{ #category : 'test api' }
HeraAcceptanceTestClassCreationDialog >> messageText [

	^ message label
]

{ #category : 'private' }
HeraAcceptanceTestClassCreationDialog >> packages [

	^ Smalltalk packages sorted: [ :some :other | some name < other name ]
]

{ #category : 'test api' }
HeraAcceptanceTestClassCreationDialog >> selectPackageNamed: aString [

	| package |
	package := packageList items detect: [ :each | each name = aString ].
	packageList selectItem: package
]

{ #category : 'test api' }
HeraAcceptanceTestClassCreationDialog >> selectSuperclass: aClass [

	superclassTree selectItem: aClass
]

{ #category : 'test api' }
HeraAcceptanceTestClassCreationDialog >> selectTagNamed: aString [

	| tag |
	tag := tagList items detect: [ :each | each name = aString ].
	tagList selectItem: tag
]

{ #category : 'private' }
HeraAcceptanceTestClassCreationDialog >> tagsOfPackage: aPackage [

	| nonRootTags |
	nonRootTags := aPackage tags reject: [ :each | each isRoot ].
	^ nonRootTags sorted: [ :some :other | some name < other name ]
]

{ #category : 'private' }
HeraAcceptanceTestClassCreationDialog >> updateMessageAndOkButton [

	| isValid text |
	text := ''.
	isValid := true.
	packageList selectedItem ifNil: [
		text := 'Please select a package.'.
		isValid := false ].
	classNameField text
		ifEmpty: [
			text := 'Please enter a name for the acceptance class.'.
			isValid := false ]
		ifNotEmpty: [ :className |
			className isValidGlobalName
				ifTrue: [
					(Smalltalk globals hasClassOrTraitNamed: className)
						ifTrue: [
							text := 'That class name is already taken. Please choose another name.'.
							isValid := false ]]
				ifFalse: [
					text := 'Please enter a valid class name.'.
					isValid := false ] ].
	message label: text.
	okButton enabled: isValid
]
