Class {
	#name : 'HeraWhenTokenTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Gherkin parser',
	#package : 'Hera-Tests',
	#tag : 'Gherkin parser'
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
