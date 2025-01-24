Class {
	#name : 'HeraBackgroundTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraBackgroundTestCase >> describedClass [

	^ HeraBackground
]

{ #category : 'tests' }
HeraBackgroundTestCase >> testPrintOn [

	self assert: subject printString equals: 'Background:'
]
