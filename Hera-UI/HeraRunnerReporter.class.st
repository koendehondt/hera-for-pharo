Class {
	#name : 'HeraRunnerReporter',
	#superclass : 'HeraTextReporter',
	#instVars : [
		'runner'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'instance creation' }
HeraRunnerReporter class >> for: aRunner [

	^ self new runner: aRunner
]

{ #category : 'reporting' }
HeraRunnerReporter >> report: aBlock [

	stream reset.
	aBlock value.
	runner report: stream contents
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportBackground: aBackground [

	self report: [ super reportBackground: aBackground ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEmptyFeature: aFeature [

	self report: [ super reportEmptyFeature: aFeature ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEmptyScenario: aScenario [

	self report: [ super reportEmptyScenario: aScenario ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEndOfBackgroundStep: aStep [

	self report: [ super reportEndOfBackgroundStep: aStep ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEndOfFeature: aFeature [

	self report: [ super reportEndOfFeature: aFeature ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEndOfFeatures [

	self report: [ super reportEndOfFeatures ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportEndOfStep: aStep [

	self report: [ super reportEndOfStep: aStep ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportErrorStep: aStep withError: anError [

	self report: [ super reportErrorStep: aStep withError: anError ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportFailedStep: aStep withFailure: aFailure [

	self report: [ super reportFailedStep: aStep withFailure: aFailure ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportPassedStep: aStep [

	self report: [ super reportPassedStep: aStep ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportResult: result [

	self report: [ super reportResult: result ].
	runner finish
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportStartOfBackgroundStep: aStep [

	self report: [ super reportStartOfBackgroundStep: aStep ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportStartOfFeature: aFeature [

	self report: [ super reportStartOfFeature: aFeature ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportStartOfFeatures: features withFilter: filter [

	runner clear
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportStartOfScenario: aScenario [

	self report: [ super reportStartOfScenario: aScenario ]
]

{ #category : 'reporting' }
HeraRunnerReporter >> reportStartOfStep: aStep [

	self report: [ super reportStartOfStep: aStep ]
]

{ #category : 'accessing' }
HeraRunnerReporter >> runner: aRunner [

	runner := aRunner
]

{ #category : 'private - reporting' }
HeraRunnerReporter >> textAttributesForErrorFor: aStep [

	^ {
		TextEmphasis bold . 
		TextAction new actOnClickBlock: [ runner debugScenario: aStep scenario ] .
		"TextColor last, otherwise the text is blue due to the TextAction."
		TextColor new color: Color red }
]

{ #category : 'private - reporting' }
HeraRunnerReporter >> textAttributesForFailureFor: aStep [

	^ {
		TextEmphasis bold .
		TextAction new actOnClickBlock: [ runner debugScenario: aStep scenario ] .
		"TextColor last, otherwise the text is blue due to the TextAction."
		TextColor new color: Color orange }
]
