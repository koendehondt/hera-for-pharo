Class {
	#name : 'HeraRule',
	#superclass : 'HeraScriptElement',
	#instVars : [
		'scenarios',
		'description',
		'title',
		'background',
		'inheritedTags',
		'tags'
	],
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'comparing' }
HeraRule >> = other [

	^ self title = other title
		and: [ self tags = other tags
		and: [ self scenarios = other scenarios
		and: [ self background = other background
		and: [ self description = other description ] ] ] ]
]

{ #category : 'visiting' }
HeraRule >> accept: visitor [

	visitor visitRule: self
]

{ #category : 'accessing' }
HeraRule >> allSteps [

	| all |
	all := OrderedCollection new.
	background ifNotNil: [ all addAll: background steps ].
	scenarios do: [ :each | all addAll: each steps ].
	^ all
]

{ #category : 'accessing' }
HeraRule >> background [

	^ background
]

{ #category : 'accessing' }
HeraRule >> background: aBackground [

	background := aBackground
]

{ #category : 'accessing' }
HeraRule >> description [

	^ description
]

{ #category : 'accessing' }
HeraRule >> description: anArrayOfStrings [

	description := anArrayOfStrings
]

{ #category : 'accessing' }
HeraRule >> inheritedTags [

	^ inheritedTags
]

{ #category : 'accessing' }
HeraRule >> inheritedTags: anArrayOfSymbols [

	| allTags |
	inheritedTags := anArrayOfSymbols.
	allTags := OrderedCollection new
		addAll: self inheritedTags;
		addAll: self tags;
		asArray.
	scenarios do: [ :each| each inheritedTags: allTags ]
]

{ #category : 'initialization' }
HeraRule >> initialize [

	super initialize.
	tags := #().
	inheritedTags := #().
	description := #().
	scenarios := #()
]

{ #category : 'printing' }
HeraRule >> printOn: aStream [

	aStream
		nextPutAll: 'Rule: ';
		nextPutAll: title
]

{ #category : 'accessing' }
HeraRule >> scenarios [

	^ scenarios
]

{ #category : 'accessing' }
HeraRule >> scenarios: anArray [

	scenarios := anArray
]

{ #category : 'accessing' }
HeraRule >> tags [

	^ tags
]

{ #category : 'accessing' }
HeraRule >> tags: anArrayOfSymbols [

	tags := anArrayOfSymbols
]

{ #category : 'accessing' }
HeraRule >> title [

	^ title
]

{ #category : 'accessing' }
HeraRule >> title: aString [

	title := aString
]
