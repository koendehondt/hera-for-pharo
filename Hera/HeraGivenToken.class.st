Class {
	#name : 'HeraGivenToken',
	#superclass : 'HeraStepToken',
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'accessing' }
HeraGivenToken class >> keyword [

	^ 'Given'
]

{ #category : 'testing' }
HeraGivenToken >> isAllowedInBackground [

	^ true
]

{ #category : 'accessing' }
HeraGivenToken >> stepAstNodeClass [

	^ HeraGivenAstNode
]
