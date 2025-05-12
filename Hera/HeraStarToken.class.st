Class {
	#name : 'HeraStarToken',
	#superclass : 'HeraStepToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraStarToken class >> keyword [

	^ '*'
]

{ #category : 'accessing' }
HeraStarToken >> stepAstNodeClass [

	^ HeraStarAstNode
]
