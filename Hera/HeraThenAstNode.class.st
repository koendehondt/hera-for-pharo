Class {
	#name : 'HeraThenAstNode',
	#superclass : 'HeraStepAstNode',
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraThenAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitThenAstNode: self
]

{ #category : 'accessing' }
HeraThenAstNode >> stepType [

	^ #Then
]
