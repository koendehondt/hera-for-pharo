Class {
	#name : 'HeraDocStringStepArgumentAstNode',
	#superclass : 'HeraStepArgumentAstNode',
	#instVars : [
		'docString'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraDocStringStepArgumentAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitDocStringStepArgumentAstNode: self
]

{ #category : 'accessing' }
HeraDocStringStepArgumentAstNode >> docString [

	^ docString
]

{ #category : 'accessing' }
HeraDocStringStepArgumentAstNode >> docString: aDocString [

	docString := aDocString
]

{ #category : 'testing' }
HeraDocStringStepArgumentAstNode >> hasParameters [

	^ self docString hasParameters
]

{ #category : 'accessing' }
HeraDocStringStepArgumentAstNode >> parameters [

	^ self docString parameters
]

{ #category : 'accessing' }
HeraDocStringStepArgumentAstNode >> stepMethodArgumentName [

	^ 'aDocString'
]
