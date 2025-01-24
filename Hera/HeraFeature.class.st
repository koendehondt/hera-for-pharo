Class {
	#name : 'HeraFeature',
	#superclass : 'HeraScriptElement',
	#instVars : [
		'scenarios',
		'details',
		'description',
		'tags',
		'name',
		'background'
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

{ #category : 'accessing' }
HeraFeature >> details: aString [

	details := aString
]

{ #category : 'initialization' }
HeraFeature >> initialize [

	super initialize.
	tags := #().
	description := #().
	scenarios := #()
]

{ #category : 'accessing' }
HeraFeature >> name [

	^ name
]

{ #category : 'accessing' }
HeraFeature >> name: anObject [

	name := anObject
]

{ #category : 'printing' }
HeraFeature >> printOn: aStream [

	aStream
		nextPutAll: 'Feature: ';
		nextPutAll: name
]

{ #category : 'accessing' }
HeraFeature >> richScript [

	^ (HeraScriptGenerator new visit: self) generatedScript
]

{ #category : 'accessing' }
HeraFeature >> scenarios [

	^ scenarios
]

{ #category : 'accessing' }
HeraFeature >> scenarios: anArray [

	scenarios := anArray.
	anArray do: [ :each | each feature: self ]
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
