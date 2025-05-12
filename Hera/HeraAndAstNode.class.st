Class {
	#name : 'HeraAndAstNode',
	#superclass : 'HeraStepAstNode',
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraAndAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitAndAstNode: self
]

{ #category : 'accessing' }
HeraAndAstNode >> typeForDefinition [

	^ 'Given'
]
