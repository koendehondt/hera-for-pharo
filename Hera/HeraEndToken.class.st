Class {
	#name : 'HeraEndToken',
	#superclass : 'HeraToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'comparing' }
HeraEndToken >> = anotherToken [

	^ super = anotherToken and: [ anotherToken start = self start and: [anotherToken end = self end ] ]
]

{ #category : 'accessing' }
HeraEndToken >> end [

	^ start
]
