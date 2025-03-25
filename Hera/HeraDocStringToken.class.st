Class {
	#name : 'HeraDocStringToken',
	#superclass : 'HeraNonTerminalToken',
	#instVars : [
		'lines',
		'indentation'
	],
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'accessing' }
HeraDocStringToken class >> keyword [

	^ '"""'
]

{ #category : 'accessing' }
HeraDocStringToken >> indentation [

	^ indentation
]

{ #category : 'accessing' }
HeraDocStringToken >> indentation: anInteger [

	indentation := anInteger
]

{ #category : 'testing' }
HeraDocStringToken >> isDocStringToken [

	^ true
]

{ #category : 'accessing' }
HeraDocStringToken >> lines [

	^ lines
]

{ #category : 'accessing' }
HeraDocStringToken >> lines: anArrayOfStrings [

	lines := anArrayOfStrings
]
