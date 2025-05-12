Class {
	#name : 'HeraWhenToken',
	#superclass : 'HeraStepToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraWhenToken class >> keyword [

	^ 'When'
]

{ #category : 'accessing' }
HeraWhenToken >> stepAstNodeClass [

	^ HeraWhenAstNode
]
