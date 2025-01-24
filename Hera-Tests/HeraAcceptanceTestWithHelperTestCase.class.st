Class {
	#name : 'HeraAcceptanceTestWithHelperTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraAcceptanceTestWithHelperTestCase >> describedClass [

	^ HeraAcceptanceTest
]

{ #category : 'running' }
HeraAcceptanceTestWithHelperTestCase >> initializeSubject [

	subject := HeraAcceptanceTestWithHelperForTesting selector: #featureSigningInWithEmailAndPassword
]

{ #category : 'tests' }
HeraAcceptanceTestWithHelperTestCase >> testRunExactStepDefinitionOnAcceptanceTest [

	subject runStep: (HeraGivenStep new description: 'I am on the sign-in page').
	self assert: subject seenTheSignInPage
]

{ #category : 'tests' }
HeraAcceptanceTestWithHelperTestCase >> testRunExactStepDefinitionOnHelper [

	subject runStep: (HeraThenStep new description: 'I see the home page').
	self assert: subject seenTheHomePage
]

{ #category : 'tests' }
HeraAcceptanceTestWithHelperTestCase >> testRunMatchStepDefinitionOnHelper [

	subject runStep: (HeraWhenStep new description: 'I fill in the field labeled "First name:"').
	self assert: subject givenFieldLabelArgument equals: 'First name:'.
	subject runStep: (HeraWhenStep new description: 'I fill in the field labeled "Last name:"').
	self assert: subject givenFieldLabelArgument equals: 'Last name:'
]

{ #category : 'tests' }
HeraAcceptanceTestWithHelperTestCase >> testRunRegexStepDefinitionOnHelper [
	
	subject runStep: (HeraWhenStep new description: 'I press the button labeled "Save"').
	self assert: subject givenButtonLabelArgument equals: 'Save'.
	subject runStep: (HeraWhenStep new description: 'I press the button labeled "Cancel"').
	self assert: subject givenButtonLabelArgument equals: 'Cancel'
]
