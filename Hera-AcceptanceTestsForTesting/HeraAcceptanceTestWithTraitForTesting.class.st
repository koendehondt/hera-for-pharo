Class {
	#name : 'HeraAcceptanceTestWithTraitForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#traits : 'HeraWidgetHelperTraitForTesting',
	#classTraits : 'HeraWidgetHelperTraitForTesting classTrait',
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'features' }
HeraAcceptanceTestWithTraitForTesting >> featureSigningInWithEmailAndPassword [

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
HeraAcceptanceTestWithTraitForTesting >> seenTheSignInPage [

	^ self stateAt: #seenTheSignInPage
]

{ #category : 'steps' }
HeraAcceptanceTestWithTraitForTesting >> stepIAmOnTheSignInPage [
	
	<heraStepDefinition: #(Given 'I am on the sign-in page')>

	self stateAt: #seenTheSignInPage put: true
]
