Class {
	#name : 'HeraAcceptanceTestWithHooksForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'hooks' }
HeraAcceptanceTestWithHooksForTesting >> afterScenario [

	self stateAt: #isAfterHookInvoked put: true
]

{ #category : 'hooks' }
HeraAcceptanceTestWithHooksForTesting >> beforeScenario [

	self stateAt: #isBeforeHookInvoked put: true
]

{ #category : 'features' }
HeraAcceptanceTestWithHooksForTesting >> featureWithHooks [

	<heraFeature: 'With hooks for testing'>

	^ (self feature: 'With hooks for testing')
		scenarios: {
			(self scenario: 'Doing and seeing something')
				when: 'I do something';
				then: 'I see something' }
]

{ #category : 'initialization' }
HeraAcceptanceTestWithHooksForTesting >> initialize [

	super initialize.
	self stateAt: #isAfterHookInvoked put: false.
	self stateAt: #isBeforeHookInvoked put: false
]

{ #category : 'test api' }
HeraAcceptanceTestWithHooksForTesting >> isAfterHookInvoked [

	^ self stateAt: #isAfterHookInvoked
]

{ #category : 'test api' }
HeraAcceptanceTestWithHooksForTesting >> isBeforeHookInvoked [

	^ self stateAt: #isBeforeHookInvoked
]

{ #category : 'steps' }
HeraAcceptanceTestWithHooksForTesting >> stepIDoSomething [

	<heraStepDefinition: #(When 'I do something')>
	
	"Implementation not required for the test that uses this class."
]

{ #category : 'steps' }
HeraAcceptanceTestWithHooksForTesting >> stepISeeSomething [

	<heraStepDefinition: #(Then 'I see something')>
	
	"Implementation not required for the test that uses this class."
]
