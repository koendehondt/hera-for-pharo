"
HeraAstVisitorTestCase uses me to test visiting behavior.
"
Class {
	#name : 'HeraAstVisitorForTesting',
	#superclass : 'HeraAstVisitor',
	#instVars : [
		'visitedNode'
	],
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'private - visiting' }
HeraAstVisitorForTesting >> default: anAstNode [

	super default: anAstNode.
	visitedNode := anAstNode
]

{ #category : 'accessing' }
HeraAstVisitorForTesting >> visitedNode [

	^ visitedNode
]
