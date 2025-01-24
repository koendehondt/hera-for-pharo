Class {
	#name : 'HeraThenTokenTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Gherkin parser',
	#package : 'Hera-Tests',
	#tag : 'Gherkin parser'
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
