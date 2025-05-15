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

	(HeraAstNode allSubclasses reject: [ :each | each isAbstract ]) do: [ :each | | node |
		node := each new.
		node accept: subject.
		self assert: subject visitedNode identicalTo: node ]
]

{ #category : 'tests' }
HeraAstVisitorTestCase >> testVisitAndAstNode [

	| node |
	node := HeraAndAstNode new.
	node accept: subject.
	self assert: subject visitedNode identicalTo: node
]

{ #category : 'tests' }
HeraAstVisitorTestCase >> testVisitBackgroundAstNode [

	| node |
	node := HeraBackgroundAstNode new.
	node accept: subject.
	self assert: subject visitedNode identicalTo: node
]

{ #category : 'tests' }
HeraAstVisitorTestCase >> testVisitButAstNode [

	| node |
	node := HeraButAstNode new.
	node accept: subject.
	self assert: subject visitedNode identicalTo: node
]
