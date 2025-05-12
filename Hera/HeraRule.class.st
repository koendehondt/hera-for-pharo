Class {
	#name : 'HeraRule',
	#superclass : 'HeraScriptElement',
	#instVars : [
		'scenarios',
		'description',
		'title',
		'background'
	],
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraRule >> accept: visitor [

	visitor visitRule: self
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

{ #category : 'initialization' }
HeraRule >> initialize [

	super initialize.
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

	scenarios := anArray.
	anArray do: [ :each | each feature: self ]
]

{ #category : 'accessing' }
HeraRule >> title [

	^ title
]

{ #category : 'accessing' }
HeraRule >> title: aString [

	title := aString
]
