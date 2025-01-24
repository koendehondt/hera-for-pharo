Class {
	#name : 'HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting',
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
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> featureSigningInWithEmailAndPassword [

	<heraFeature: 'Signing in with email and password'>

	^ (self feature: 'Signing in with email and password')
		scenarios: {
			(self scenario: 'Signing in')
				given: 'I am on the sign-in page';
				when: 'I fill in the field labeled ''Email:''';
				and: 'I fill in the field labeled ''Password:''';
				and: 'I press the button labeled ''Sign in''';
				then: 'I see the home page' }
]

{ #category : 'test api' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> givenButtonLabelArgument [

	^ givenButtonLabelArgument
]

{ #category : 'test api' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> givenFieldLabelArgument [

	^ givenFieldLabelArgument
]

{ #category : 'preferences' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> prefersDoubleQuotedStringArgumentsInStepDefinitions [

	^ false
]

{ #category : 'accessing' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> seenTheHomePage [

	^ seenTheHomePage
]

{ #category : 'steps' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> stepIAmOnTheSignInPage [
	
	<heraStepDefinition: #(Given 'I am on the sign-in page')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> stepIFillInTheFieldLabeled: fieldLabel [

	<heraStepDefinition: #(When match 'I fill in the field labeled {string}')>

	givenFieldLabelArgument := fieldLabel
]

{ #category : 'steps' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> stepIPressTheButtonLabeled: buttonLabel [

	<heraStepDefinition: #(When regex 'I press the button labeled ''([^"]+)''')>

	givenButtonLabelArgument := buttonLabel
]

{ #category : 'steps' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> stepISeeTheHomePage [

	<heraStepDefinition: #(Then 'I see the home page')>

	seenTheHomePage := true
]
