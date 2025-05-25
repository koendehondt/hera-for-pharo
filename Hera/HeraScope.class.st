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

	^ self new includeHierarchy: HeraAcceptanceTest
]

{ #category : 'instance creation' }
HeraScope class >> default [

	| testingClasses |
	testingClasses := HeraAcceptanceTest allSubclasses select: [ :each | each isForTestingHera ].
	^ self all excludeClasses: testingClasses
]

{ #category : 'accessing' }
HeraScope >> allForBrowsing [

	^ acceptanceTestClasses sorted: [ :some :other | some name <= other name ]
]

{ #category : 'accessing' }
HeraScope >> allStepMethods [

	^ self allForBrowsing flatCollect: [ :each | each stepMethods ]
]

{ #category : 'enumerating' }
HeraScope >> do: aBlock separatedBy: separatorBlock [

	self sortedAcceptanceTestClasses do: aBlock separatedBy: separatorBlock
]

{ #category : 'accessing' }
HeraScope >> excludeClass: aClass [

	acceptanceTestClasses remove: aClass
]

{ #category : 'accessing' }
HeraScope >> excludeClasses: classes [

	acceptanceTestClasses removeAll: classes
]

{ #category : 'accessing' }
HeraScope >> excludeHierarchy: aClass [

	self excludeClasses: aClass allSubclasses
]

{ #category : 'accessing' }
HeraScope >> includeClass: aClass [

	acceptanceTestClasses add: aClass
]

{ #category : 'accessing' }
HeraScope >> includeClasses: classes [

	acceptanceTestClasses addAll: classes
]

{ #category : 'accessing' }
HeraScope >> includeHierarchy: aClass [

	self includeClasses: aClass allSubclasses
]

{ #category : 'initialization' }
HeraScope >> initialize [

	super initialize.
	acceptanceTestClasses := Set new
]

{ #category : 'accessing' }
HeraScope >> sortedAcceptanceTestClasses [

	^ acceptanceTestClasses sorted: [ :some :other | some name < other name ]
]
