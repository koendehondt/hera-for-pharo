Class {
	#name : 'HeraPassedStatusTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Runner',
	#package : 'Hera-UI-Tests',
	#tag : 'Runner'
}

{ #category : 'running' }
HeraPassedStatusTestCase >> describedClass [

	^ HeraPassedStatus
]

{ #category : 'tests' }
HeraPassedStatusTestCase >> testIconName [

	self assert: subject iconName equals: #passedResult
]
