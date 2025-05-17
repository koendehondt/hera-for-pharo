Class {
	#name : 'HeraAcceptanceTestWithHooksForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#instVars : [
		'isBeforeHookInvoked',
		'isAfterHookInvoked'
	],
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'hooks' }
HeraAcceptanceTestWithHooksForTesting >> afterScenario [

	isAfterHookInvoked := true
]

{ #category : 'hooks' }
HeraAcceptanceTestWithHooksForTesting >> beforeScenario [

	isBeforeHookInvoked := true
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
	isAfterHookInvoked := false.
	isBeforeHookInvoked := false
]

{ #category : 'test api' }
HeraAcceptanceTestWithHooksForTesting >> isAfterHookInvoked [

	^ isAfterHookInvoked
]

{ #category : 'test api' }
HeraAcceptanceTestWithHooksForTesting >> isBeforeHookInvoked [

	^ isBeforeHookInvoked
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
