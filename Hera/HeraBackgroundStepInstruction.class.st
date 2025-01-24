Class {
	#name : 'HeraBackgroundStepInstruction',
	#superclass : 'HeraRunInstruction',
	#instVars : [
		'stepInstruction'
	],
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'performing' }
HeraBackgroundStepInstruction >> performFor: aScriptRunner [

	stepInstruction performFromBackgroundFor: aScriptRunner
]

{ #category : 'accessing' }
HeraBackgroundStepInstruction >> stepInstruction [

	^ stepInstruction
]

{ #category : 'accessing' }
HeraBackgroundStepInstruction >> stepInstruction: aStepInstruction [

	stepInstruction := aStepInstruction
]
