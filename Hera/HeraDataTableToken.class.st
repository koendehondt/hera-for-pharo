Class {
	#name : 'HeraDataTableToken',
	#superclass : 'HeraTextualToken',
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'accessing' }
HeraDataTableToken class >> keyword [

	^ '|'
]

{ #category : 'testing' }
HeraDataTableToken >> isDataTableToken [

	^ true
]
