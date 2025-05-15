Class {
	#name : 'HeraAbstractReporter',
	#superclass : 'Object',
	#category : 'Hera-Reporting',
	#package : 'Hera',
	#tag : 'Reporting'
}

{ #category : 'reporting' }
HeraAbstractReporter >> reportAfterScenarioHookError: anError [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportBeforeScenarioHookError: anError [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportEndOfBackground: aBackground [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportEndOfBackgroundStep: aStep [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportEndOfFeature: aFeature [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportEndOfFeatures [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportEndOfRule: aRule [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportEndOfScenario: aScenario [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportEndOfStep: aStep [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportErrorStep: aStep withError: anError [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportFailedStep: aStep withFailure: aFailure [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportPassedStep: aStep [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportResult: result [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportStartOfBackground: aBackground [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportStartOfBackgroundStep: aStep [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportStartOfFeature: aFeature [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportStartOfFeatures: features withFilter: filter [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportStartOfRule: aRule [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportStartOfScenario: aScenario [

	self subclassResponsibility
]

{ #category : 'reporting' }
HeraAbstractReporter >> reportStartOfStep: aStep [

	self subclassResponsibility
]
