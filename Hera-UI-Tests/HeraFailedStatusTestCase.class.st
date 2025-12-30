Class {
	#name : 'HeraFailedStatusTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Runner',
	#package : 'Hera-UI-Tests',
	#tag : 'Runner'
}

{ #category : 'running' }
HeraFailedStatusTestCase >> describedClass [

	^ HeraFailedStatus
]

{ #category : 'tests' }
HeraFailedStatusTestCase >> testIconName [

	self assert: subject iconName equals: #failedResult
]
