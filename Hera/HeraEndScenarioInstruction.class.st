Class {
	#name : 'HeraEndScenarioInstruction',
	#superclass : 'HeraRunInstruction',
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'testing' }
HeraEndScenarioInstruction >> canBeStepped [

	^ false
]

{ #category : 'testing' }
HeraEndScenarioInstruction >> isScenarioEnd [

	^ true
]

{ #category : 'performing' }
HeraEndScenarioInstruction >> performFor: aScriptRunner [

	aScriptRunner endScenario
]
