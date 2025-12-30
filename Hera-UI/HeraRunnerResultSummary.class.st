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

{ #category : 'test api' }
HeraRunnerResultSummary >> counts [

	^ { totalCount value . passedCount value . failedCount value . errorCount value }
]

{ #category : 'layout' }
HeraRunnerResultSummary >> defaultLayout [

	| timeBox countsBox |
	timeBox := SpBoxLayout newHorizontal
		hAlignStart;
		vAlignCenter;
		spacing: 10;
		add: duration;
		add: startTime;
		yourself.
	countsBox := SpBoxLayout newLeftToRight
		add: totalCount width: 50;
		add: passedCount width: 50;
		add: failedCount width: 50;
		add: errorCount width: 50;
		yourself.
	^ SpBoxLayout newLeftToRight
		spacing: 10;
		add: countsBox expand: false;
		add: timeBox;
		yourself
]

{ #category : 'private' }
HeraRunnerResultSummary >> humanReadableDuration [

	| testDuration |
	testDuration  := self model duration.
	self model totalCount isZero ifTrue: [ ^ '' ].
	^ Hera settings humanReadableDuration: testDuration
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
		textColor: Color black;
		value: 0.
	passedCount := (self instantiate: HeraRunnerResultCount)
		addStyle: 'passed';
		value: 0.
	failedCount := (self instantiate: HeraRunnerResultCount)
		addStyle: 'failed';
		value: 0.
	errorCount := (self instantiate: HeraRunnerResultCount)
		addStyle: 'error';
		value: 0.
	duration := self newLabel.
	startTime := self newLabel
]

{ #category : 'accessing' }
HeraRunnerResultSummary >> model: aDomainObject [

	self model removeDependent: self.
	super model: aDomainObject.
	self model addDependent: self.
	self modelChanged
]

{ #category : 'initialization' }
HeraRunnerResultSummary >> modelChanged [

	| result |
	result := self model.
	duration label: self humanReadableDuration.
	startTime label: self humanReadableStartTime.
	totalCount value: result totalCount.
	passedCount value: result passedCount.
	failedCount value: result failedCount.
	errorCount value: result errorCount
]
