Class {
	#name : 'HeraRunnerAcceptanceTest',
	#superclass : 'HeraSelfAcceptanceTest',
	#instVars : [
		'instanceVariable'
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
				and: 'I see an enabled "Restart" button' }
]

{ #category : 'features' }
HeraRunnerAcceptanceTest >> featureRunningScenariosInIsolation [

	<heraFeature: 'Running scenarios in isolation'>

	^ (self feature: 'Running scenarios in isolation')
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
HeraRunnerAcceptanceTest >> stepAFeatureWithOneScenario [

	<heraStepDefinition: #(Given 'a feature with one scenario')>
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIOpenTheRunnerFromTheFeatureBrowserToDebugAFeature [

	<heraStepDefinition: #(When 'I open the Runner from the Feature Browser to debug a feature')>

	| browser errorSignaled |
	browser := self openFeatureBrowser: (HeraFeatureBrowser new scope: (HeraScope new includeClass: HeraAcceptanceTestExamplesForTesting)).
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
	browser := self openFeatureBrowser: (HeraFeatureBrowser new scope: (HeraScope new includeClass: HeraAcceptanceTestExamplesForTesting)).
	browser selectFeature: 'With error' in: 'Examples for testing'.
	browser clickRunButton.
	self detectPresenterInTopWindowAs: #featureRunner
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIOpenTheRunnerFromTheFeatureBrowserToRunAPassingFeature [

	<heraStepDefinition: #(When 'I open the Runner from the Feature Browser to run a passing feature')>

	| browser |
	browser := self openFeatureBrowser: (HeraFeatureBrowser new scope: (HeraScope new includeClass: HeraAcceptanceTestExamplesForTesting)).
	browser selectFeature: 'With single step scenario' in: 'Examples for testing'.
	browser clickRunButton.
	self detectPresenterInTopWindowAs: #featureRunner
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIOpenTheRunnerFromTheFeatureBrowserToStepThroughAFeature [

	<heraStepDefinition: #(When 'I open the Runner from the Feature Browser to step through a feature')>

	| browser |
	browser := self openFeatureBrowser: (HeraFeatureBrowser new scope: (HeraScope new includeClass: HeraAcceptanceTestExamplesForTesting)).
	browser selectFeature: 'With single step scenario' in: 'Examples for testing'.
	browser clickStepByStepButton.
	self detectPresenterInTopWindowAs: #featureRunner
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIPressTheContinueButton [

	<heraStepDefinition: #(When 'I press the "Continue" button')>
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIPressTheStepButton [

	<heraStepDefinition: #(When 'I press the "Step" button')>
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
HeraRunnerAcceptanceTest >> stepISeeTheExecutedSteps [

	<heraStepDefinition: #(Then 'I see the executed steps')>
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheFeatureLineOfTheScriptInTheOutput [

	<heraStepDefinition: #(Then 'I see the feature line of the script in the output')>
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
HeraRunnerAcceptanceTest >> stepISeeTheOutputOfTheTestRunUptoTheFailingStep [

	<heraStepDefinition: #(Then 'I see the output of the test run upto the failing step')>

	self assert: self featureRunner runLog equals: 'Feature: With error

	Scenario: Running this scenario in debug mode opens the debugger
		When an error occurs'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheScenarioLineOfTheScriptInTheOutput [

	<heraStepDefinition: #(Then 'I see the scenario line of the script in the output')>
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
HeraRunnerAcceptanceTest >> stepTheRunButtonsAreDisabled [

	<heraStepDefinition: #(Given 'the run buttons are disabled')>

	self assert: self featureRunner hasDisabledContinueButton.
	self assert: self featureRunner hasDisabledStepOverButton.
	self assert: self featureRunner hasDisabledStepOverButton.
	self assert: self featureRunner hasDisabledRestartButton
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheSecondScenarioRuns [

	<heraStepDefinition: #(When 'the second scenario runs')>

	"Nothing to do."
]
