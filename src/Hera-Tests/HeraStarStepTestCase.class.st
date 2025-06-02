Class {
	#name : 'HeraStarStepTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraStarStepTestCase >> describedClass [

	^ HeraStarStep
]

{ #category : 'tests' }
HeraStarStepTestCase >> testPrintString [

	subject description: 'I fill in my user name'.
	self assert: subject printString equals: '* I fill in my user name'
]
