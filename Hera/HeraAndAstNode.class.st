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
HeraAndAstNode >> stepType [

	self flag: 'Not correct. A previous step node determines the type of and And node.'.
	^ #Given
]
