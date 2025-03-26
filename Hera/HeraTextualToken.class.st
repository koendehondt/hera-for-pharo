Class {
	#name : 'HeraTextualToken',
	#superclass : 'HeraNonTerminalToken',
	#instVars : [
		'text'
	],
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'accessing' }
HeraTextualToken >> text [

	^ text
]

{ #category : 'accessing' }
HeraTextualToken >> text: aString [

	text := aString
]
