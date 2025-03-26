Class {
	#name : 'HeraGherkinParsingError',
	#superclass : 'Error',
	#instVars : [
		'fromIndex',
		'toIndex'
	],
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraGherkinParsingError >> end [

	^ toIndex
]

{ #category : 'accessing' }
HeraGherkinParsingError >> end: sourceEndIndex [

	toIndex := sourceEndIndex
]

{ #category : 'accessing' }
HeraGherkinParsingError >> start [

	^ fromIndex
]

{ #category : 'accessing' }
HeraGherkinParsingError >> start: sourceStartIndex [

	fromIndex := sourceStartIndex
]
