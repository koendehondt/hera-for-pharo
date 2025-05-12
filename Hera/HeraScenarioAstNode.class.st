Class {
	#name : 'HeraScenarioAstNode',
	#superclass : 'HeraAstNode',
	#instVars : [
		'title',
		'steps',
		'tags',
		'description'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraScenarioAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitScenarioAstNode: self
]

{ #category : 'accessing' }
HeraScenarioAstNode >> description [

	^ description
]

{ #category : 'accessing' }
HeraScenarioAstNode >> description: aDescriptionAstNode [

	description := aDescriptionAstNode
]

{ #category : 'initialization' }
HeraScenarioAstNode >> initialize [

	super initialize.
	tags := #().
	steps := #()
]

{ #category : 'testing' }
HeraScenarioAstNode >> isEmpty [

	^ self tags isEmpty and: [ self description isNil and: [ self steps isEmpty ] ]
]

{ #category : 'accessing' }
HeraScenarioAstNode >> steps [

	^ steps
]

{ #category : 'accessing' }
HeraScenarioAstNode >> steps: anOrderedCollection [

	steps := anOrderedCollection
]

{ #category : 'accessing' }
HeraScenarioAstNode >> tags [

	^ tags
]

{ #category : 'accessing' }
HeraScenarioAstNode >> tags: anArray [

	tags := anArray
]

{ #category : 'accessing' }
HeraScenarioAstNode >> title [

	^ title
]

{ #category : 'accessing' }
HeraScenarioAstNode >> title: aTitle [

	title := aTitle
]
