Class {
	#name : 'HeraThenToken',
	#superclass : 'HeraStepToken',
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'accessing' }
HeraThenToken class >> keyword [

	^ 'Then'
]

{ #category : 'accessing' }
HeraThenToken >> stepAstNodeClass [

	^ HeraThenAstNode
]
