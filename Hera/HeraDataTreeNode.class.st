Class {
	#name : 'HeraDataTreeNode',
	#superclass : 'Object',
	#instVars : [
		'level',
		'text',
		'children'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'comparing' }
HeraDataTreeNode >> = other [

	^ self class = other class
		and: [ self level = other level
		and: [ self text = other text
		and: [ self children = other children ] ] ]
]

{ #category : 'accessing' }
HeraDataTreeNode >> addChild: aDataTreeNode [

	children add: aDataTreeNode
]

{ #category : 'accessing' }
HeraDataTreeNode >> children [

	^ children asArray
]

{ #category : 'accessing' }
HeraDataTreeNode >> children: aCollection [

	children := aCollection asOrderedCollection
]

{ #category : 'initialization' }
HeraDataTreeNode >> initialize [

	super initialize.
	children := OrderedCollection new
]

{ #category : 'accessing' }
HeraDataTreeNode >> level [

	^ level
]

{ #category : 'accessing' }
HeraDataTreeNode >> level: anInteger [

	level := anInteger
]

{ #category : 'accessing' }
HeraDataTreeNode >> text [

	^ text
]

{ #category : 'accessing' }
HeraDataTreeNode >> text: aString [

	text := aString
]
