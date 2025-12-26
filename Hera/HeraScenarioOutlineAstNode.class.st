Class {
	#name : 'HeraScenarioOutlineAstNode',
	#superclass : 'HeraScenarioAstNode',
	#instVars : [
		'examples'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraScenarioOutlineAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitScenarioOutlineAstNode: self
]

{ #category : 'accessing' }
HeraScenarioOutlineAstNode >> examples [

	^ examples
]

{ #category : 'accessing' }
HeraScenarioOutlineAstNode >> examples: anOrderedCollection [

	examples := anOrderedCollection
]

{ #category : 'testing' }
HeraScenarioOutlineAstNode >> isEmpty [

	^super isEmpty and: [ self examples isNil ]
]
