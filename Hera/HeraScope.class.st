Class {
	#name : 'HeraScope',
	#superclass : 'Object',
	#instVars : [
		'acceptanceTestClasses'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HeraScope class >> all [

	^ self new addHierarchy: HeraAcceptanceTest
]

{ #category : 'instance creation' }
HeraScope class >> default [

	| testingClasses |
	testingClasses := HeraAcceptanceTest allSubclasses select: [ :each |
		each isForTestingHera or: [ each isForTestingPharo or: [ each isHeraExample ]] ].
	^ self all
		removeClasses: testingClasses;
		removeClass: HeraSpecAcceptanceTest;
		removeClass: HeraWebAcceptanceTest 
]

{ #category : 'accessing' }
HeraScope >> addClass: aClass [

	acceptanceTestClasses add: aClass
]

{ #category : 'accessing' }
HeraScope >> addClasses: classes [

	acceptanceTestClasses addAll: classes
]

{ #category : 'accessing' }
HeraScope >> addHierarchy: aClass [

	self addClasses: aClass allSubclasses
]

{ #category : 'accessing' }
HeraScope >> allForBrowsing [

	^ acceptanceTestClasses sorted: [ :some :other | some name <= other name ]
]

{ #category : 'accessing' }
HeraScope >> allStepMethods [

	| classes |
	classes := Set new.
	acceptanceTestClasses do: [ :each | self collectAcceptanceTestSuperclassesOf: each in: classes ].
	classes addAll: acceptanceTestClasses.
	^ classes asOrderedCollection flatCollect: [ :each | each stepMethods ]
]

{ #category : 'private' }
HeraScope >> collectAcceptanceTestSuperclassesOf: aClass in: aSet [

	| superclass |
	superclass := aClass superclass.
	aSet add: superclass.
	superclass == HeraAcceptanceTest ifTrue: [ ^ self ].
	self collectAcceptanceTestSuperclassesOf: superclass in: aSet
]

{ #category : 'enumerating' }
HeraScope >> do: aBlock separatedBy: separatorBlock [

	self sortedAcceptanceTestClasses do: aBlock separatedBy: separatorBlock
]

{ #category : 'initialization' }
HeraScope >> initialize [

	super initialize.
	acceptanceTestClasses := Set new
]

{ #category : 'accessing' }
HeraScope >> removeClass: aClass [

	acceptanceTestClasses remove: aClass
]

{ #category : 'accessing' }
HeraScope >> removeClasses: classes [

	acceptanceTestClasses removeAll: classes
]

{ #category : 'accessing' }
HeraScope >> removeHierarchy: aClass [

	self removeClasses: aClass allSubclasses
]

{ #category : 'accessing' }
HeraScope >> sortedAcceptanceTestClasses [

	^ acceptanceTestClasses sorted: [ :some :other | some name < other name ]
]
