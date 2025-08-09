Class {
	#name : 'HeraBackgroundAstNode',
	#superclass : 'HeraAstNode',
	#instVars : [
		'steps',
		'description'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraBackgroundAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitBackgroundAstNode: self
]

{ #category : 'accessing' }
HeraBackgroundAstNode >> description [

	^ description
]

{ #category : 'accessing' }
HeraBackgroundAstNode >> description: aDescriptionAstNode [

	description := aDescriptionAstNode
]

{ #category : 'accessing' }
HeraBackgroundAstNode >> steps [

	^ steps
]

{ #category : 'accessing' }
HeraBackgroundAstNode >> steps: anArrayOfStepAstNodes [

	steps := anArrayOfStepAstNodes
]
