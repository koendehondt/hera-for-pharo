Class {
	#name : 'HeraGherkinParsingError',
	#superclass : 'Error',
	#instVars : [
		'start',
		'end'
	],
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraGherkinParsingError >> end [

	^ end
]

{ #category : 'accessing' }
HeraGherkinParsingError >> end: sourceEndIndex [

	end := sourceEndIndex
]

{ #category : 'accessing' }
HeraGherkinParsingError >> start [

	^ start
]

{ #category : 'accessing' }
HeraGherkinParsingError >> start: sourceStartIndex [

	start := sourceStartIndex
]
