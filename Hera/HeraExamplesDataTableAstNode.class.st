Class {
	#name : 'HeraExamplesDataTableAstNode',
	#superclass : 'HeraAstNode',
	#instVars : [
		'dataTable'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraExamplesDataTableAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitExamplesDataTableAstNode: self
]

{ #category : 'accessing' }
HeraExamplesDataTableAstNode >> dataTable [

	^ dataTable
]

{ #category : 'accessing' }
HeraExamplesDataTableAstNode >> dataTable: aDataTable [

	dataTable := aDataTable
]
