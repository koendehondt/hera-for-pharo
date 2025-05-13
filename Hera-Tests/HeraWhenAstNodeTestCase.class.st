Class {
	#name : 'HeraWhenAstNodeTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraWhenAstNodeTestCase >> describedClass [

	^ HeraWhenAstNode
]

{ #category : 'tests' }
HeraWhenAstNodeTestCase >> testTypeForDefinition [

	self assert: subject typeForDefinition equals: 'When'
]
