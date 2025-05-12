Class {
	#name : 'HeraResultSummaryInstruction',
	#superclass : 'HeraRunInstruction',
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'testing' }
HeraResultSummaryInstruction >> canBeStepped [

	^ false
]

{ #category : 'performing' }
HeraResultSummaryInstruction >> performFor: aScriptRunner [

	aScriptRunner resultSummary
]
