Class {
	#name : 'HeraFeatureAstNode',
	#superclass : 'HeraAstNode',
	#instVars : [
		'scenarios',
		'description',
		'tags',
		'background',
		'title',
		'rules'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'visiting' }
HeraFeatureAstNode >> accept: anAstVisitor [

	^ anAstVisitor visitFeatureAstNode: self
]

{ #category : 'accessing' }
HeraFeatureAstNode >> background [

	^ background
]

{ #category : 'accessing' }
HeraFeatureAstNode >> background: aBackgroundAstNode [

	background := aBackgroundAstNode
]

{ #category : 'accessing' }
HeraFeatureAstNode >> description [

	^ description
]

{ #category : 'accessing' }
HeraFeatureAstNode >> description: aDescriptionAstNode [

	description := aDescriptionAstNode
]

{ #category : 'initialization' }
HeraFeatureAstNode >> initialize [

	super initialize.
	tags := Array new.
	rules := OrderedCollection new.
	scenarios := OrderedCollection new
]

{ #category : 'testing' }
HeraFeatureAstNode >> isEmpty [

	^ self tags isEmpty and: [ self description isNil and: [ self rules isEmpty and: [ self scenarios isEmpty ] ] ]
]

{ #category : 'accessing' }
HeraFeatureAstNode >> rules [

	^ rules
]

{ #category : 'accessing' }
HeraFeatureAstNode >> rules: anOrderedCollection [

	rules := anOrderedCollection
]

{ #category : 'accessing' }
HeraFeatureAstNode >> scenarios [

	^ scenarios
]

{ #category : 'accessing' }
HeraFeatureAstNode >> scenarios: anOrderedCollection [

	scenarios := anOrderedCollection
]

{ #category : 'accessing' }
HeraFeatureAstNode >> tags [

	^ tags
]

{ #category : 'accessing' }
HeraFeatureAstNode >> tags: anArray [

	tags := anArray
]

{ #category : 'accessing' }
HeraFeatureAstNode >> title [

	^ title
]

{ #category : 'accessing' }
HeraFeatureAstNode >> title: aTitle [

	title := aTitle
]
