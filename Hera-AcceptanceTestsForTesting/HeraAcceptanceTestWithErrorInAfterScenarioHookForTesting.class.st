Class {
	#name : 'HeraAcceptanceTestWithErrorInAfterScenarioHookForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'accessing' }
HeraAcceptanceTestWithErrorInAfterScenarioHookForTesting class >> nameInBrowser [

	^ 'Example with error in after scenario hook'
]

{ #category : 'hooks' }
HeraAcceptanceTestWithErrorInAfterScenarioHookForTesting >> afterScenario [

	self error: 'Some error in the after scenario hook.'
]

{ #category : 'features' }
HeraAcceptanceTestWithErrorInAfterScenarioHookForTesting >> featureWithSingleStepScenarioForTesting [

	<heraFeature: 'With single step scenario for testing'>

	^ (self feature: 'With single step scenario for testing')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'I have credentials to sign in' }
]

{ #category : 'features' }
HeraAcceptanceTestWithErrorInAfterScenarioHookForTesting >> stepIHaveCredentialsToSignIn [

	<heraStepDefinition: #(Given 'I have credentials to sign in')>
]
