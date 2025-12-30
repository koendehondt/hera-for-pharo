Class {
	#name : 'HeraRunningStatusTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Runner',
	#package : 'Hera-UI-Tests',
	#tag : 'Runner'
}

{ #category : 'running' }
HeraRunningStatusTestCase >> describedClass [

	^ HeraRunningStatus
]

{ #category : 'tests' }
HeraRunningStatusTestCase >> testIconName [

	self assert: subject iconName equals: #runningResult
]
