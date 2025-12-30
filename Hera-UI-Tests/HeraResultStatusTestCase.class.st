Class {
	#name : 'HeraResultStatusTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Runner',
	#package : 'Hera-UI-Tests',
	#tag : 'Runner'
}

{ #category : 'running' }
HeraResultStatusTestCase >> describedClass [

	^ HeraResultStatus
]

{ #category : 'tests' }
HeraResultStatusTestCase >> testErrorStatusIsUnique [

	self assert: (self describedClass errorStatus isMemberOf: HeraErrorStatus).
	self assert: self describedClass errorStatus isIdenticalTo: self describedClass errorStatus
]

{ #category : 'tests' }
HeraResultStatusTestCase >> testFailedStatusIsUnique [

	self assert: (self describedClass failedStatus isMemberOf: HeraFailedStatus).
	self assert: self describedClass failedStatus isIdenticalTo: self describedClass failedStatus
]

{ #category : 'tests' }
HeraResultStatusTestCase >> testPassedStatusIsUnique [

	self assert: (self describedClass passedStatus isMemberOf: HeraPassedStatus).
	self assert: self describedClass passedStatus isIdenticalTo: self describedClass passedStatus
]

{ #category : 'tests' }
HeraResultStatusTestCase >> testRunningStatusIsUnique [

	self assert: (self describedClass runningStatus isMemberOf: HeraRunningStatus).
	self assert: self describedClass runningStatus isIdenticalTo: self describedClass runningStatus
]
