Class {
	#name : 'HeraWhenAstNodeTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraWhenAstNodeTestCase >> describedClass [

	^ HeraWhenAstNode
]

{ #category : 'running' }
HeraWhenAstNodeTestCase >> initializeSubject [

	super initializeSubject.
	subject description: 'I open the browser'
]

{ #category : 'tests' }
HeraWhenAstNodeTestCase >> testAsStepDefinitionPragma [

	self assert: subject asStepDefinitionPragma equals: '<heraStepDefinition: #(When ''I open the browser'')>'
]

{ #category : 'tests' }
HeraWhenAstNodeTestCase >> testTypeForDefinition [

	self assert: subject typeForDefinition equals: 'When'
]
