Class {
	#name : 'HeraButAstNodeTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraButAstNodeTestCase >> describedClass [

	^ HeraButAstNode
]

{ #category : 'running' }
HeraButAstNodeTestCase >> initializeSubject [

	super initializeSubject.
	subject description: 'I do not have an active account'
]

{ #category : 'tests' }
HeraButAstNodeTestCase >> testAsStepDefinitionPragma [

	self assert: subject asStepDefinitionPragma equals: '<heraStepDefinition: #(Given ''I do not have an active account'')>'
]

{ #category : 'tests' }
HeraButAstNodeTestCase >> testTypeForDefinition [

	"This is not correct. An instance cannot know its type."
	self assert: subject typeForDefinition equals: 'Given'
]
