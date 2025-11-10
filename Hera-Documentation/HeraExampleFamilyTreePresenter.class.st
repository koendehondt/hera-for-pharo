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
		'noPersonDetails'
	],
	#category : 'Hera-Documentation-Example Spec Application',
	#package : 'Hera-Documentation',
	#tag : 'Example Spec Application'
}

{ #category : 'initialization' }
HeraExampleFamilyTreePresenter >> connectPresenters [

	familyTree whenSelectedItemChangedDo: [ :selectedPerson | self updatePersonDetails: selectedPerson ]
]

{ #category : 'layout' }
HeraExampleFamilyTreePresenter >> defaultLayout [

	^ SpPanedLayout newLeftToRight
		positionOfSlider: 1/2;
		add: familyTree;
		add: noPersonDetails;
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
	familyTree roots: { aPerson }
]

{ #category : 'hera' }
HeraExampleFamilyTreePresenter >> heraPresenterAt: aPresenterName ifAbsent: absentBlock [

	^ personDetails heraPresenterAt: aPresenterName ifAbsent: [ | mapping |
		mapping := Dictionary new
			add: 'Family' -> familyTree;
			yourself.
		mapping at: aPresenterName ifAbsent: absentBlock ]
]

{ #category : 'initialization' }
HeraExampleFamilyTreePresenter >> initializePresenters [

	familyTree := self newTree
		roots: (self focusPerson ifNil: [ #() ] ifNotNil: [ { self focusPerson } ]);
		children: [ :person | person children ];
		display: [ :person | person name ];
		yourself.
	personDetails := self instantiate: HeraExamplePersonDetailsPresenter.
	noPersonDetails := self instantiate: HeraExampleNoPersonDetailsPresenter
]

{ #category : 'initialization' }
HeraExampleFamilyTreePresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenOpenedDo: [
		familyTree eventHandler whenDoubleClickDo: [ :event | self doubleClickInFamilyTree ] ]
]

{ #category : 'accessing' }
HeraExampleFamilyTreePresenter >> selectedPerson [

	^ familyTree selectedItem
]

{ #category : 'initialization' }
HeraExampleFamilyTreePresenter >> updatePersonDetails: selectedPerson [

	| noDetailsBefore noDetailsAfter |
	noDetailsBefore := personDetails person isNil.
	noDetailsAfter := selectedPerson isNil.
	personDetails model: selectedPerson.
	noDetailsBefore = noDetailsAfter ifTrue: [ ^ self ].
	noDetailsBefore
		ifTrue: [ self layout replaceSecond: personDetails ]
		ifFalse: [ self layout replaceSecond: noPersonDetails ]
]

{ #category : 'accessing' }
HeraExampleFamilyTreePresenter >> windowTitle [

	^ self focusPerson
		ifNil: [ 'Family tree' ]
		ifNotNil: [ :person | 'Family tree of {1}' format: { person name } ]
]
