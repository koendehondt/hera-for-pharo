Class {
	#name : 'HeraDataTreeItem',
	#superclass : 'Object',
	#instVars : [
		'level',
		'text'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'comparing' }
HeraDataTreeItem >> = other [

	^ self class = other class and: [ self level = other level and: [ self text = other text ] ]
]

{ #category : 'converting' }
HeraDataTreeItem >> asTreeItemWithResolvedParameters: parametersAndValues [

	^ self copy
		text: (self text heraParameterFormat: parametersAndValues)
]

{ #category : 'accessing' }
HeraDataTreeItem >> level [

	^ level
]

{ #category : 'accessing' }
HeraDataTreeItem >> level: anInteger [

	level := anInteger
]

{ #category : 'printing' }
HeraDataTreeItem >> printOn: aStream [

	aStream
		nextPutAll: 'Tree item level ';
		print: self level;
		space;
		nextPutAll: self text
]

{ #category : 'accessing' }
HeraDataTreeItem >> text [

	^ text
]

{ #category : 'accessing' }
HeraDataTreeItem >> text: aString [

	text := aString
]
