Class {
	#name : 'HeraButTokenTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Parser',
	#package : 'Hera-Tests',
	#tag : 'Parser'
}

{ #category : 'running' }
HeraButTokenTestCase >> describedClass [

	^ HeraButToken
]

{ #category : 'tests' }
HeraButTokenTestCase >> testIsAllowedInBackground [

	self assert: subject isAllowedInBackground
]

{ #category : 'tests' }
HeraButTokenTestCase >> testIsStepToken [

	self assert: subject isStepToken
]
