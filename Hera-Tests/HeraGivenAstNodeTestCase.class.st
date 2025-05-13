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

{ #category : 'running' }
HeraGivenAstNodeTestCase >> initializeSubject [

	super initializeSubject.
	subject description: 'I have credentials'
]

{ #category : 'tests' }
HeraGivenAstNodeTestCase >> testAsStepDefinitionPragma [

	self assert: subject asStepDefinitionPragma equals: '<heraStepDefinition: #(Given ''I have credentials'')>'
]

{ #category : 'tests' }
HeraGivenAstNodeTestCase >> testTypeForDefinition [

	self assert: subject typeForDefinition equals: 'Given'
]
