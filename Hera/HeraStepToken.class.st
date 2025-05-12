Class {
	#name : 'HeraStepToken',
	#superclass : 'HeraKeywordToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'testing' }
HeraStepToken >> isStepToken [

	^ true
]

{ #category : 'accessing' }
HeraStepToken >> stepAstNodeClass [

	self subclassResponsibility
]
