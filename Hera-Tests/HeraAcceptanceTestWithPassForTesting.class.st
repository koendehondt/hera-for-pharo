Class {
	#name : 'HeraAcceptanceTestWithPassForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#classInstVars : [
		'showInBrowser'
	],
	#category : 'Hera-Tests-Support',
	#package : 'Hera-Tests',
	#tag : 'Support'
}

{ #category : 'class initialization' }
HeraAcceptanceTestWithPassForTesting class >> initialize [

	self showInBrowser: false
]

{ #category : 'accessing' }
HeraAcceptanceTestWithPassForTesting class >> nameInBrowser [

	^ 'Example with pass and unimplemented step'
]

{ #category : 'testing' }
HeraAcceptanceTestWithPassForTesting class >> showInBrowser [

	^ showInBrowser
]

{ #category : 'accessing' }
HeraAcceptanceTestWithPassForTesting class >> showInBrowser: aBoolean [

	showInBrowser := aBoolean
]

{ #category : 'features' }
HeraAcceptanceTestWithPassForTesting >> signingInFeature [

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

{ #category : 'features' }
HeraAcceptanceTestWithPassForTesting >> signingOutFeature [

	<heraFeature: 'Signing out'>

	^ (self feature: 'Signing out')
		tags: {
			#accessing_the_system .
			#signing_out };
		scenarios: {
			(self scenario: 'Signing out')
				tags: {
					#sign_out };
				given: 'I am logged in';
				when: 'I sign out';
				then: 'I see the landing page' }
]

{ #category : 'steps' }
HeraAcceptanceTestWithPassForTesting >> step1 [
	
	<heraStepDefinition: #(Given 'I have credentials to sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithPassForTesting >> step10 [
	
	<heraStepDefinition: #(Then 'I see the sign-in page')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithPassForTesting >> step2 [
	
	<heraStepDefinition: #(When 'I enter my credentials')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithPassForTesting >> step3 [
	
	<heraStepDefinition: #(When 'I press the button to sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithPassForTesting >> step4 [
	
	<heraStepDefinition: #(Then 'I see the home page')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithPassForTesting >> step5 [
	
	<heraStepDefinition: #(When 'I enter the wrong credentials')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithPassForTesting >> step6 [
	
	<heraStepDefinition: #(Then 'I see a message that the credentials are wrong')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithPassForTesting >> step7 [
	
	<heraStepDefinition: #(Then 'I am still on the sign-in page')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithPassForTesting >> step8 [
	
	<heraStepDefinition: #(Given 'I am signed in')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithPassForTesting >> step9 [
	
	<heraStepDefinition: #(When 'I sign out')>
]
