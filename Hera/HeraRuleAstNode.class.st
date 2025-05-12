Class {
	#name : 'HeraRuleAstNode',
	#superclass : 'HeraAstNode',
	#instVars : [
		'title',
		'scenarios',
		'description',
		'background'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraRuleAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitRuleAstNode: self
]

{ #category : 'accessing' }
HeraRuleAstNode >> background [

	^ background
]

{ #category : 'accessing' }
HeraRuleAstNode >> background: aBackgroundAstNode [

	background := aBackgroundAstNode
]

{ #category : 'accessing' }
HeraRuleAstNode >> description [

	^ description
]

{ #category : 'accessing' }
HeraRuleAstNode >> description: aDescriptionAstNode [

	description := aDescriptionAstNode
]

{ #category : 'initialization' }
HeraRuleAstNode >> initialize [

	super initialize.
	scenarios := OrderedCollection new
]

{ #category : 'testing' }
HeraRuleAstNode >> isEmpty [

	^ self description isNil and: [ self background isNil and: [ self scenarios isEmpty ] ]
]

{ #category : 'accessing' }
HeraRuleAstNode >> scenarios [

	^ scenarios
]

{ #category : 'accessing' }
HeraRuleAstNode >> scenarios: anOrderedCollection [

	scenarios := anOrderedCollection
]

{ #category : 'accessing' }
HeraRuleAstNode >> title [

	^ title
]

{ #category : 'accessing' }
HeraRuleAstNode >> title: aTitle [

	title := aTitle
]
