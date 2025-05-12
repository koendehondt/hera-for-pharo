Class {
	#name : 'HeraResult',
	#superclass : 'Model',
	#instVars : [
		'startTime',
		'errorCount',
		'failedCount',
		'passedCount',
		'endTime',
		'totalCount'
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
	totalCount := 0.
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

	self recordError
]

{ #category : 'recording results' }
HeraResult >> recordEmptyScenario: aScenario [

	self recordScenario.
	self recordError
]

{ #category : 'recording results' }
HeraResult >> recordEndTime [

	endTime := DateAndTime now.
	self changed
]

{ #category : 'recording results' }
HeraResult >> recordError [

	errorCount := errorCount + 1.
	self changed
]

{ #category : 'recording results' }
HeraResult >> recordErrorScenario: aScenario [

	self recordScenario.
	self recordError
]

{ #category : 'recording results' }
HeraResult >> recordFailedScenario: aScenario [

	self recordScenario.
	failedCount := failedCount + 1.
	self changed
]

{ #category : 'recording results' }
HeraResult >> recordPassedScenario: aScenario [

	self recordScenario.
	passedCount := passedCount + 1.
	self changed
]

{ #category : 'recording results' }
HeraResult >> recordScenario [

	totalCount := totalCount + 1
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

	^ totalCount
]
