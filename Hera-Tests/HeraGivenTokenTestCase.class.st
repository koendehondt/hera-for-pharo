Class {
	#name : 'HeraGivenTokenTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Parser',
	#package : 'Hera-Tests',
	#tag : 'Parser'
}

{ #category : 'running' }
HeraGivenTokenTestCase >> describedClass [

	^ HeraGivenToken
]

{ #category : 'tests' }
HeraGivenTokenTestCase >> testIsAllowedInBackground [

	self assert: subject isAllowedInBackground
]

{ #category : 'tests' }
HeraGivenTokenTestCase >> testIsStepToken [

	self assert: subject isStepToken
]
