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
HeraStepAstNodeTestCase >> testHasArgument [

	self deny: subject hasArgument.
	subject argument: HeraDocStringStepArgumentAstNode new.
	self assert: subject hasArgument
]

{ #category : 'tests' }
HeraStepAstNodeTestCase >> testIsGivenStepNode [

	| nonGivenClasses |
	nonGivenClasses := self describedClass allSubclasses remove: HeraGivenAstNode; yourself.
	nonGivenClasses do: [ :each | self deny: each new isGivenStepNode ].
	self assert: HeraGivenAstNode new isGivenStepNode
]

{ #category : 'tests' }
HeraStepAstNodeTestCase >> testMethodSignatureForDualKeywordSelector [

	self assert: (subject methodSignatureFor: 'stepKeywordOne:keywordTwo:') equals: 'stepKeywordOne: arg1 keywordTwo: arg2'
]

{ #category : 'tests' }
HeraStepAstNodeTestCase >> testMethodSignatureForDualKeywordSelectorWithDataTable [

	subject argument: HeraDataTableStepArgumentAstNode new.
	self assert: (subject methodSignatureFor: 'stepKeywordOne:keywordTwo:') equals: 'stepKeywordOne: arg keywordTwo: aDataTable'
]

{ #category : 'tests' }
HeraStepAstNodeTestCase >> testMethodSignatureForDualKeywordSelectorWithDocString [

	subject argument: HeraDocStringStepArgumentAstNode new.
	self assert: (subject methodSignatureFor: 'stepKeywordOne:keywordTwo:') equals: 'stepKeywordOne: arg keywordTwo: aDocString'
]

{ #category : 'tests' }
HeraStepAstNodeTestCase >> testMethodSignatureForSingleKeywordSelector [

	self assert: (subject methodSignatureFor: 'stepKeyword:') equals: 'stepKeyword: arg'
]

{ #category : 'tests' }
HeraStepAstNodeTestCase >> testMethodSignatureForSingleKeywordSelectorWithDataTable [

	subject argument: HeraDataTableStepArgumentAstNode new.
	self assert: (subject methodSignatureFor: 'stepKeyword:') equals: 'stepKeyword: aDataTable'
]

{ #category : 'tests' }
HeraStepAstNodeTestCase >> testMethodSignatureForSingleKeywordSelectorWithDocString [

	subject argument: HeraDocStringStepArgumentAstNode new.
	self assert: (subject methodSignatureFor: 'stepKeyword:') equals: 'stepKeyword: aDocString'
]

{ #category : 'tests' }
HeraStepAstNodeTestCase >> testMethodSignatureForTripleKeywordSelector [

	subject argument: HeraDocStringStepArgumentAstNode new.
	self assert: (subject methodSignatureFor: 'stepKeywordOne:keywordTwo:keywordThree:') equals: 'stepKeywordOne: arg1 keywordTwo: arg2 keywordThree: aDocString'
]

{ #category : 'tests' }
HeraStepAstNodeTestCase >> testMethodSignatureForUnarySelector [

	self assert: (subject methodSignatureFor: 'stepUnary') equals: 'stepUnary'
]
