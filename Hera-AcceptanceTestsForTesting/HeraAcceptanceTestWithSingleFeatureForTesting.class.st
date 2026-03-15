Class {
	#name : 'HeraAcceptanceTestWithSingleFeatureForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'features' }
HeraAcceptanceTestWithSingleFeatureForTesting >> featureWithPauseAndDebugSteps [

	<heraFeature: 'With pause step'>

	^ (self feature: 'With pause step')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'I have credentials to sign in';
				when: 'I pause';
				when: 'I debug';
				when: 'I enter my credentials';
				and: 'I press the button to sign in';
				then: 'I see the home page' }
]

{ #category : 'steps' }
HeraAcceptanceTestWithSingleFeatureForTesting >> stepIEnterMyCredentials [
	
	<heraStepDefinition: #(When 'I enter my credentials')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithSingleFeatureForTesting >> stepIHaveCredentialsToSignIn [
	
	<heraStepDefinition: #(Given 'I have credentials to sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithSingleFeatureForTesting >> stepIPressTheButtonToSignIn [
	
	<heraStepDefinition: #(When 'I press the button to sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithSingleFeatureForTesting >> stepISeeTheHomePage [
	
	<heraStepDefinition: #(Then 'I see the home page')>
]
