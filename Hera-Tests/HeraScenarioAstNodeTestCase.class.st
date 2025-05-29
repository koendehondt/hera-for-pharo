Class {
	#name : 'HeraScenarioAstNodeTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraScenarioAstNodeTestCase >> describedClass [

	^ HeraScenarioAstNode
]

{ #category : 'tests' }
HeraScenarioAstNodeTestCase >> testIsEmptyWhenNoDescriptionNoTagsNoSteps [

	self assert: subject isEmpty
]

{ #category : 'tests' }
HeraScenarioAstNodeTestCase >> testIsNotEmptyWithDescription [

	subject description: HeraDescriptionAstNode new.
	self deny: subject isEmpty
]

{ #category : 'tests' }
HeraScenarioAstNodeTestCase >> testIsNotEmptyWithSteps [

	subject steps: (OrderedCollection with: HeraStepAstNode new).
	self deny: subject isEmpty
]

{ #category : 'tests' }
HeraScenarioAstNodeTestCase >> testIsNotEmptyWithTags [

	subject tags: { HeraTagAstNode new }.
	self deny: subject isEmpty
]
