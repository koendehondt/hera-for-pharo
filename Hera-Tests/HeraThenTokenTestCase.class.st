Class {
	#name : 'HeraThenTokenTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Parser',
	#package : 'Hera-Tests',
	#tag : 'Parser'
}

{ #category : 'running' }
HeraThenTokenTestCase >> describedClass [

	^ HeraThenToken
]

{ #category : 'tests' }
HeraThenTokenTestCase >> testIsAllowedInBackground [

	self deny: subject isAllowedInBackground
]

{ #category : 'tests' }
HeraThenTokenTestCase >> testIsStepToken [

	self assert: subject isStepToken
]
