Class {
	#name : 'HeraRunnerResultSummary',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'passedCount',
		'failedCount',
		'errorCount',
		'duration',
		'startTime',
		'totalCount'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'updating' }
HeraRunnerResultSummary >> changed: aParameter [

	self modelChanged
]

{ #category : 'layout' }
HeraRunnerResultSummary >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		spacing: 10;
		vAlignCenter;
		add: totalCount expand: false;
		add: passedCount expand: false;
		add: failedCount expand: false;
		add: errorCount expand: false;
		add: duration expand: false;
		add: startTime expand: false;
		yourself
]

{ #category : 'private' }
HeraRunnerResultSummary >> humanReadableDuration [

	| testDuration |
	testDuration  := self model duration.
	self model totalCount isZero ifTrue: [ ^ '' ].
	testDuration isZero ifTrue: [ ^ 'Less than a nanosecond' ].
	testDuration < (Duration seconds: 1) ifTrue: [ ^ 'Less than a second' ].
	^ (testDuration truncateTo: (Duration seconds: 1)) humanReadablePrintString
]

{ #category : 'private' }
HeraRunnerResultSummary >> humanReadableStartTime [

	| testStartTime |
	testStartTime  := self model startTime.
	self model totalCount isZero ifTrue: [ ^ '' ].
	^ '({1})' format: { testStartTime asStringYMDHM }
]

{ #category : 'initialization' }
HeraRunnerResultSummary >> initializePresenters [

	totalCount := (self instantiate: HeraRunnerResultCount)
		addStyle: 'total';
		count: 0.
	passedCount := (self instantiate: HeraRunnerResultCount)
		addStyle: 'passed';
		count: 0.
	failedCount := (self instantiate: HeraRunnerResultCount)
		addStyle: 'failed';
		count: 0.
	errorCount := (self instantiate: HeraRunnerResultCount)
		addStyle: 'error';
		count: 0.
	duration := self newLabel.
	startTime := self newLabel
]

{ #category : 'accessing' }
HeraRunnerResultSummary >> model: aDomainObject [

	self model removeDependent: self.
	super model: aDomainObject.
	self model addDependent: self
]

{ #category : 'initialization' }
HeraRunnerResultSummary >> modelChanged [

	| result |
	result := self model.
	duration label: self humanReadableDuration.
	startTime label: self humanReadableStartTime.
	totalCount count: result totalCount.
	passedCount count: result passedCount.
	failedCount count: result failedCount.
	errorCount count: result errorCount
]
