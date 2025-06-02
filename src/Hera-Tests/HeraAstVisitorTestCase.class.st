Class {
	#name : 'HeraAstVisitorTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraAstVisitorTestCase >> describedClass [

	^ HeraAstVisitorForTesting
]

{ #category : 'tests' }
HeraAstVisitorTestCase >> testVisit [

	| astNodeClasses |
	astNodeClasses := HeraAstNode allSubclasses
		remove: HeraStepArgumentAstNode;
		remove: HeraStepAstNode;
		yourself.
	astNodeClasses do: [ :each | | node |
		node := each new.
		node accept: subject.
		self assert: subject visitedNode identicalTo: node ]
]
