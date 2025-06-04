Class {
	#name : 'HeraAcceptanceTestWithSingleQuotedStepArgumentsTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsTestCase >> describedClass [

	^ HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting
]

{ #category : 'running' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsTestCase >> initializeSubject [

	subject := self describedClass selector: #featureSigningInWithEmailAndPassword
]

{ #category : 'tests' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsTestCase >> testRunExactStepDefinition [

	subject runStep: (HeraThenStep new description: 'I see the home page').
	self assert: subject seenTheHomePage
]

{ #category : 'tests' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsTestCase >> testRunMatchStepDefinition [

	subject runStep: (HeraWhenStep new description: 'I fill in the field labeled ''First name:''').
	self assert: subject givenFieldLabelArgument equals: 'First name:'.
	subject runStep: (HeraWhenStep new description: 'I fill in the field labeled ''Last name:''').
	self assert: subject givenFieldLabelArgument equals: 'Last name:'
]

{ #category : 'tests' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsTestCase >> testRunRegexStepDefinition [
	
	subject runStep: (HeraWhenStep new description: 'I press the button labeled ''Save''').
	self assert: subject givenButtonLabelArgument equals: 'Save'.
	subject runStep: (HeraWhenStep new description: 'I press the button labeled ''Cancel''').
	self assert: subject givenButtonLabelArgument equals: 'Cancel'
]
