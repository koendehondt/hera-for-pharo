Class {
	#name : 'HeraExamplesToken',
	#superclass : 'HeraKeywordToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraExamplesToken class >> keyword [

	^ 'Examples:'
]

{ #category : 'testing' }
HeraExamplesToken >> isExamplesToken [

	^ true
]
