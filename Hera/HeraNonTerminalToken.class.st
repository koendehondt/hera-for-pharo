Class {
	#name : 'HeraNonTerminalToken',
	#superclass : 'HeraToken',
	#instVars : [
		'start',
		'end'
	],
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'comparing' }
HeraNonTerminalToken >> = anotherToken [

	^ super = anotherToken and: [ anotherToken start = self start and: [anotherToken end = self end ] ]
]

{ #category : 'accessing' }
HeraNonTerminalToken >> end [

	^ end
]

{ #category : 'accessing' }
HeraNonTerminalToken >> end: anObject [

	end := anObject
]

{ #category : 'accessing' }
HeraNonTerminalToken >> start [

	^ start
]

{ #category : 'accessing' }
HeraNonTerminalToken >> start: anObject [

	start := anObject
]
