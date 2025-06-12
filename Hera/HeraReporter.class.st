Class {
	#name : 'HeraReporter',
	#superclass : 'Object',
	#category : 'Hera-Reporting',
	#package : 'Hera',
	#tag : 'Reporting'
}

{ #category : 'reporting' }
HeraReporter >> reportAfterScenarioHookError: anError [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportBeforeScenarioHookError: anError [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportEndOfBackground: aBackground [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportEndOfBackgroundStep: aStep [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportEndOfFeature: aFeature [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportEndOfRule: aRule [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportEndOfScenario: aScenario [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportEndOfStep: aStep [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportErrorStep: aStep of: aScenario withError: anError [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportFailedStep: aStep of: aScenario withFailure: aFailure [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportPassedStep: aStep [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportResult: result [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportStartOfBackground: aBackground [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportStartOfBackgroundStep: aStep [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportStartOfFeature: aFeature [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportStartOfRule: aRule [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportStartOfScenario: aScenario [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportStartOfStep: aStep [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraReporter >> reportSuppressed [

	self subclassResponsibility
]
