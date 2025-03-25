Class {
	#name : 'HeraStepToken',
	#superclass : 'HeraKeywordToken',
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'testing' }
HeraStepToken >> isStepToken [

	^ true
]

{ #category : 'accessing' }
HeraStepToken >> stepAstNodeClass [

	self subclassResponsibility
]
