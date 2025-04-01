Class {
	#name : 'HeraResultTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Running',
	#package : 'Hera-Tests',
	#tag : 'Running'
}

{ #category : 'running' }
HeraResultTestCase >> describedClass [

	^ HeraResult
]

{ #category : 'tests' }
HeraResultTestCase >> testDuration [

	subject recordStartTime.
	subject recordEndTime.
	self deny: subject duration isZero
]

{ #category : 'tests' }
HeraResultTestCase >> testInitialization [

	self assert: subject totalCount equals: 0.
	self assert: subject passedCount equals: 0.
	self assert: subject failedCount equals: 0.
	self assert: subject errorCount equals: 0
]

{ #category : 'tests' }
HeraResultTestCase >> testRecordingErrorForEmptyFeature [
	"This is a special case. There are no scenarios, but the result reports an error."

	subject recordEmptyFeature: HeraFeature new.
	self assert: subject totalCount equals: 0.
	self assert: subject passedCount equals: 0.
	self assert: subject failedCount equals: 0.
	self assert: subject errorCount equals: 1
]

{ #category : 'tests' }
HeraResultTestCase >> testRecordingErrorForEmptyScenario [

	subject recordEmptyScenario: HeraScenario new.
	subject recordPassedScenario: HeraScenario new.
	subject recordFailedScenario: HeraScenario new.
	subject recordErrorScenario: HeraScenario new.
	subject recordErrorScenario: HeraScenario new.
	self assert: subject totalCount equals: 5.
	self assert: subject passedCount equals: 1.
	self assert: subject failedCount equals: 1.
	self assert: subject errorCount equals: 3
]

{ #category : 'tests' }
HeraResultTestCase >> testRecordingResults [

	subject recordPassedScenario: HeraScenario new.
	subject recordFailedScenario: HeraScenario new.
	subject recordFailedScenario: HeraScenario new.
	subject recordFailedScenario: HeraScenario new.
	subject recordErrorScenario: HeraScenario new.
	subject recordErrorScenario: HeraScenario new.
	self assert: subject totalCount equals: 6.
	self assert: subject passedCount equals: 1.
	self assert: subject failedCount equals: 3.
	self assert: subject errorCount equals: 2
]
