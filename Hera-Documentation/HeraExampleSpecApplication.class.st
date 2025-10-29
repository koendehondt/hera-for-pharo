"
I am the example spec application used in the Hera documentation.
"
Class {
	#name : 'HeraExampleSpecApplication',
	#superclass : 'SpPresenter',
	#instVars : [
		'familyTree',
		'childrenList'
	],
	#category : 'Hera-Documentation-Example Spec Application',
	#package : 'Hera-Documentation',
	#tag : 'Example Spec Application'
}

{ #category : 'initialization' }
HeraExampleSpecApplication >> connectPresenters [

	familyTree whenSelectedItemChangedDo: [ :selectedPerson |
		childrenList items: selectedPerson children ]
]

{ #category : 'layout' }
HeraExampleSpecApplication >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		add: familyTree;
		add: childrenList;
		yourself
]

{ #category : 'private - family' }
HeraExampleSpecApplication >> focusPerson [

	^ (HeraExamplePerson new name: 'John')
		addChild: ((HeraExamplePerson new name: 'Jane')
			addChild: (HeraExamplePerson new name: 'William');
			yourself);
		addChild: (HeraExamplePerson new name: 'Mary');
		yourself
]

{ #category : 'hera' }
HeraExampleSpecApplication >> heraWidgetAt: aWidgetName ifAbsent: absentBlock [

	| mapping |
	mapping := Dictionary new
		add: 'Family' -> familyTree;
		add: 'Children' -> childrenList;
		yourself.
	^ mapping at: aWidgetName ifAbsent: absentBlock
]

{ #category : 'initialization' }
HeraExampleSpecApplication >> initializePresenters [

	familyTree := self newTree
		roots: { self focusPerson };
		children: [ :person | person children ];
		display: [ :person | person name ];
		yourself.
	childrenList := self newList
		display: [ :person | person name ];
		yourself
]

{ #category : 'accessing' }
HeraExampleSpecApplication >> windowTitle [

	^ 'Family tree'
]
