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

{ #category : 'tests' }
HeraAndAstNodeTestCase >> testTypeForDefinition [

	"This is not correct. An instance cannot know its type."
	self assert: subject typeForDefinition equals: 'Given'
]
