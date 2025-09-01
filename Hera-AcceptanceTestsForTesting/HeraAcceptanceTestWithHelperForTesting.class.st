Class {
	#name : 'HeraAcceptanceTestWithHelperForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#instVars : [
		'fieldHelper'
	],
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'features' }
HeraAcceptanceTestWithHelperForTesting >> featureSigningInWithEmailAndPassword [

	<heraFeature: 'Signing in with email and password'>

	^ (self feature: 'Signing in with email and password')
		scenarios: {
			(self scenario: 'Signing in')
				given: 'I am on the sign-in page';
				when: 'I fill in the field labeled "Email:"';
				and: 'I fill in the field labeled "Password:"';
				and: 'I press the button labeled "Sign in"';
				then: 'I see the home page' }
]

{ #category : 'test api' }
HeraAcceptanceTestWithHelperForTesting >> givenButtonLabelArgument [

	^ fieldHelper givenButtonLabelArgument
]

{ #category : 'test api' }
HeraAcceptanceTestWithHelperForTesting >> givenFieldLabelArgument [

	^ fieldHelper givenFieldLabelArgument
]

{ #category : 'initialization' }
HeraAcceptanceTestWithHelperForTesting >> registerHelpers [

	fieldHelper := HeraHelperForTesting new.
	self registerHelper: fieldHelper
]

{ #category : 'test api' }
HeraAcceptanceTestWithHelperForTesting >> seenTheHomePage [

	^ fieldHelper seenTheHomePage
]

{ #category : 'test api' }
HeraAcceptanceTestWithHelperForTesting >> seenTheSignInPage [

	^ self stateAt: #seenTheSignInPage
]

{ #category : 'steps' }
HeraAcceptanceTestWithHelperForTesting >> stepIAmOnTheSignInPage [
	
	<heraStepDefinition: #(Given 'I am on the sign-in page')>

	self stateAt: #seenTheSignInPage put: true
]
