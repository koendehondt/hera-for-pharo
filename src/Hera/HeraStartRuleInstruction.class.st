Class {
	#name : 'HeraStartRuleInstruction',
	#superclass : 'HeraRunInstruction',
	#instVars : [
		'rule'
	],
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'instance creation' }
HeraStartRuleInstruction class >> for: aRule [

	^ self new rule: aRule
]

{ #category : 'comparing' }
HeraStartRuleInstruction >> = other [

	^ super = other and: [ self rule = other rule ]
]

{ #category : 'performing' }
HeraStartRuleInstruction >> performFor: aScriptRunner [

	aScriptRunner startRule: self rule
]

{ #category : 'accessing' }
HeraStartRuleInstruction >> rule [

	^ rule
]

{ #category : 'accessing' }
HeraStartRuleInstruction >> rule: aRule [

	rule := aRule
]
