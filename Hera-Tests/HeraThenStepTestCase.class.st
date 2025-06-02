Class {
	#name : 'HeraThenStepTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraThenStepTestCase >> describedClass [

	^ HeraThenStep
]

{ #category : 'tests' }
HeraThenStepTestCase >> testPrintString [

	subject description: 'I see the home page'.
	self assert: subject printString equals: 'Then I see the home page'
]
