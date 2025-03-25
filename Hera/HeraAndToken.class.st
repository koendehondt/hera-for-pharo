Class {
	#name : 'HeraAndToken',
	#superclass : 'HeraStepToken',
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'accessing' }
HeraAndToken class >> keyword [

	^ 'And'
]

{ #category : 'testing' }
HeraAndToken >> isAllowedInBackground [

	^ true
]

{ #category : 'accessing' }
HeraAndToken >> stepAstNodeClass [

	^ HeraAndAstNode
]
