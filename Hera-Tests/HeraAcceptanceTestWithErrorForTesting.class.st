Class {
	#name : 'HeraAcceptanceTestWithErrorForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#category : 'Hera-Tests-Support',
	#package : 'Hera-Tests',
	#tag : 'Support'
}

{ #category : 'accessing' }
HeraAcceptanceTestWithErrorForTesting class >> nameInBrowser [

	^ 'Example with error'
]

{ #category : 'features' }
HeraAcceptanceTestWithErrorForTesting >> signingInFeature [

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
HeraAcceptanceTestWithErrorForTesting >> step1 [
	
	<heraStepDefinition: #(Given 'I have credentials to sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithErrorForTesting >> step10 [
	
	<heraStepDefinition: #(Then 'I see the sign-in page')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithErrorForTesting >> step2 [
	
	<heraStepDefinition: #(When 'I enter my credentials')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithErrorForTesting >> step3 [
	
	<heraStepDefinition: #(When 'I press the button to sign in')>
	
	Error signal: 'Button not found'
]

{ #category : 'steps' }
HeraAcceptanceTestWithErrorForTesting >> step4 [
	
	<heraStepDefinition: #(Then 'I see the home page')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithErrorForTesting >> step5 [
	
	<heraStepDefinition: #(When 'I enter the wrong credentials')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithErrorForTesting >> step6 [
	
	<heraStepDefinition: #(Then 'I see a message that the credentials are wrong')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithErrorForTesting >> step7 [
	
	<heraStepDefinition: #(Then 'I am still on the sign-in page')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithErrorForTesting >> step8 [
	
	<heraStepDefinition: #(Given 'I am signed in')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithErrorForTesting >> step9 [
	
	<heraStepDefinition: #(When 'I sign out')>
]
