Class {
	#name : 'HeraAstNode',
	#superclass : 'Object',
	#instVars : [
		'start',
		'end'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraAstNode >> accept: anAstVisitor [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
HeraAstNode >> end [

	^ end
]

{ #category : 'accessing' }
HeraAstNode >> end: anInteger [

	end := anInteger
]

{ #category : 'testing' }
HeraAstNode >> isLocatedAtTextPosition: anInteger [

	^ anInteger between: start and: end
]

{ #category : 'accessing' }
HeraAstNode >> start [

	^ start
]

{ #category : 'accessing' }
HeraAstNode >> start: anInteger [

	start := anInteger
]
