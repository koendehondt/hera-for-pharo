Class {
	#name : 'HeraStepAstNodeTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
}

{ #category : 'running' }
HeraStepAstNodeTestCase >> describedClass [

	^ HeraStepAstNode
]

{ #category : 'tests' }
HeraStepAstNodeTestCase >> testIsGivenStepNode [

	| nonGivenClasses |
	nonGivenClasses := self describedClass allSubclasses remove: HeraGivenAstNode; yourself.
	nonGivenClasses do: [ :each | self deny: each new isGivenStepNode ].
	self assert: HeraGivenAstNode new isGivenStepNode
]
