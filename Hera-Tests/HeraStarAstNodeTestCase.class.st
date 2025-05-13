Class {
	#name : 'HeraStarAstNodeTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraStarAstNodeTestCase >> describedClass [

	^ HeraButAstNode
]

{ #category : 'running' }
HeraStarAstNodeTestCase >> initializeSubject [

	super initializeSubject.
	subject description: 'I have an active account'
]

{ #category : 'tests' }
HeraStarAstNodeTestCase >> testAsStepDefinitionPragma [

	self assert: subject asStepDefinitionPragma equals: '<heraStepDefinition: #(Given ''I have an active account'')>'
]

{ #category : 'tests' }
HeraStarAstNodeTestCase >> testTypeForDefinition [

	"This is not correct. An instance cannot know its type."
	self assert: subject typeForDefinition equals: 'Given'
]
