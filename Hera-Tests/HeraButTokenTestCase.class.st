Class {
	#name : 'HeraButTokenTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Gherkin parser',
	#package : 'Hera-Tests',
	#tag : 'Gherkin parser'
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
