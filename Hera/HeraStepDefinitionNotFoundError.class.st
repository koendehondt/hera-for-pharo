Class {
	#name : 'HeraStepDefinitionNotFoundError',
	#superclass : 'Error',
	#category : 'Hera-Step definitions',
	#package : 'Hera',
	#tag : 'Step definitions'
}

{ #category : 'initialization' }
HeraStepDefinitionNotFoundError >> initialize [

	super initialize.
	self messageText: 'Step definition not found.'
]
