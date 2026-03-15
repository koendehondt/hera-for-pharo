"
I am the example spec application used in the Hera documentation.
"
Class {
	#name : 'HeraExampleFamilyTreePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'familyTree',
		'focusPerson',
		'personDetails',
		'noPersonDetails',
		'addButton',
		'removeButton',
		'familyPane',
		'buttonBar'
	],
	#category : 'Hera-Documentation-Family Tree - Application',
	#package : 'Hera-Documentation',
	#tag : 'Family Tree - Application'
}

{ #category : 'actions' }
HeraExampleFamilyTreePresenter >> addChildToSelectedPerson [
	"Add a person as a child of the selected person.
	 If there is no selected person and the familty tree is empty, add the root person to the family tree.
	 Keep all expanded family members expanded.
	 Select the added person."

	| person expandedItems |
	person := HeraExamplePerson new name: 'Unknown'.
	self selectedPerson
		ifNil: [ self focusPerson: person ]
		ifNotNil: [
			self selectedPerson addChild: person.
			expandedItems := OrderedCollection new.
			familyTree roots do: [ :root |
				self collectExpandedFamilyMembersFrom: (OrderedCollection with: root) in: expandedItems ].
			familyTree roots: familyTree roots.
			expandedItems do: [ :personPath | familyTree expandPath: personPath ] ].
	familyTree selectItem: person.
	personDetails focusNameField
]

{ #category : 'private' }
HeraExampleFamilyTreePresenter >> collectExpandedFamilyMembersFrom: memberPath in: collection [

	| memberIndexPath |
	memberIndexPath := familyTree pathIndexOf: memberPath.
	(familyTree isExpanded: memberIndexPath) ifFalse: [ ^ self ].
	collection add: memberIndexPath.
	(familyTree childrenFor: memberPath last) do: [ :child |
		memberPath add: child.
		self collectExpandedFamilyMembersFrom: memberPath in: collection.
		memberPath removeLast ]
]

{ #category : 'initialization' }
HeraExampleFamilyTreePresenter >> connectPersonDetails [

	personDetails whenNameChangedDo: [ :name |
		self updateSelectedPersonInTree.
		self updateWindowTitle ]
]

{ #category : 'initialization' }
HeraExampleFamilyTreePresenter >> connectPresenters [

	familyTree whenSelectedItemChangedDo: [ :selectedPerson |
		self updatePersonDetails: selectedPerson.
		self updateButtonBar: selectedPerson ]
]

{ #category : 'layout' }
HeraExampleFamilyTreePresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		spacing: 20;
		add: buttonBar expand: false;
		add: familyPane;
		yourself
]

{ #category : 'events' }
HeraExampleFamilyTreePresenter >> doubleClickInFamilyTree [

	self class new
		focusPerson: familyTree selectedItem;
		open
]

{ #category : 'accessing' }
HeraExampleFamilyTreePresenter >> focusPerson [

	^ focusPerson
]

{ #category : 'accessing' }
HeraExampleFamilyTreePresenter >> focusPerson: aPerson [

	focusPerson := aPerson.
	focusPerson
		ifNil: [ familyTree roots: { } ]
		ifNotNil: [ familyTree roots: { aPerson } ].
	self updateWindowTitle
]

{ #category : 'testing' }
HeraExampleFamilyTreePresenter >> hasSelectedPerson [

	^ familyTree selectedPerson isNotNil
]

{ #category : 'hera - api' }
HeraExampleFamilyTreePresenter >> heraPresenterAt: aPresenterName ifAbsent: absentBlock [

	| mapping |
	mapping := Dictionary new
		add: 'Family' -> familyTree;
		add: 'Add' -> addButton;
		add: 'Remove' -> removeButton;
		yourself.
	^ mapping at: aPresenterName ifAbsent: [ | currentDetails |
		currentDetails := familyPane children second.
		currentDetails heraPresenterAt: aPresenterName ifAbsent: absentBlock ]
]

{ #category : 'initialization' }
HeraExampleFamilyTreePresenter >> initializePresenters [

	familyTree := self newTree
		roots: (self focusPerson ifNil: [ #() ] ifNotNil: [ { self focusPerson } ]);
		children: [ :person | person children ];
		display: [ :person | person name ];
		yourself.
	noPersonDetails := self instantiate: HeraExampleNoPersonDetailsPresenter.
	familyPane := SpPanedLayout newLeftToRight
		positionOfSlider: 1/2;
		add: familyTree;
		add: noPersonDetails;
		yourself.
	addButton := self newButton
		label: 'Add';
		iconName: #add;
		action: [ self addChildToSelectedPerson ];
		yourself.
	removeButton := self newButton
		label: 'Remove';
		iconName: #remove;
		action: [ self removeSelectedPerson ];
		yourself.
	buttonBar := SpBoxLayout newLeftToRight
		spacing: 10;
		hAlignStart;
		add: addButton;
		add: removeButton;
		yourself
]

{ #category : 'initialization' }
HeraExampleFamilyTreePresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	self updateButtonBar: self selectedPerson.
	aWindowPresenter whenOpenedDo: [
		familyTree eventHandler whenDoubleClickDo: [ :event | self doubleClickInFamilyTree ] ]
]

{ #category : 'actions' }
HeraExampleFamilyTreePresenter >> removeSelectedPerson [

	| personPath parentPath parent selectedPerson expandedItems |
	personPath := familyTree selection selectedPath.
	selectedPerson := (familyTree pathItemOf: personPath) last.
	parentPath := personPath allButLast.
	parentPath isEmpty
		ifTrue: [
			self focusPerson: nil ]
		ifFalse: [
			parent := (familyTree pathItemOf: parentPath) first.
			parent removeChild: selectedPerson.
			expandedItems := OrderedCollection new.
			familyTree roots do: [ :root |
				self collectExpandedFamilyMembersFrom: (OrderedCollection with: root) in: expandedItems ].
			expandedItems := expandedItems reject: [ :expandedPath | (expandedPath indexOfSubCollection: personPath startingAt: 1) = 1 ].
			familyTree roots: familyTree roots.
			expandedItems do: [ :expandedPath | familyTree expandPath: expandedPath ].
			familyTree selectItem: parent ]
]

{ #category : 'accessing' }
HeraExampleFamilyTreePresenter >> selectedPerson [

	^ familyTree selectedItem
]

{ #category : 'updating' }
HeraExampleFamilyTreePresenter >> updateButtonBar: selectedPerson [

	| hasSelectedPerson |
	hasSelectedPerson := selectedPerson isNotNil.
	addButton enabled: (hasSelectedPerson or: [ familyTree roots isEmpty ]).
	removeButton enabled: hasSelectedPerson.
]

{ #category : 'updating' }
HeraExampleFamilyTreePresenter >> updatePersonDetails: selectedPerson [

	selectedPerson
		ifNil: [ familyPane replaceSecond: noPersonDetails ]
		ifNotNil: [
				personDetails := self instantiate: HeraExamplePersonDetailsPresenter.
				familyPane replaceSecond: personDetails.
				personDetails person: selectedPerson.
				self connectPersonDetails ]
]

{ #category : 'updating' }
HeraExampleFamilyTreePresenter >> updateSelectedPersonInTree [

	familyTree refresh
]

{ #category : 'updating' }
HeraExampleFamilyTreePresenter >> updateWindowTitle [

	self withWindowDo: [ :window | window title: self windowTitle ]
]

{ #category : 'accessing' }
HeraExampleFamilyTreePresenter >> windowTitle [

	^ self focusPerson
		ifNil: [ 'Family tree' ]
		ifNotNil: [ :person | 'Family tree of {1}' format: { person name } ]
]
