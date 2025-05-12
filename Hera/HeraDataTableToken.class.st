Class {
	#name : 'HeraDataTableToken',
	#superclass : 'HeraTextualToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraDataTableToken class >> keyword [

	^ '|'
]

{ #category : 'testing' }
HeraDataTableToken >> isDataTableToken [

	^ true
]
