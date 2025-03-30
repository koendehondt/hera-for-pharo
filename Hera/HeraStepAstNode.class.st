Class {
	#name : 'HeraStepAstNode',
	#superclass : 'HeraAstNode',
	#instVars : [
		'description',
		'argument'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'accessing' }
HeraStepAstNode >> argument [

	^ argument
]

{ #category : 'accessing' }
HeraStepAstNode >> argument: aDataTable [

	argument := aDataTable
]

{ #category : 'accessing' }
HeraStepAstNode >> description [

	^ description
]

{ #category : 'accessing' }
HeraStepAstNode >> description: aString [

	description := aString
]

{ #category : 'testing' }
HeraStepAstNode >> isGivenStepNode [

	^ false
]

{ #category : 'testing' }
HeraStepAstNode >> isStepNode [

	^ true
]
