Class {
	#name : 'HeraAcceptanceTestWithStepArgumentsForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#instVars : [
		'givenFieldLabelArgument',
		'givenButtonLabelArgument',
		'seenTheHomePage'
	],
	#category : 'Hera-Tests-Support',
	#package : 'Hera-Tests',
	#tag : 'Support'
}

{ #category : 'features' }
HeraAcceptanceTestWithStepArgumentsForTesting >> featureSigningInWithEmailAndPassword [

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
HeraAcceptanceTestWithStepArgumentsForTesting >> givenButtonLabelArgument [

	^ givenButtonLabelArgument
]

{ #category : 'test api' }
HeraAcceptanceTestWithStepArgumentsForTesting >> givenFieldLabelArgument [

	^ givenFieldLabelArgument
]

{ #category : 'test api' }
HeraAcceptanceTestWithStepArgumentsForTesting >> seenTheHomePage [

	^ seenTheHomePage
]

{ #category : 'steps' }
HeraAcceptanceTestWithStepArgumentsForTesting >> stepIAmOnTheSignInPage [
	
	<heraStepDefinition: #(Given 'I am on the sign-in page')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithStepArgumentsForTesting >> stepIFillInTheFieldLabeled: fieldLabel [

	<heraStepDefinition: #(When match 'I fill in the field labeled {string}')>

	givenFieldLabelArgument := fieldLabel
]

{ #category : 'steps' }
HeraAcceptanceTestWithStepArgumentsForTesting >> stepIPressTheButtonLabeled: buttonLabel [

	<heraStepDefinition: #(When regex 'I press the button labeled "([^"]+)"')>

	givenButtonLabelArgument := buttonLabel
]

{ #category : 'steps' }
HeraAcceptanceTestWithStepArgumentsForTesting >> stepISeeTheHomePage [

	<heraStepDefinition: #(Then 'I see the home page')>

	seenTheHomePage := true
]
