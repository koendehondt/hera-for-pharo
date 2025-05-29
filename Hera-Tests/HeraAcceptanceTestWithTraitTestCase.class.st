Class {
	#name : 'HeraAcceptanceTestWithTraitTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraAcceptanceTestWithTraitTestCase >> describedClass [

	^ HeraAcceptanceTest
]

{ #category : 'running' }
HeraAcceptanceTestWithTraitTestCase >> initializeSubject [

	subject := HeraAcceptanceTestWithTraitForTesting selector: #featureSigningInWithEmailAndPassword
]

{ #category : 'tests' }
HeraAcceptanceTestWithTraitTestCase >> testRunExactStepDefinitionOnAcceptanceTest [

	subject runStep: (HeraGivenStep new description: 'I am on the sign-in page').
	self assert: subject seenTheSignInPage
]

{ #category : 'tests' }
HeraAcceptanceTestWithTraitTestCase >> testRunExactStepDefinitionOnTrait [

	subject runStep: (HeraThenStep new description: 'I see the home page').
	self assert: subject seenTheHomePage
]

{ #category : 'tests' }
HeraAcceptanceTestWithTraitTestCase >> testRunMatchStepDefinitionOnTrait [

	subject runStep: (HeraWhenStep new description: 'I fill in the field labeled "First name:"').
	self assert: subject givenFieldLabelArgument equals: 'First name:'.
	subject runStep: (HeraWhenStep new description: 'I fill in the field labeled "Last name:"').
	self assert: subject givenFieldLabelArgument equals: 'Last name:'
]

{ #category : 'tests' }
HeraAcceptanceTestWithTraitTestCase >> testRunRegexStepDefinitionOnTrait [
	
	subject runStep: (HeraWhenStep new description: 'I press the button labeled "Save"').
	self assert: subject givenButtonLabelArgument equals: 'Save'.
	subject runStep: (HeraWhenStep new description: 'I press the button labeled "Cancel"').
	self assert: subject givenButtonLabelArgument equals: 'Cancel'
]
