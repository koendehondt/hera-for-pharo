Class {
	#name : 'HeraDataTreeStepArgumentAstNode',
	#superclass : 'HeraStepArgumentAstNode',
	#instVars : [
		'dataTree'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraDataTreeStepArgumentAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitDataTreeStepArgumentAstNode: self
]

{ #category : 'accessing' }
HeraDataTreeStepArgumentAstNode >> dataTree [

	^ dataTree
]

{ #category : 'accessing' }
HeraDataTreeStepArgumentAstNode >> dataTree: aDataTree [

	dataTree := aDataTree
]

{ #category : 'accessing' }
HeraDataTreeStepArgumentAstNode >> stepMethodArgumentName [

	^ 'aDataTree'
]
