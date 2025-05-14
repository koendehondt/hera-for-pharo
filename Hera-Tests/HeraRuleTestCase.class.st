Class {
	#name : 'HeraRuleTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraRuleTestCase >> describedClass [

	^ HeraRule
]

{ #category : 'tests' }
HeraRuleTestCase >> testPrintString [

	subject title: 'One ring to rule them all'.
	self assert: subject printString equals: 'Rule: One ring to rule them all'
]
