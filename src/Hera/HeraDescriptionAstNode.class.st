Class {
	#name : 'HeraDescriptionAstNode',
	#superclass : 'HeraAstNode',
	#instVars : [
		'lines'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraDescriptionAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitDescriptionAstNode: self
]

{ #category : 'accessing' }
HeraDescriptionAstNode >> lines [

	^ lines
]

{ #category : 'accessing' }
HeraDescriptionAstNode >> lines: anOrderedCollectionOfStrings [

	lines := anOrderedCollectionOfStrings
]
