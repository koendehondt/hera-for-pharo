Class {
	#name : 'HeraThenAstNodeTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraThenAstNodeTestCase >> describedClass [

	^ HeraThenAstNode
]

{ #category : 'tests' }
HeraThenAstNodeTestCase >> testTypeForDefinition [

	self assert: subject typeForDefinition equals: 'Then'
]
