Class {
	#name : 'HeraExactStepDefinitionTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Step definitions',
	#package : 'Hera-Tests',
	#tag : 'Step definitions'
}

{ #category : 'running' }
HeraExactStepDefinitionTestCase >> describedClass [

	^ HeraExactStepDefinition
]

{ #category : 'tests' }
HeraExactStepDefinitionTestCase >> testEquals [

	| other |
	subject pattern: 'I open the browser'.
	other := self describedClass new pattern: 'I open the browser'.
	self assert: subject equals: other.
	other := self describedClass new pattern: 'I open a browser'.
	self deny: subject equals: other
]

{ #category : 'tests' }
HeraExactStepDefinitionTestCase >> testHash [

	| other |
	subject pattern: 'I open the browser'.
	other := self describedClass new pattern: 'I open the browser'.
	self assert: subject hash equals: other hash.
	other := self describedClass new pattern: 'I open a browser'.
	self deny: subject hash equals: other hash
]

{ #category : 'tests' }
HeraExactStepDefinitionTestCase >> testMatch [

	| anyPattern |
	anyPattern := nil.
	self assert: (subject match: anyPattern) equals: #()
]
