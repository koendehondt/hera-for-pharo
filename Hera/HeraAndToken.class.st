Class {
	#name : 'HeraAndToken',
	#superclass : 'HeraStepToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
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
