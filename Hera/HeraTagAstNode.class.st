Class {
	#name : 'HeraTagAstNode',
	#superclass : 'HeraAstNode',
	#instVars : [
		'name'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'instance creation' }
HeraTagAstNode class >> named: aString [

	^ self new name: aString
]

{ #category : 'visiting' }
HeraTagAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitTagAstNode: self
]

{ #category : 'initialization' }
HeraTagAstNode >> initialize [

	super initialize.
	name := ''
]

{ #category : 'accessing' }
HeraTagAstNode >> name [

	^ name
]

{ #category : 'accessing' }
HeraTagAstNode >> name: aString [

	name := aString
]
