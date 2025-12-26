Class {
	#name : 'HeraStepArgumentAstNode',
	#superclass : 'HeraAstNode',
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'accessing' }
HeraStepArgumentAstNode >> parameters [

	self subclassResponsibility
]

{ #category : 'accessing' }
HeraStepArgumentAstNode >> stepMethodArgumentName [

	self subclassResponsibility
]
