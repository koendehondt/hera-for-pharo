Class {
	#name : 'HeraAndStepTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraAndStepTestCase >> describedClass [

	^ HeraAndStep
]

{ #category : 'tests' }
HeraAndStepTestCase >> testPrintString [

	subject description: 'I press the button to sign in'.
	self assert: subject printString equals: 'And I press the button to sign in'
]
