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
HeraRunnerTestCase >> testRestart [

	| expectedRunLog |
	expectedRunLog := 'Feature: Signing in

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

	Scenario: Unsuccessful sign-in
		Given I have credentials to sign in
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong

Total: 2. Passed: 2. Failed: 0. Error: 0.
'.
	subject runAcceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature).
	self assert: subject runLog equals: expectedRunLog.
	subject restart.
	self deny: subject hasRunSteps.
	self deny: subject isRunningScenario.
	subject continue.
	self assert: subject runLog equals: expectedRunLog
]

{ #category : 'tests' }
HeraRunnerTestCase >> testRestartFilteredAcceptanceTest [

	| expectedRunLog |
	expectedRunLog := 'Feature: Signing in

	Scenario: Unsuccessful sign-in
		Given I have credentials to sign in
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong

Total: 1. Passed: 1. Failed: 0. Error: 0.
'.
	subject
		runAcceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature)
		filteredBy: (HeraScenarioFilter new title: 'Unsuccessful sign-in').	
	self assert: subject runLog equals: expectedRunLog.
	subject restart.
	self deny: subject hasRunSteps.
	self deny: subject isRunningScenario.
	subject continue.
	self assert: subject runLog equals: expectedRunLog
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
