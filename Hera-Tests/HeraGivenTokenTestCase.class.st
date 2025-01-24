Class {
	#name : 'HeraGivenTokenTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Gherkin parser',
	#package : 'Hera-Tests',
	#tag : 'Gherkin parser'
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
