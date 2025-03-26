Class {
	#name : 'HeraBackgroundToken',
	#superclass : 'HeraKeywordToken',
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'accessing' }
HeraBackgroundToken class >> keyword [

	^ 'Background:'
]

{ #category : 'testing' }
HeraBackgroundToken >> isBackgroundToken [

	^ true
]
