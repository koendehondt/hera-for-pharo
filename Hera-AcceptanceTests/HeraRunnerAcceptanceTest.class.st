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
			(self scenario: 'Running a feature from the Feature Browser')
				when: 'I open the Runner from the Feature Browser to run a feature';
				then: 'I see the full output of the test run';
				and: 'the run buttons are disabled' .
			(self scenario: 'Debugging a feature from the Feature Browser')
				when: 'I open the Runner from the Feature Browser to debug a feature';
				then: 'I see the output of the test run upto the failing step';
				and: 'a debugger is open on the definition of the failing step';
				and: 'the run buttons are disabled' .
			(self scenario: 'Stepping a feature from the Feature Browser')
				given: 'a feature with one scenario';
				when: 'I open the Runner from the Feature Browser to step through a feature';
				then: 'I see no output';
				when: 'I press the "Step" button';
				then: 'I see the feature line of the script in the output';
				when: 'I press the "Step" button';
				then: 'I see the scenario line of the script in the output';
				when: 'I press the "Step" button multiple times';
				then: 'I see the executed steps';
				when: 'I press the "Continue" button';
				then: 'I see the full output of the test run';
				and: 'the run buttons are disabled' }
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
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIOpenTheRunnerFromTheFeatureBrowserToRunAFeature [

	<heraStepDefinition: #(When 'I open the Runner from the Feature Browser to run a feature')>
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
HeraRunnerAcceptanceTest >> stepISeeADisabledStepUntilEndOfScenarioButton [

	<heraStepDefinition: #(Given 'I see a disabled "Step until end of scenario" button')>

	self assert: self featureRunner hasDisabledStepOverScenarioButton
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeAnEnabledContinueButton [

	<heraStepDefinition: #(Then 'I see an enabled "Continue" button')>

	self assert: self featureRunner hasEnabledContinueButton
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeAnEnabledRestartButton [

	<heraStepDefinition: #(Given 'I see an enabled "Restart" button')>

	self assert: self featureRunner hasEnabledRestartButton
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeAnEnabledStepButton [

	<heraStepDefinition: #(Given 'I see an enabled "Step" button')>

	self assert: self featureRunner hasEnabledStepOverButton
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeNoOutput [

	<heraStepDefinition: #(Then 'I see no output')>
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
HeraRunnerAcceptanceTest >> stepISeeTheFullOutputOfTheTestRun [

	<heraStepDefinition: #(Then 'I see the full output of the test run')>
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheOutputOfTheTestRunUptoTheFailingStep [

	<heraStepDefinition: #(Then 'I see the output of the test run upto the failing step')>
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
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheSecondScenarioRuns [

	<heraStepDefinition: #(When 'the second scenario runs')>

	"Nothing to do."
]
