Class {
	#name : 'HeraResult',
	#superclass : 'Model',
	#instVars : [
		'startTime',
		'errorCount',
		'failedCount',
		'passedCount',
		'endTime'
	],
	#category : 'Hera-Running',
	#package : 'Hera',
	#tag : 'Running'
}

{ #category : 'accessing' }
HeraResult >> duration [

	startTime ifNil: [ ^ 0 ].
	endTime ifNil: [ ^ DateAndTime now - startTime ].
	^ endTime - startTime
]

{ #category : 'accessing' }
HeraResult >> errorCount [

	^ errorCount
]

{ #category : 'accessing' }
HeraResult >> failedCount [

	^ failedCount
]

{ #category : 'initialization' }
HeraResult >> initialize [

	super initialize.
	self class initializeSlots: self.
	passedCount := 0.
	failedCount := 0.
	errorCount := 0
]

{ #category : 'accessing' }
HeraResult >> passedCount [

	^ passedCount
]

{ #category : 'recording results' }
HeraResult >> recordEmptyFeature: aFeature [

	errorCount := errorCount + 1
]

{ #category : 'recording results' }
HeraResult >> recordEmptyScenario: aScenario [

	errorCount := errorCount + 1
]

{ #category : 'recording results' }
HeraResult >> recordEndTime [

	endTime := DateAndTime now.
	self changed
]

{ #category : 'recording results' }
HeraResult >> recordErrorScenario: aScenario [

	errorCount := errorCount + 1.
	self changed
]

{ #category : 'recording results' }
HeraResult >> recordFailedScenario: aScenario [

	failedCount := failedCount + 1.
	self changed
]

{ #category : 'recording results' }
HeraResult >> recordPassedScenario: aScenario [

	passedCount := passedCount + 1.
	self changed
]

{ #category : 'recording results' }
HeraResult >> recordStartTime [

	startTime := DateAndTime now.
	self changed
]

{ #category : 'accessing' }
HeraResult >> startTime [

	^ startTime
]

{ #category : 'accessing' }
HeraResult >> totalCount [

	^ self passedCount + self failedCount + self errorCount
]
