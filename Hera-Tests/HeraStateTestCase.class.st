Class {
	#name : 'HeraStateTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraStateTestCase >> describedClass [

	^ HeraState
]

{ #category : 'tests' }
HeraStateTestCase >> testClear [

	subject at: #something put: 'value'.
	subject clear.
	self assert: (subject at: #something) isNil.
]

{ #category : 'tests' }
HeraStateTestCase >> testStoringAndRetrieving [

	self assert: (subject at: #something) isNil.
	self assert: (subject at: #something ifAbsent: [ #notFound ]) equals: #notFound.
	subject at: #something put: 'value'.
	self assert: (subject at: #something) equals: 'value'
]
