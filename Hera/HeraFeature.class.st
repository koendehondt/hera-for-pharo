Class {
	#name : 'HeraFeature',
	#superclass : 'HeraScriptElement',
	#instVars : [
		'scenarios',
		'description',
		'tags',
		'background',
		'rules',
		'title'
	],
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraFeature >> accept: visitor [

	visitor visitFeature: self
]

{ #category : 'accessing' }
HeraFeature >> background [

	^ background
]

{ #category : 'accessing' }
HeraFeature >> background: aBackground [

	background := aBackground
]

{ #category : 'accessing' }
HeraFeature >> description [

	^ description
]

{ #category : 'accessing' }
HeraFeature >> description: anArrayOfStrings [

	description := anArrayOfStrings
]

{ #category : 'initialization' }
HeraFeature >> initialize [

	super initialize.
	tags := #().
	description := #().
	scenarios := #().
	rules := #()
]

{ #category : 'printing' }
HeraFeature >> printOn: aStream [

	aStream
		nextPutAll: 'Feature: ';
		nextPutAll: title
]

{ #category : 'accessing' }
HeraFeature >> richScript [

	^ (HeraScriptGenerator new visit: self) generatedScript
]

{ #category : 'accessing' }
HeraFeature >> rules [

	^ rules
]

{ #category : 'accessing' }
HeraFeature >> rules: anArray [

	rules := anArray
]

{ #category : 'accessing' }
HeraFeature >> scenarios [

	^ scenarios
]

{ #category : 'accessing' }
HeraFeature >> scenarios: anArray [

	scenarios := anArray
]

{ #category : 'accessing' }
HeraFeature >> script [

	^ self richScript string
]

{ #category : 'accessing' }
HeraFeature >> tags [

	^ tags
]

{ #category : 'accessing' }
HeraFeature >> tags: anArrayOfSymbols [

	tags := anArrayOfSymbols
]

{ #category : 'accessing' }
HeraFeature >> title [

	^ title
]

{ #category : 'accessing' }
HeraFeature >> title: aString [

	title := aString
]
