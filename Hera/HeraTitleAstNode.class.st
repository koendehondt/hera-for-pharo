Class {
	#name : 'HeraTitleAstNode',
	#superclass : 'HeraAstNode',
	#instVars : [
		'text'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraTitleAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitTitleAstNode: self
]

{ #category : 'accessing' }
HeraTitleAstNode >> text [

	^ text
]

{ #category : 'accessing' }
HeraTitleAstNode >> text: aString [

	text := aString
]
