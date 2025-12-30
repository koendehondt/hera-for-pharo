Class {
	#name : 'HeraErrorStatusTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Runner',
	#package : 'Hera-UI-Tests',
	#tag : 'Runner'
}

{ #category : 'running' }
HeraErrorStatusTestCase >> describedClass [

	^ HeraErrorStatus
]

{ #category : 'tests' }
HeraErrorStatusTestCase >> testIconName [

	self assert: subject iconName equals: #errorResult
]
