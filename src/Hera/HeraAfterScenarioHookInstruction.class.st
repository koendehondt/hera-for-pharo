Class {
	#name : 'HeraAfterScenarioHookInstruction',
	#superclass : 'HeraHookInstruction',
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'performing' }
HeraAfterScenarioHookInstruction >> performFor: aScriptRunner [

	aScriptRunner afterScenarioHook
]
