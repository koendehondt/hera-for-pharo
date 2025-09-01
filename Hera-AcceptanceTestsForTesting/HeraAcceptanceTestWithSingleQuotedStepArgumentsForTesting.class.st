Class {
	#name : 'HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
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

	^ self stateAt: #givenButtonLabelArgument
]

{ #category : 'test api' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> givenFieldLabelArgument [

	^ self stateAt: #givenFieldLabelArgument
]

{ #category : 'preferences' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> prefersDoubleQuotedStringArgumentsInStepDefinitions [

	^ false
]

{ #category : 'accessing' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> seenTheHomePage [

	^ self stateAt: #seenTheHomePage
]

{ #category : 'steps' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> stepIAmOnTheSignInPage [
	
	<heraStepDefinition: #(Given 'I am on the sign-in page')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> stepIFillInTheFieldLabeled: fieldLabel [

	<heraStepDefinition: #(When match 'I fill in the field labeled {string}')>

	self stateAt: #givenFieldLabelArgument put: fieldLabel
]

{ #category : 'steps' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> stepIPressTheButtonLabeled: buttonLabel [

	<heraStepDefinition: #(When regex 'I press the button labeled ''([^"]+)''')>

	self stateAt: #givenButtonLabelArgument put: buttonLabel
]

{ #category : 'steps' }
HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting >> stepISeeTheHomePage [

	<heraStepDefinition: #(Then 'I see the home page')>

	self stateAt: #seenTheHomePage put: true
]
