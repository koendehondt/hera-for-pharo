Class {
	#name : 'HeraParsingError',
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
HeraParsingError >> end [

	^ end
]

{ #category : 'accessing' }
HeraParsingError >> end: sourceEndIndex [

	end := sourceEndIndex
]

{ #category : 'accessing' }
HeraParsingError >> start [

	^ start
]

{ #category : 'accessing' }
HeraParsingError >> start: sourceStartIndex [

	start := sourceStartIndex
]
