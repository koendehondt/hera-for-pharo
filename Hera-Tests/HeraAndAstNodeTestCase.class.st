Class {
	#name : 'HeraAndAstNodeTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraAndAstNodeTestCase >> describedClass [

	^ HeraAndAstNode
]

{ #category : 'running' }
HeraAndAstNodeTestCase >> initializeSubject [

	super initializeSubject.
	subject description: 'I have an active account'
]

{ #category : 'tests' }
HeraAndAstNodeTestCase >> testAsStepDefinitionPragma [

	self assert: subject asStepDefinitionPragma equals: '<heraStepDefinition: #(Given ''I have an active account'')>'
]

{ #category : 'tests' }
HeraAndAstNodeTestCase >> testTypeForDefinition [

	"This is not correct. An instance cannot know its type."
	self assert: subject typeForDefinition equals: 'Given'
]
