Class {
	#name : 'HeraRunnerTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Runner',
	#package : 'Hera-UI-Tests',
	#tag : 'Runner'
}

{ #category : 'running' }
HeraRunnerTestCase >> describedClass [

	^ HeraRunner
]

{ #category : 'tests' }
HeraRunnerTestCase >> testDebugAcceptanceTest [

	subject debugAcceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature).
	self assert: subject hasRunAllScenarios
]

{ #category : 'tests' }
HeraRunnerTestCase >> testDebugAcceptanceTestFilteredBy [

	| acceptanceTest |
	acceptanceTest := HeraAcceptanceTestWithPassForTesting selector: #signingInFeature.
	self assert: acceptanceTest feature scenarios size equals: 2.
	subject
		debugAcceptanceTest: acceptanceTest
		filteredBy: (HeraScenarioFilter new title: 'Unsuccessful sign-in').
	self assert: subject hasRunAllScenarios.
	self assert: subject result totalCount equals: 1.
]

{ #category : 'tests' }
HeraRunnerTestCase >> testRunAcceptanceTest [

	subject runAcceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature).
	self assert: subject hasRunAllScenarios
]

{ #category : 'tests' }
HeraRunnerTestCase >> testStepAcceptanceTest [

	subject stepAcceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature).
	self deny: subject hasRunSteps
]

{ #category : 'tests' }
HeraRunnerTestCase >> testStepping [

	subject
		stepAcceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature);
		stepOver;
		stepOver;
		stepOver;
		stepOverScenario;
		stepOver;
		stepOver;
		continue.
	self assert: subject hasRunAllScenarios
]
