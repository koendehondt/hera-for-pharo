Class {
	#name : 'HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'accessing' }
HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting class >> nameInBrowser [

	^ 'Example with error in before scenario hook'
]

{ #category : 'hooks' }
HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting >> afterScenario [

	self stateAt: #afterScenarioWasTriggered put: true
]

{ #category : 'accessing' }
HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting >> afterScenarioWasTriggered [

	^ self stateAt: #afterScenarioWasTriggered
]

{ #category : 'hooks' }
HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting >> beforeScenario [

	self error: 'Some error in the before scenario hook.'
]

{ #category : 'features' }
HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting >> featureWithSingleStepScenarioForTesting [

	<heraFeature: 'With single step scenario for testing'>

	^ (self feature: 'With single step scenario for testing')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'I have credentials to sign in' }
]

{ #category : 'initialization' }
HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting >> initialize [

	super initialize.
	self stateAt: #afterScenarioWasTriggered put: false
]
