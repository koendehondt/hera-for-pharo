Class {
	#name : 'HeraDataTreeToken',
	#superclass : 'HeraTextualToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraDataTreeToken class >> keyword [

	^ '>'
]

{ #category : 'testing' }
HeraDataTreeToken >> isDataTreeToken [

	^ true
]
