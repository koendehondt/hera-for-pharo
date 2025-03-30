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

{ #category : 'accessing' }
HeraButAstNode >> stepType [

	self flag: 'Not correct. A previous step node determines the type of and And node.'.
	^ #Given
]
