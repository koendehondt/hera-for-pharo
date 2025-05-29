Class {
	#name : 'HeraVersionTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraVersionTestCase >> describedClass [

	^ HeraVersion
]

{ #category : 'tests' }
HeraVersionTestCase >> testEquals [

	self assert: (self describedClass major: 1 minor: 2 patch: 3) equals: (self describedClass major: 1 minor: 2 patch: 3)
]

{ #category : 'tests' }
HeraVersionTestCase >> testInstanceCreation [

	subject := self describedClass major: 4 minor: 2 patch: 7.
	self assert: subject printString equals: 'Hera 4.2.7'
]

{ #category : 'tests' }
HeraVersionTestCase >> testPrintString [

	subject major: 2; minor: 5; patch: 12.
	self assert: subject printString equals: 'Hera 2.5.12'
]
