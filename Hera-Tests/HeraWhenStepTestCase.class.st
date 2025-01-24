Class {
	#name : 'HeraWhenStepTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraWhenStepTestCase >> describedClass [

	^ HeraWhenStep
]

{ #category : 'tests' }
HeraWhenStepTestCase >> testPrintString [

	subject description: 'I enter my credentials'.
	self assert: subject printString equals: 'When I enter my credentials'
]
