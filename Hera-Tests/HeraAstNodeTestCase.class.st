Class {
	#name : 'HeraAstNodeTestCase',
	#superclass : 'HeraUnitTestCase',
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

{ #category : 'tests' }
HeraAstNodeTestCase >> testIsScenarioNode [

	| nonScenarioClasses |
	self assert: HeraScenarioAstNode new isScenarioNode.
	nonScenarioClasses := HeraAstNode allSubclasses remove: HeraScenarioAstNode; yourself.
	nonScenarioClasses do: [ :each | self deny: each new isScenarioNode ]
]

{ #category : 'tests' }
HeraAstNodeTestCase >> testIsStepNode [

	| stepClasses nonStepClasses |
	stepClasses := HeraStepAstNode allSubclasses.
	stepClasses do: [ :each | self assert: each new isStepNode ].
	nonStepClasses := self describedClass allSubclasses removeAll: stepClasses; remove: HeraStepAstNode; yourself.
	nonStepClasses do: [ :each | self deny: each new isStepNode ]
]
