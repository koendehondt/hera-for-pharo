Class {
	#name : 'HeraGherkinParsingError',
	#superclass : 'Error',
	#instVars : [
		'fromIndex',
		'toIndex'
	],
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
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
