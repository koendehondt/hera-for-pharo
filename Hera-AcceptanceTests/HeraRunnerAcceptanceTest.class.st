Class {
	#name : 'HeraRunnerAcceptanceTest',
	#superclass : 'HeraSelfAcceptanceTest',
	#instVars : [
		'instanceVariable',
		'browsingScope'
	],
	#category : 'Hera-AcceptanceTests',
	#package : 'Hera-AcceptanceTests'
}

{ #category : 'accessing' }
HeraRunnerAcceptanceTest class >> nameInBrowser [

	^ 'Hera Runner'
]

{ #category : 'features' }
HeraRunnerAcceptanceTest >> featureRunningFeatures [

	<heraFeature: 'Running features'>

	^ (self feature: 'Running features')
		scenarios: {
			(self scenario: 'Application of initial run button enablement')
				when: 'I open the Runner from the Feature Browser to step through a feature';
				then: 'I see an enabled "Continue" button';
				and: 'I see a disabled "Step until end of scenario" button';
				and: 'I see an enabled "Step" button';
				and: 'I see an enabled "Restart" button' .
			(self scenario: 'Running a passing feature from the Feature Browser')
				when: 'I open the Runner from the Feature Browser to run a passing feature';
				then: 'I see the full output of the passed test run';
				then: 'I see a disabled "Continue" button';
				and: 'I see a disabled "Step until end of scenario" button';
				and: 'I see a disabled "Step" button';
				and: 'I see an enabled "Restart" button' .
			(self scenario: 'Running a feature with an error from the Feature Browser')
				when: 'I open the Runner from the Feature Browser to run a feature with an error';
				then: 'I see the full output of the errored test run';
				then: 'I see a disabled "Continue" button';
				and: 'I see a disabled "Step until end of scenario" button';
				and: 'I see a disabled "Step" button';
				and: 'I see an enabled "Restart" button' .
			(self scenario: 'Debugging a feature from the Feature Browser')
				when: 'I open the Runner from the Feature Browser to debug a feature';
				then: 'I see the output of the test run upto the failing step';
				and: 'a debugger is open on the definition of the failing step';
				then: 'I see an enabled "Continue" button';
				and: 'I see a disabled "Step until end of scenario" button';
				and: 'I see an enabled "Step" button';
				and: 'I see an enabled "Restart" button' .
			(self scenario: 'Stepping a feature from the Feature Browser')
				when: 'I open the Runner from the Feature Browser to step through a feature';
				then: 'I see no output';
				when: 'I click the "Step" button';
				then: 'I see the feature line of the script in the output';
				when: 'I click the "Step" button';
				then: 'I see the scenario line of the script in the output';
				when: 'I click the "Step" button';
				then: 'I see the executed steps';
				when: 'I click the "Continue" button';
				then: 'I see the full output of the test run';
				and: 'I see a disabled "Continue" button';
				and: 'I see a disabled "Step until end of scenario" button';
				and: 'I see a disabled "Step" button';
				and: 'I see an enabled "Restart" button' }
]

{ #category : 'features' }
HeraRunnerAcceptanceTest >> featureRunningSingleScenarios [

	<heraFeature: 'Running single scenarios'>

	^ (self feature: 'Running single scenarios')
		scenarios: {
			(self scenario: 'Run one scenario of a feature with two scenarios')
				given: 'a feature with two scenarios';
				when: 'I open the Feature Browser';
				when: 'I select the feature';
				then: 'I see the script of the feature in the browser';
				when: 'I click in a step of the second scenario';
				and: 'I press Command-R';
				then: 'I see a Feature Runner';
				and: 'I see the output of running the second scenario';
				when: 'I close the Feature Runner';
				when: 'I click in a step of the first scenario';
				and: 'I press Command-R';
				then: 'I see a Feature Runner';
				and: 'I see the output of running the first scenario' }
]

{ #category : 'features' }
HeraRunnerAcceptanceTest >> featureScenariosRunInIsolation [

	<heraFeature: 'Scenarios run in isolation'>

	^ (self feature: 'Scenarios run in isolation')
		scenarios: {
			(self scenario: 'Storing a value in an instance variable')
				when: 'the first scenario stores a value in an instance variable';
				then: 'the instance variable holds the value' .
			(self scenario: 'No impact of other scenario')
				when: 'the second scenario runs';
				then: 'the instance variable does not hold the value stored by the first scenario' }
]

{ #category : 'test api' }
HeraRunnerAcceptanceTest >> instanceVariable [

	^ instanceVariable
]

{ #category : 'test api' }
HeraRunnerAcceptanceTest >> instanceVariable: anObject [

	instanceVariable := anObject
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepADebuggerIsOpenOnTheDefinitionOfTheFailingStep [

	<heraStepDefinition: #(Given 'a debugger is open on the definition of the failing step')>
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepAFeatureWithTwoScenarios [

	<heraStepDefinition: #(Given 'a feature with two scenarios')>

	browsingScope := HeraScope default addClass: HeraAcceptanceTestWithPassForTesting
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIClickInAStepOfTheFirstScenario [

	<heraStepDefinition: #(When 'I click in a step of the first scenario')>

	| startOfStep |
	startOfStep := self featureBrowser script string indexOfSubCollection: 'I see the home page'.
	self featureBrowser setCaretAt: startOfStep
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIClickInAStepOfTheSecondScenario [

	<heraStepDefinition: #(When 'I click in a step of the second scenario')>

	| startOfStep |
	startOfStep := self featureBrowser script string indexOfSubCollection: 'I am still on the sign-in page'.
	self featureBrowser setCaretAt: startOfStep
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIClickTheButtonLabeled: aString [

	<heraStepDefinition: #(When match 'I click the {string} button')>

	| mapping |
	mapping := Dictionary
		with: 'Continue' -> #clickContinueButton
		with: 'Step' -> #clickStepButton.
	self featureRunner perform: (mapping at: aString)
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepICloseTheFeatureRunner [

	<heraStepDefinition: #(When 'I close the Feature Runner')>

	self closePresenterAt: #featureRunner
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIOpenTheFeatureBrowser [

	<heraStepDefinition: #(When 'I open the Feature Browser')>

	self openFeatureBrowser: (HeraFeatureBrowser new scope: browsingScope)
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIOpenTheRunnerFromTheFeatureBrowserToDebugAFeature [

	<heraStepDefinition: #(When 'I open the Runner from the Feature Browser to debug a feature')>

	| browser errorSignaled |
	browser := self openFeatureBrowser: (HeraFeatureBrowser new scope: (HeraScope new addClass: HeraAcceptanceTestExamplesForTesting)).
	browser selectFeature: 'With error' in: 'Examples for testing'.
	"This test runs a test that raises an error, but this test captures the error unless we catch it here and resume it."
	errorSignaled := false.
	[ browser clickDebugButton ] on: ZeroDivide do: [ :error | errorSignaled := true ].
	self assert: errorSignaled description: 'Expected the acceptance tests to raise an error'.
	self detectPresenterInTopWindowAs: #featureRunner
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIOpenTheRunnerFromTheFeatureBrowserToRunAFeatureWithAnError [

	<heraStepDefinition: #(When 'I open the Runner from the Feature Browser to run a feature with an error')>

	| browser |
	browser := self openFeatureBrowser: (HeraFeatureBrowser new scope: (HeraScope new addClass: HeraAcceptanceTestExamplesForTesting)).
	browser selectFeature: 'With error' in: 'Examples for testing'.
	browser clickRunButton.
	self detectPresenterInTopWindowAs: #featureRunner
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIOpenTheRunnerFromTheFeatureBrowserToRunAPassingFeature [

	<heraStepDefinition: #(When 'I open the Runner from the Feature Browser to run a passing feature')>

	| browser |
	browser := self openFeatureBrowser: (HeraFeatureBrowser new scope: (HeraScope new addClass: HeraAcceptanceTestExamplesForTesting)).
	browser selectFeature: 'With single step scenario' in: 'Examples for testing'.
	browser clickRunButton.
	self detectPresenterInTopWindowAs: #featureRunner
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIOpenTheRunnerFromTheFeatureBrowserToStepThroughAFeature [

	<heraStepDefinition: #(When 'I open the Runner from the Feature Browser to step through a feature')>

	| browser |
	browser := self openFeatureBrowser: (HeraFeatureBrowser new scope: (HeraScope new addClass: HeraAcceptanceTestExamplesForTesting)).
	browser selectFeature: 'With single step scenario' in: 'Examples for testing'.
	browser clickStepByStepButton.
	self detectPresenterInTopWindowAs: #featureRunner
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIPressCommandR [

	<heraStepDefinition: #(When 'I press Command-R')>

	self featureBrowser simulateEventInScriptEditor: (self keyDownEventFromChar: $r alt: false ctrl: false command: true shift: false)
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIPressTheContinueButton [

	<heraStepDefinition: #(When 'I press the "Continue" button')>
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIPressTheStepButtonMultipleTimes [

	<heraStepDefinition: #(When 'I press the "Step" button multiple times')>
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeADisabledButtonLabeled: aString [

	<heraStepDefinition: #(Then match 'I see a disabled {string} button')>
	
	| mapping |
	mapping := Dictionary
		with: 'Continue' -> #hasDisabledContinueButton
		with: 'Step until end of scenario' -> #hasDisabledStepOverScenarioButton
		with: 'Step' -> #hasDisabledStepOverButton.
		"The Restart button is not included here because it is never disabled."
	self assert: (self featureRunner perform: (mapping at: aString))
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeAFeatureRunner [

	<heraStepDefinition: #(Then 'I see a Feature Runner')>

	| runner |
	runner := self detectPresenterInTopWindowAs: #featureRunner.
	self assert: (runner isMemberOf: HeraRunner)
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeAnEnabledButtonLabeled: aString [

	<heraStepDefinition: #(Then match 'I see an enabled {string} button')>
	
	| mapping |
	mapping := Dictionary
		with: 'Continue' -> #hasEnabledContinueButton
		with: 'Step until end of scenario' -> #hasEnabledStepOverScenarioButton
		with: 'Step' -> #hasEnabledStepOverButton
		with: 'Restart' -> #hasEnabledRestartButton.
	self assert: (self featureRunner perform: (mapping at: aString))
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeNoOutput [

	<heraStepDefinition: #(Then 'I see no output')>

	self assertEmpty: self featureRunner runLog
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheExecutedSteps [

	<heraStepDefinition: #(Then 'I see the executed steps')>

	self assert: self featureRunner runLog equals: 'Feature: With single step scenario

	Scenario: Successful sign-in
		Given I have credentials to sign in'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheFeatureLineOfTheScriptInTheOutput [

	<heraStepDefinition: #(Then 'I see the feature line of the script in the output')>

	self assert: self featureRunner runLog equals: 'Feature: With single step scenario'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheFullOutputOfTheErroredTestRun [

	<heraStepDefinition: #(Then 'I see the full output of the errored test run')>

	self assert: self featureRunner runLog equals: 'Feature: With error

	Scenario: Running this scenario in debug mode opens the debugger
		When an error occurs
			ERROR Zero divide

Total: 1. Passed: 0. Failed: 0. Error: 1.
'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheFullOutputOfThePassedTestRun [

	<heraStepDefinition: #(Then 'I see the full output of the passed test run')>

	self assert: self featureRunner runLog equals: 'Feature: With single step scenario

	Scenario: Successful sign-in
		Given I have credentials to sign in

Total: 1. Passed: 1. Failed: 0. Error: 0.
'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheFullOutputOfTheTestRun [

	<heraStepDefinition: #(Then 'I see the full output of the test run')>

	self assert: self featureRunner runLog equals: 'Feature: With single step scenario

	Scenario: Successful sign-in
		Given I have credentials to sign in

Total: 1. Passed: 1. Failed: 0. Error: 0.
'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheOutputOfRunningTheFirstScenario [

	<heraStepDefinition: #(Given 'I see the output of running the first scenario')>

	self assert: self featureRunner runLog asString equals: 'Feature: Signing in

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

Total: 1. Passed: 1. Failed: 0. Error: 0.
'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheOutputOfRunningTheSecondScenario [

	<heraStepDefinition: #(Then 'I see the output of running the second scenario')>

	self assert: self featureRunner runLog asString equals: 'Feature: Signing in

	Scenario: Unsuccessful sign-in
		Given I have credentials to sign in
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong

Total: 1. Passed: 1. Failed: 0. Error: 0.
'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheOutputOfTheTestRunUptoTheFailingStep [

	<heraStepDefinition: #(Then 'I see the output of the test run upto the failing step')>

	self assert: self featureRunner runLog equals: 'Feature: With error

	Scenario: Running this scenario in debug mode opens the debugger
		When an error occurs'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheScenarioLineOfTheScriptInTheOutput [

	<heraStepDefinition: #(Then 'I see the scenario line of the script in the output')>

	self assert: self featureRunner runLog equals: 'Feature: With single step scenario

	Scenario: Successful sign-in'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheScriptOfTheFeatureInTheBrowser [

	<heraStepDefinition: #(Then 'I see the script of the feature in the browser')>

	self
		expect: self featureBrowser script
		toEqual: '@accessing_the_system
@signing_in
Feature: Signing in

	Signing in is required to have access to the application.

	Signing in requires credentials: an email address and a password.

	@sign_in
	Scenario: Successful sign-in

		Access is allowed when the credentials are recognized.

		Given I have credentials to sign in
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

	Scenario: Unsuccessful sign-in
		Given I have credentials to sign in
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISelectTheFeature [

	<heraStepDefinition: #(When 'I select the feature')>

	self featureBrowser selectPath: #(1 1)
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheFirstScenarioStoresAValueInAnInstanceVariable [

	<heraStepDefinition: #(When 'the first scenario stores a value in an instance variable')>

	instanceVariable := 123
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheInstanceVariableDoesNotHoldTheValueStoredByTheFirstScenario [

	<heraStepDefinition: #(When 'the instance variable does not hold the value stored by the first scenario')>

	self assertNil: instanceVariable
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheInstanceVariableHoldsTheValue [

	<heraStepDefinition: #(When 'the instance variable holds the value')>

	self assert: instanceVariable equals: 123
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheSecondScenarioRuns [

	<heraStepDefinition: #(When 'the second scenario runs')>

	"Nothing to do."
]
