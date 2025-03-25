Class {
	#name : 'HeraToken',
	#superclass : 'Object',
	#instVars : [
		'start'
	],
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'comparing' }
HeraToken >> = anotherToken [

	^ anotherToken isMemberOf: self class
]

{ #category : 'accessing' }
HeraToken >> end [

	self subclassResponsibility
]

{ #category : 'testing' }
HeraToken >> isAllowedInBackground [

	^ false
]

{ #category : 'testing' }
HeraToken >> isBackgroundToken [

	^ false
]

{ #category : 'testing' }
HeraToken >> isDataTableToken [

	^ false
]

{ #category : 'testing' }
HeraToken >> isDocStringToken [

	^ false
]

{ #category : 'testing' }
HeraToken >> isEndOfFileToken [

	^ false
]

{ #category : 'testing' }
HeraToken >> isEndOfLineToken [

	^ false
]

{ #category : 'testing' }
HeraToken >> isFeatureToken [

	^ false
]

{ #category : 'testing' }
HeraToken >> isScenarioToken [

	^ false
]

{ #category : 'testing' }
HeraToken >> isStepToken [

	^ false
]

{ #category : 'testing' }
HeraToken >> isTagToken [

	^ false
]

{ #category : 'testing' }
HeraToken >> isTextToken [

	^ false
]

{ #category : 'accessing' }
HeraToken >> start [

	^ start
]

{ #category : 'accessing' }
HeraToken >> start: anObject [

	start := anObject
]
