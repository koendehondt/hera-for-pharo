Class {
	#name : 'HeraWhenTokenTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Parser',
	#package : 'Hera-Tests',
	#tag : 'Parser'
}

{ #category : 'running' }
HeraWhenTokenTestCase >> describedClass [

	^ HeraWhenToken
]

{ #category : 'tests' }
HeraWhenTokenTestCase >> testIsAllowedInBackground [

	self deny: subject isAllowedInBackground
]

{ #category : 'tests' }
HeraWhenTokenTestCase >> testIsStepToken [

	self assert: subject isStepToken
]
