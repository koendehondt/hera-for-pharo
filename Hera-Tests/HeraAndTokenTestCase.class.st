Class {
	#name : 'HeraAndTokenTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Parser',
	#package : 'Hera-Tests',
	#tag : 'Parser'
}

{ #category : 'running' }
HeraAndTokenTestCase >> describedClass [

	^ HeraAndToken
]

{ #category : 'tests' }
HeraAndTokenTestCase >> testIsAllowedInBackground [

	self assert: subject isAllowedInBackground
]

{ #category : 'tests' }
HeraAndTokenTestCase >> testIsStepToken [

	self assert: subject isStepToken
]
