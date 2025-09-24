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
HeraRunnerScope class >> fromAcceptanceTestClasses: classes [

	| instance |
	instance := self new.
	classes do: [ :class |
		class features do: [ :acceptanceTest | instance addAcceptanceTest: acceptanceTest ] ].
	^ instance
]

{ #category : 'instance creation' }
HeraRunnerScope class >> with: anAcceptanceTest [

	^ self new addAcceptanceTest: anAcceptanceTest
]

{ #category : 'instance creation' }
HeraRunnerScope class >> withAll: acceptanceTests [

	^ self new addAcceptanceTests: acceptanceTests
]

{ #category : 'accessing' }
HeraRunnerScope >> acceptanceTests [

	^ acceptanceTests asArray
]

{ #category : 'accessing' }
HeraRunnerScope >> addAcceptanceTest: anAcceptanceTest [

	acceptanceTests add: anAcceptanceTest
]

{ #category : 'accessing' }
HeraRunnerScope >> addAcceptanceTests: acceptanceTestCollection [

	acceptanceTests addAll: acceptanceTestCollection
]

{ #category : 'initialization' }
HeraRunnerScope >> initialize [

	super initialize.
	acceptanceTests := OrderedCollection new
]
