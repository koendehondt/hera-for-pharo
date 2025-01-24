Class {
	#name : 'HeraGivenAstNode',
	#superclass : 'HeraStepAstNode',
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraGivenAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitGivenAstNode: self
]
