Class {
	#name : 'HeraGivenStepTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraGivenStepTestCase >> describedClass [

	^ HeraGivenStep
]

{ #category : 'tests' }
HeraGivenStepTestCase >> testPrintString [

	subject description: 'I have credentials to sign in'.
	self assert: subject printString equals: 'Given I have credentials to sign in'
]
