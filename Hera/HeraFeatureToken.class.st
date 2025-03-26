Class {
	#name : 'HeraFeatureToken',
	#superclass : 'HeraKeywordToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraFeatureToken class >> keyword [

	^ 'Feature:'
]

{ #category : 'testing' }
HeraFeatureToken >> isFeatureToken [

	^ true
]
