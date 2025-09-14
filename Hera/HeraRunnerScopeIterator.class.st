Class {
	#name : 'HeraRunnerScopeIterator',
	#superclass : 'Object',
	#instVars : [
		'currentIndex',
		'acceptanceTestClasses'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HeraRunnerScopeIterator class >> on: aRunnerScope [

	^ self new scope: aRunnerScope
]

{ #category : 'enumerating' }
HeraRunnerScopeIterator >> hasNext [

	^ currentIndex + 1 <= acceptanceTestClasses size
]

{ #category : 'initialization' }
HeraRunnerScopeIterator >> initialize [

	super initialize.
	acceptanceTestClasses := #().
	currentIndex := 0
]

{ #category : 'enumerating' }
HeraRunnerScopeIterator >> next [

	self hasNext ifFalse: [ ^ nil ].
	currentIndex := currentIndex + 1.
	^ acceptanceTestClasses at: currentIndex
]

{ #category : 'enumerating' }
HeraRunnerScopeIterator >> nextDo: aBlock [

	self next ifNotNil: [ :acceptanceTestClass | aBlock value: acceptanceTestClass ]
]

{ #category : 'initialization' }
HeraRunnerScopeIterator >> scope: aRunnerScope [

	acceptanceTestClasses := aRunnerScope acceptanceTests.
	currentIndex := 0
]
