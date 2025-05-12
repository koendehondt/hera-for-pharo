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

	^ self new
]

{ #category : 'instance creation' }
HeraScope class >> default [

	^ self new
		excludeHierarchy: HeraAcceptanceTestForTesting;
		excludeHierarchy: HeraSelfAcceptanceTest
]

{ #category : 'accessing' }
HeraScope >> allForBrowsing [

	^ acceptanceTestClasses sorted: [ :some :other | some name <= other name ]
]

{ #category : 'accessing' }
HeraScope >> allStepMethods [

	^ self allForBrowsing flatCollect: [ :each | each stepMethods ]
]

{ #category : 'accessing' }
HeraScope >> excludeClass: aClass [

	acceptanceTestClasses remove: aClass
]

{ #category : 'accessing' }
HeraScope >> excludeHierarchy: aClass [

	acceptanceTestClasses removeAll: aClass withAllSubclasses
]

{ #category : 'accessing' }
HeraScope >> includeClass: aClass [

	acceptanceTestClasses add: aClass
]

{ #category : 'accessing' }
HeraScope >> includeHierarchy: aClass [

	acceptanceTestClasses addAll: aClass allSubclasses
]

{ #category : 'initialization' }
HeraScope >> initialize [

	super initialize.
	acceptanceTestClasses := HeraAcceptanceTest allSubclasses asSet.
]
