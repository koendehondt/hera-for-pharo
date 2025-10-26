Class {
	#name : 'HeraExampleSpecApplication',
	#superclass : 'SpPresenter',
	#instVars : [
		'familyTree'
	],
	#category : 'Hera-Documentation-Example Spec Application',
	#package : 'Hera-Documentation',
	#tag : 'Example Spec Application'
}

{ #category : 'layout' }
HeraExampleSpecApplication >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		add: familyTree;
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
		yourself.
	^ mapping at: aWidgetName ifAbsent: absentBlock
]

{ #category : 'initialization' }
HeraExampleSpecApplication >> initializePresenters [

	familyTree := self newTree
		roots: { self focusPerson };
		children: [ :person | person children ];
		display: [ :person | person name ];
		yourself
]

{ #category : 'accessing' }
HeraExampleSpecApplication >> windowTitle [

	^ 'Family tree'
]
