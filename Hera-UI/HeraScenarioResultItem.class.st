Class {
	#name : 'HeraScenarioResultItem',
	#superclass : 'HeraResultItem',
	#instVars : [
		'scenario',
		'status',
		'acceptanceTest'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'accessing' }
HeraScenarioResultItem >> acceptanceTest [

	^ acceptanceTest
]

{ #category : 'accessing' }
HeraScenarioResultItem >> acceptanceTest: anAcceptanceTest [

	acceptanceTest := anAcceptanceTest
]

{ #category : 'accessing' }
HeraScenarioResultItem >> description [

	^ self scenarioTitle
]

{ #category : 'accessing' }
HeraScenarioResultItem >> iconName [

	^ self status iconName
]

{ #category : 'initialization' }
HeraScenarioResultItem >> initialize [

	super initialize.
	status := HeraResultStatus runningStatus
]

{ #category : 'accessing' }
HeraScenarioResultItem >> level [

	^ 3
]

{ #category : 'rerunning - double dispatch' }
HeraScenarioResultItem >> rerunDebuggingFromRunner: aRunner [

	aRunner rerunAndDebugScenarioResult: self
]

{ #category : 'rerunning - double dispatch' }
HeraScenarioResultItem >> rerunFromRunner: aRunner [

	aRunner rerunScenarioResult: self
]

{ #category : 'rerunning - double dispatch' }
HeraScenarioResultItem >> rerunSteppingFromRunner: aRunner [

	aRunner rerunAndStepScenarioResult: self
]

{ #category : 'accessing' }
HeraScenarioResultItem >> scenario: aScenario [

	scenario := aScenario
]

{ #category : 'accessing' }
HeraScenarioResultItem >> scenarioTitle [

	^ scenario title
]

{ #category : 'accessing' }
HeraScenarioResultItem >> status [

	^ status
]

{ #category : 'accessing' }
HeraScenarioResultItem >> status: aResultStatus [

	status := aResultStatus
]

{ #category : 'accessing' }
HeraScenarioResultItem >> subItems [

	^ #()
]
