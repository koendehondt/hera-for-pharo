Class {
	#name : 'HeraRunnerScope',
	#superclass : 'Object',
	#instVars : [
		'acceptanceTests'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HeraRunnerScope class >> with: anAcceptanceTest [

	^ self new addAcceptanceTest: anAcceptanceTest
]

{ #category : 'accessing' }
HeraRunnerScope >> acceptanceTests [

	^ acceptanceTests asArray
]

{ #category : 'accessing' }
HeraRunnerScope >> addAcceptanceTest: anAcceptanceTest [

	acceptanceTests add: anAcceptanceTest
]

{ #category : 'initialization' }
HeraRunnerScope >> initialize [

	super initialize.
	acceptanceTests := OrderedCollection new
]

{ #category : 'enumerating' }
HeraRunnerScope >> iterator [

	^ HeraRunnerScopeIterator on: self
]
