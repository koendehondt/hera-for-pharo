Class {
	#name : 'HeraEndToken',
	#superclass : 'HeraToken',
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'comparing' }
HeraEndToken >> = anotherToken [

	^ super = anotherToken and: [ anotherToken start = self start and: [anotherToken end = self end ] ]
]

{ #category : 'accessing' }
HeraEndToken >> end [

	^ start
]
