Class {
	#name : 'HeraExamplesAstNode',
	#superclass : 'HeraAstNode',
	#instVars : [
		'examplesDataTable'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraExamplesAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitExamplesAstNode: self
]

{ #category : 'accessing' }
HeraExamplesAstNode >> examplesDataTable [

	^ examplesDataTable
]

{ #category : 'accessing' }
HeraExamplesAstNode >> examplesDataTable: anExamplesDataTableAstNode [

	examplesDataTable := anExamplesDataTableAstNode
]
