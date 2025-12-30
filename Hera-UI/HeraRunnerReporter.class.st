Class {
	#name : 'HeraRunnerReporter',
	#superclass : 'HeraTextReporter',
	#instVars : [
		'runner',
		'rootResultItem',
		'currentFeatureResultItem',
		'currentScenarioResultItem',
		'currentAcceptanceTest'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'instance creation' }
HeraRunnerReporter class >> for: aRunner [

	^ self new runner: aRunner
]

{ #category : 'recording' }
HeraRunnerReporter >> record: aResultItem [

	runner record: aResultItem
]

{ #category : 'reporting' }
HeraRunnerReporter >> report: aBlock [

	| startPosition endPosition |
	startPosition := stream position + 1.
	aBlock value.
	endPosition := stream position.
	runner report: (stream originalContents copyFrom: startPosition to: endPosition)
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportAfterScenarioHookError: anError [

	self report: [ super reportAfterScenarioHookError: anError ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportBeforeScenarioHookError: anError [

	self report: [ super reportBeforeScenarioHookError: anError ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEmptyFeature: aFeature [

	self report: [ super reportEmptyFeature: aFeature ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEmptyScenario: aScenario [

	self report: [ super reportEmptyScenario: aScenario ].
	currentScenarioResultItem status: HeraResultStatus errorStatus
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEndOfBackground: aBackground [

	self report: [ super reportEndOfBackground: aBackground ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEndOfBackgroundStep: aStep [

	self report: [ super reportEndOfBackgroundStep: aStep ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEndOfFeature: aFeature [

	currentFeatureResultItem endTime: DateAndTime now.
	self report: [ super reportEndOfFeature: aFeature ].
	currentFeatureResultItem logEndPosition: stream position.
	currentFeatureResultItem := nil.
	currentAcceptanceTest := nil
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEndOfFeatures [

	rootResultItem endTime: DateAndTime now.
	self report: [ super reportEndOfFeatures ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEndOfRule: aRule [

	self report: [ super reportEndOfRule: aRule ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEndOfScenario: aScenario [

	currentScenarioResultItem endTime: DateAndTime now.
	self report: [ super reportEndOfScenario: aScenario ].
	currentScenarioResultItem logEndPosition: stream position.
	currentScenarioResultItem := nil
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEndOfStep: aStep [

	self report: [ super reportEndOfStep: aStep ].
	runner updateFromReporter
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportErrorScenario: aScenario [

	self report: [ super reportErrorScenario: aScenario ].
	currentScenarioResultItem status: HeraResultStatus errorStatus
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportErrorStep: aStep of: aScenario withError: anError [

	self report: [ super reportErrorStep: aStep of: aScenario withError: anError ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportFailedScenario: aScenario [

	self report: [ super reportFailedScenario: aScenario ].
	currentScenarioResultItem status: HeraResultStatus failedStatus
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportFailedStep: aStep of: aScenario withFailure: aFailure [

	self report: [ super reportFailedStep: aStep of: aScenario withFailure: aFailure ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportPassedScenario: aScenario [

	self report: [ super reportPassedScenario: aScenario ].
	currentScenarioResultItem status: HeraResultStatus passedStatus
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportPassedStep: aStep [

	self report: [ super reportPassedStep: aStep ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportPauseStep: aStep asSuppressed: aBoolean [

	super reportPauseStep: aStep asSuppressed: aBoolean.
	runner updateFromReporter
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportResult: result [

	self report: [ super reportResult: result ].
	rootResultItem logEndPosition: stream position.
	runner updateFromReporter.
	runner finish
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportStartOfBackground: aBackground [

	self report: [ super reportStartOfBackground: aBackground ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportStartOfBackgroundStep: aStep [

	self report: [ super reportStartOfBackgroundStep: aStep ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportStartOfFeature: aFeature in: anAcceptanceTest [

	currentAcceptanceTest := anAcceptanceTest.
	currentFeatureResultItem := HeraFeatureResultItem new
		feature: aFeature;
		acceptanceTest: currentAcceptanceTest;
		logStartPosition: stream position + 1.
	rootResultItem add: currentFeatureResultItem.
	self record: currentFeatureResultItem.
	self report: [ super reportStartOfFeature: aFeature in: currentAcceptanceTest ].
	currentFeatureResultItem startTime: DateAndTime now
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportStartOfFeatures: totalFeatureCount [

	rootResultItem := HeraRootResultItem new
		featureCount: totalFeatureCount;
		logStartPosition: stream position + 1.
	self record: rootResultItem.
	self report: [ super reportStartOfFeatures: totalFeatureCount ].
	rootResultItem startTime: DateAndTime now
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportStartOfRule: aRule [

	self report: [ super reportStartOfRule: aRule ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportStartOfScenario: aScenario [

	currentScenarioResultItem := HeraScenarioResultItem new
		scenario: aScenario;
		acceptanceTest: currentAcceptanceTest;
		logStartPosition: stream position + 1.
	currentFeatureResultItem add: currentScenarioResultItem.
	self record: currentScenarioResultItem.
	self report: [ super reportStartOfScenario: aScenario ].
	runner updateFromReporter.
	currentScenarioResultItem startTime: DateAndTime now
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportStartOfStep: aStep [

	self report: [ super reportStartOfStep: aStep ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportSuppressed [

	self report: [ super reportSuppressed ]
]

{ #category : 'accessing' }
HeraRunnerReporter >> runner: aRunner [

	runner := aRunner
]

{ #category : 'private - reporting' }
HeraRunnerReporter >> textAttributesForErrorFor: aStep of: aScenario [

	^ {
		TextEmphasis bold . 
		TextAction new actOnClickBlock: [ runner debugScenario: aScenario ] .
		"TextColor last, otherwise the text is blue due to the TextAction."
		TextColor new color: Color red }
]

{ #category : 'private - reporting' }
HeraRunnerReporter >> textAttributesForFailureFor: aStep of: aScenario [

	^ {
		TextEmphasis bold .
		TextAction new actOnClickBlock: [ runner debugScenario: aScenario ] .
		"TextColor last, otherwise the text is blue due to the TextAction."
		TextColor new color: Color orange }
]
