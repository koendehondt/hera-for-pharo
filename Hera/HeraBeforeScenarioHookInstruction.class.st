Class {
	#name : 'HeraBeforeScenarioHookInstruction',
	#superclass : 'HeraHookInstruction',
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'performing' }
HeraBeforeScenarioHookInstruction >> performFor: aScriptRunner [

	aScriptRunner beforeScenarioHook
]
