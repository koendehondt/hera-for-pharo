Class {
	#name : 'HeraStarAstNode',
	#superclass : 'HeraStepAstNode',
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraStarAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitStarAstNode: self
]
