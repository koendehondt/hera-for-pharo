Class {
	#name : 'HeraDataTableStepArgumentAstNode',
	#superclass : 'HeraStepArgumentAstNode',
	#instVars : [
		'dataTable'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraDataTableStepArgumentAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitDataTableStepArgumentAstNode: self
]

{ #category : 'accessing' }
HeraDataTableStepArgumentAstNode >> dataTable [

	^ dataTable
]

{ #category : 'accessing' }
HeraDataTableStepArgumentAstNode >> dataTable: aDataTable [

	dataTable := aDataTable
]

{ #category : 'testing' }
HeraDataTableStepArgumentAstNode >> hasParameters [

	^ self dataTable hasParameters
]

{ #category : 'accessing' }
HeraDataTableStepArgumentAstNode >> parameters [

	^ self dataTable parameters
]

{ #category : 'accessing' }
HeraDataTableStepArgumentAstNode >> stepMethodArgumentName [

	^ 'aDataTable'
]
