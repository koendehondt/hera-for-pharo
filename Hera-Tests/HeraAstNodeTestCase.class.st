Class {
	#name : 'HeraAstNodeTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraAstNodeTestCase >> describedClass [

	^ HeraAstNode
]

{ #category : 'tests' }
HeraAstNodeTestCase >> testIsLocatedAtTextPosition [

	subject start: 20; end: 22.
	self deny: (subject isLocatedAtTextPosition: 19).
	self assert: (subject isLocatedAtTextPosition: 20).
	self assert: (subject isLocatedAtTextPosition: 21).
	self assert: (subject isLocatedAtTextPosition: 22).
	self deny: (subject isLocatedAtTextPosition: 23)
]
