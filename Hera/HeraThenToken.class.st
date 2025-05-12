Class {
	#name : 'HeraThenToken',
	#superclass : 'HeraStepToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraThenToken class >> keyword [

	^ 'Then'
]

{ #category : 'accessing' }
HeraThenToken >> stepAstNodeClass [

	^ HeraThenAstNode
]
