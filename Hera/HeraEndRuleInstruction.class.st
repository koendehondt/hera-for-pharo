Class {
	#name : 'HeraEndRuleInstruction',
	#superclass : 'HeraRunInstruction',
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'testing' }
HeraEndRuleInstruction >> canBeStepped [

	^ false
]

{ #category : 'performing' }
HeraEndRuleInstruction >> performFor: aScriptRunner [

	aScriptRunner endRule
]
