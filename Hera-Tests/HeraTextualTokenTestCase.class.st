Class {
	#name : 'HeraTextualTokenTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Parser',
	#package : 'Hera-Tests',
	#tag : 'Parser'
}

{ #category : 'running' }
HeraTextualTokenTestCase >> describedClass [

	^ HeraTextualToken
]

{ #category : 'tests' }
HeraTextualTokenTestCase >> testDefaultTextIsEmptyString [

	self assert: subject text equals: ''
]
