Class {
	#name : 'HeraAstVisitorTestCase',
	#superclass : 'HeraTestCase',
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

	(HeraAstNode allSubclasses reject: [ :each | each class includesSelector: #isAbstract ]) do: [ :each | | node |
		node := each new.
		node accept: subject.
		self assert: subject visitedNode identicalTo: node ]
]
