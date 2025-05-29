Class {
	#name : 'HeraThenAstNodeTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraThenAstNodeTestCase >> describedClass [

	^ HeraThenAstNode
]

{ #category : 'running' }
HeraThenAstNodeTestCase >> initializeSubject [

	super initializeSubject.
	subject description: 'I see the home page'
]

{ #category : 'tests' }
HeraThenAstNodeTestCase >> testAsStepDefinitionPragma [

	self assert: subject asStepDefinitionPragma equals: '<heraStepDefinition: #(Then ''I see the home page'')>'
]

{ #category : 'tests' }
HeraThenAstNodeTestCase >> testTypeForDefinition [

	self assert: subject typeForDefinition equals: 'Then'
]
