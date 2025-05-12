Class {
	#name : 'HeraFeatureAstNodeTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraFeatureAstNodeTestCase >> describedClass [

	^ HeraFeatureAstNode
]

{ #category : 'tests' }
HeraFeatureAstNodeTestCase >> testIsEmptyWhenNoDescriptionNoTagsNoRulesNoBackgroundNoScenarios [

	self assert: subject isEmpty
]

{ #category : 'tests' }
HeraFeatureAstNodeTestCase >> testIsNotEmptyWithBackground [

	subject background: HeraBackgroundAstNode new.
	self deny: subject isEmpty
]

{ #category : 'tests' }
HeraFeatureAstNodeTestCase >> testIsNotEmptyWithDescription [

	subject description: HeraDescriptionAstNode new.
	self deny: subject isEmpty
]

{ #category : 'tests' }
HeraFeatureAstNodeTestCase >> testIsNotEmptyWithRules [

	subject rules: (OrderedCollection with: HeraRuleAstNode new).
	self deny: subject isEmpty
]

{ #category : 'tests' }
HeraFeatureAstNodeTestCase >> testIsNotEmptyWithScenarios [

	subject scenarios: (OrderedCollection with: HeraScenarioAstNode new).
	self deny: subject isEmpty
]

{ #category : 'tests' }
HeraFeatureAstNodeTestCase >> testIsNotEmptyWithTags [

	subject tags: { HeraTagAstNode new }.
	self deny: subject isEmpty
]
