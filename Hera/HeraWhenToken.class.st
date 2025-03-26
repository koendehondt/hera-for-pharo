Class {
	#name : 'HeraWhenToken',
	#superclass : 'HeraStepToken',
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'accessing' }
HeraWhenToken class >> keyword [

	^ 'When'
]

{ #category : 'accessing' }
HeraWhenToken >> stepAstNodeClass [

	^ HeraWhenAstNode
]
