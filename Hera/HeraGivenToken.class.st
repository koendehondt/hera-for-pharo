Class {
	#name : 'HeraGivenToken',
	#superclass : 'HeraStepToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
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
