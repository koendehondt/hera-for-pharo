Class {
	#name : 'HeraButStepTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraButStepTestCase >> describedClass [

	^ HeraButStep
]

{ #category : 'tests' }
HeraButStepTestCase >> testPrintString [

	subject description: 'I cannot sign in anymore'.
	self assert: subject printString equals: 'But I cannot sign in anymore'
]
