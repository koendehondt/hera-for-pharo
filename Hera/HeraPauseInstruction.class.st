Class {
	#name : 'HeraPauseInstruction',
	#superclass : 'HeraRunStepInstruction',
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'performing' }
HeraPauseInstruction >> performFor: aScriptRunner [

	aScriptRunner pause: self step
]
