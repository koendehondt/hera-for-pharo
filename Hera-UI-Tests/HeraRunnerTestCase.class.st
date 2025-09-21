Class {
	#name : 'HeraRunnerTestCase',
	#superclass : 'HeraUnitTestCase',
	#instVars : [
		'openedRunner'
	],
	#category : 'Hera-UI-Tests-Runner',
	#package : 'Hera-UI-Tests',
	#tag : 'Runner'
}

{ #category : 'running' }
HeraRunnerTestCase >> describedClass [

	^ HeraRunner
]

{ #category : 'running' }
HeraRunnerTestCase >> tearDown [

	openedRunner ifNotNil: [ openedRunner window close ].
	super tearDown
]

{ #category : 'tests' }
HeraRunnerTestCase >> testDebugScenario [

	| scenario acceptanceTest |
	acceptanceTest := HeraAcceptanceTestWithErrorForTesting selector: #signingInFeature.
	subject runScope: acceptanceTest asRunnerScope.
	subject afterOpenDebugRunnerBlock: [ :runner | openedRunner := runner ].
	scenario := acceptanceTest feature scenarios first.
	self should: [ subject debugScenario: scenario ] raise: Error
]

{ #category : 'tests' }
HeraRunnerTestCase >> testDebugScope [

	subject debugScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	self assert: subject hasRunAllScenarios
]

{ #category : 'tests' }
HeraRunnerTestCase >> testDebugScopeFilteredBy [

	| acceptanceTest |
	acceptanceTest := HeraAcceptanceTestWithPassForTesting selector: #signingInFeature.
	self assert: acceptanceTest feature scenarios size equals: 2.
	subject
		debugScope: acceptanceTest asRunnerScope
		filteredBy: (HeraScenarioFilter new title: 'Unsuccessful sign-in').
	self assert: subject hasRunAllScenarios.
	self assert: subject result totalCount equals: 1.
]

{ #category : 'tests' }
HeraRunnerTestCase >> testRestart [

	| expectedRunLog |
	expectedRunLog := 'Running 1 feature.


Feature: Signing in

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


Total: 2 scenarios. Passed: 2. Failed: 0. Error: 0.
'.
	subject runScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	self assert: subject runLog equals: expectedRunLog.
	subject restart.
	self deny: subject hasRunSteps.
	self deny: subject isRunningScenario.
	subject continue.
	self assert: subject runLog equals: expectedRunLog
]

{ #category : 'tests' }
HeraRunnerTestCase >> testRestartFilteredScope [

	| expectedRunLog |
	expectedRunLog := 'Running 1 feature.


Feature: Signing in

	Scenario: Unsuccessful sign-in
		Given I have credentials to sign in
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0.
'.
	subject
		runScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope
		filteredBy: (HeraScenarioFilter new title: 'Unsuccessful sign-in').	
	self assert: subject runLog equals: expectedRunLog.
	subject restart.
	self deny: subject hasRunSteps.
	self deny: subject isRunningScenario.
	subject continue.
	self assert: subject runLog equals: expectedRunLog
]

{ #category : 'tests' }
HeraRunnerTestCase >> testRunScope [

	subject runScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	self assert: subject hasRunAllScenarios
]

{ #category : 'tests' }
HeraRunnerTestCase >> testStepScope [

	subject stepScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	self deny: subject hasRunSteps
]

{ #category : 'tests' }
HeraRunnerTestCase >> testStepping [

	subject
		stepScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope;
		stepOver;
		stepOver;
		stepOver;
		stepOverScenario;
		stepOver;
		stepOver;
		continue.
	self assert: subject hasRunAllScenarios
]
