Class {
	#name : 'HeraFeatureToken',
	#superclass : 'HeraKeywordToken',
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'accessing' }
HeraFeatureToken class >> keyword [

	^ 'Feature:'
]

{ #category : 'testing' }
HeraFeatureToken >> isFeatureToken [

	^ true
]
