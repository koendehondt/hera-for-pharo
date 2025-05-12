Class {
	#name : 'HeraRuleAstNodeTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraRuleAstNodeTestCase >> describedClass [

	^ HeraRuleAstNode
]

{ #category : 'tests' }
HeraRuleAstNodeTestCase >> testIsEmptyWhenNoDescriptionNoBackgroundNoScenarios [

	self assert: subject isEmpty
]

{ #category : 'tests' }
HeraRuleAstNodeTestCase >> testIsNotEmptyWithBackground [

	subject background: HeraBackgroundAstNode new.
	self deny: subject isEmpty
]

{ #category : 'tests' }
HeraRuleAstNodeTestCase >> testIsNotEmptyWithDescription [

	subject description: HeraDescriptionAstNode new.
	self deny: subject isEmpty
]

{ #category : 'tests' }
HeraRuleAstNodeTestCase >> testIsNotEmptyWithScenarios [

	subject scenarios: (OrderedCollection with: HeraScenarioAstNode new).
	self deny: subject isEmpty
]
