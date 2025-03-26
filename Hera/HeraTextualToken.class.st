Class {
	#name : 'HeraTextualToken',
	#superclass : 'HeraNonTerminalToken',
	#instVars : [
		'text'
	],
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraTextualToken >> text [

	^ text
]

{ #category : 'accessing' }
HeraTextualToken >> text: aString [

	text := aString
]
