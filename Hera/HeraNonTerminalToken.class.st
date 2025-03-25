Class {
	#name : 'HeraNonTerminalToken',
	#superclass : 'HeraToken',
	#instVars : [
		'end'
	],
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'accessing' }
HeraNonTerminalToken >> end [

	^ end
]

{ #category : 'accessing' }
HeraNonTerminalToken >> end: anObject [

	end := anObject
]
