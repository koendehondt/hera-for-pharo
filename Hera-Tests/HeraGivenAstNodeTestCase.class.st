Class {
	#name : 'HeraGivenAstNodeTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraGivenAstNodeTestCase >> describedClass [

	^ HeraGivenAstNode
]

{ #category : 'tests' }
HeraGivenAstNodeTestCase >> testTypeForDefinition [

	self assert: subject typeForDefinition equals: 'Given'
]
