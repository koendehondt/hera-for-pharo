Class {
	#name : 'HeraStartScenarioInstruction',
	#superclass : 'HeraRunInstruction',
	#instVars : [
		'scenario'
	],
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'instance creation' }
HeraStartScenarioInstruction class >> for: aScenario [

	^ self new scenario: aScenario
]

{ #category : 'comparing' }
HeraStartScenarioInstruction >> = other [

	^ super = other and: [ self scenario = other scenario ]
]

{ #category : 'performing' }
HeraStartScenarioInstruction >> performFor: aScriptRunner [

	aScriptRunner startScenario: self scenario
]

{ #category : 'accessing' }
HeraStartScenarioInstruction >> scenario [

	^ scenario
]

{ #category : 'accessing' }
HeraStartScenarioInstruction >> scenario: aScenario [

	scenario := aScenario
]
