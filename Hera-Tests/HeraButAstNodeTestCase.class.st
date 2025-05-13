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

{ #category : 'tests' }
HeraButAstNodeTestCase >> testTypeForDefinition [

	"This is not correct. An instance cannot know its type."
	self assert: subject typeForDefinition equals: 'Given'
]
