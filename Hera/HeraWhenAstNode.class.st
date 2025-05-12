Class {
	#name : 'HeraWhenAstNode',
	#superclass : 'HeraStepAstNode',
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraWhenAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitWhenAstNode: self
]

{ #category : 'accessing' }
HeraWhenAstNode >> typeForDefinition [

	^ 'When'
]
