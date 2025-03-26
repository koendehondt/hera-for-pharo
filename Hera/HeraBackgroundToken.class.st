Class {
	#name : 'HeraBackgroundToken',
	#superclass : 'HeraKeywordToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraBackgroundToken class >> keyword [

	^ 'Background:'
]

{ #category : 'testing' }
HeraBackgroundToken >> isBackgroundToken [

	^ true
]
