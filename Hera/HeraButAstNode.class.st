Class {
	#name : 'HeraButAstNode',
	#superclass : 'HeraStepAstNode',
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraButAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitButAstNode: self
]
