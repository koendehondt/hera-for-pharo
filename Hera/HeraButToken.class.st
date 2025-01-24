Class {
	#name : 'HeraButToken',
	#superclass : 'HeraStepToken',
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'accessing' }
HeraButToken class >> keyword [

	^ 'But'
]

{ #category : 'testing' }
HeraButToken >> isAllowedInBackground [

	^ true
]

{ #category : 'accessing' }
HeraButToken >> stepAstNodeClass [

	^ HeraButAstNode
]
