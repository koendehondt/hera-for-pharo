Class {
	#name : 'HeraAcceptanceTestWithFailureForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'accessing' }
HeraAcceptanceTestWithFailureForTesting class >> nameInBrowser [

	^ 'Example with failure'
]

{ #category : 'features' }
HeraAcceptanceTestWithFailureForTesting >> signingInFeature [

	<heraFeature: 'Signing in'>

	^ (self feature: 'Signing in')
		tags: {
			#accessing_the_system .
			#signing_in };
		description: {
			'Signing in is required to have access to the application.' .
			'' .
			'Signing in requires credentials: an email address and a password.' };
		scenarios: {
			(self scenario: 'Successful sign-in')
				tags: {
					#sign_in };
				description: {
					'Access is allowed when the credentials are recognized.' };
				given: 'I have credentials to sign in';
				when: 'I enter my credentials';
				and: 'I press the button to sign in';
				then: 'I see the home page' .
			(self scenario: 'Unsuccessful sign-in')
				given: 'I have credentials to sign in';
				when: 'I enter the wrong credentials';
				and: 'I press the button to sign in';
				then: 'I am still on the sign-in page';
				but: 'I see a message that the credentials are wrong' }
]

{ #category : 'steps' }
HeraAcceptanceTestWithFailureForTesting >> step1 [
	
	<heraStepDefinition: #(Given 'I have credentials to sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithFailureForTesting >> step2 [
	
	<heraStepDefinition: #(When 'I enter my credentials')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithFailureForTesting >> step3 [
	
	<heraStepDefinition: #(When 'I press the button to sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithFailureForTesting >> step4 [
	
	<heraStepDefinition: #(Then 'I see the home page')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithFailureForTesting >> step5 [
	
	<heraStepDefinition: #(When 'I enter the wrong credentials')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithFailureForTesting >> step6 [
	
	<heraStepDefinition: #(Then 'I see a message that the credentials are wrong')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithFailureForTesting >> step7 [
	
	<heraStepDefinition: #(Then 'I am still on the sign-in page')>

	self expect: false description: 'The current page is not the sign-in page.'
]
