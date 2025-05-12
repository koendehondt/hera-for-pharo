Class {
	#name : 'HeraButToken',
	#superclass : 'HeraStepToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
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
