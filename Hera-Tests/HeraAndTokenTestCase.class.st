Class {
	#name : 'HeraAndTokenTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Gherkin parser',
	#package : 'Hera-Tests',
	#tag : 'Gherkin parser'
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
