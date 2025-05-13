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

{ #category : 'tests' }
HeraStarAstNodeTestCase >> testTypeForDefinition [

	"This is not correct. An instance cannot know its type."
	self assert: subject typeForDefinition equals: 'Given'
]
