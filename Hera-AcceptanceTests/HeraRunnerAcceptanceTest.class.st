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
				when: 'I select the "Browse >> Hera Feature Browser on All" menu item from the Pharo menu bar';
				then: 'the "Hera Feature Browser" window opens';
				when: 'I select "Examples for testing >> With single step scenario" in the "Features" tree';
				and: 'I press the "Step selected features" button';
				then: 'the "Running 0/1 – Stepping" window opens';
				and: 'I see an enabled "Continue" button';
				and: 'I see a disabled "Step until end of scenario" button';
				and: 'I see an enabled "Step" button';
				and: 'I see an enabled "Restart" button' .
			(self scenario: 'Running a passing feature from the Feature Browser')
				when: 'I select the "Browse >> Hera Feature Browser on All" menu item from the Pharo menu bar';
				then: 'the "Hera Feature Browser" window opens';
				when: 'I select "Examples for testing >> With single step scenario" in the "Features" tree';
				and: 'I press the "Run selected features" button';
				then: 'the "Finished 1/1" window opens';
				and: 'I see the full run log of the passed test';
				and: 'I see a disabled "Continue" button';
				and: 'I see a disabled "Step until end of scenario" button';
				and: 'I see a disabled "Step" button';
				and: 'I see an enabled "Restart" button' .
			(self scenario: 'Running a feature with an error from the Feature Browser')
				when: 'I select the "Browse >> Hera Feature Browser on All" menu item from the Pharo menu bar';
				then: 'the "Hera Feature Browser" window opens';
				when: 'I select "Examples for testing >> With error" in the "Features" tree';
				and: 'I press the "Run selected features" button';
				then: 'the "Finished 1/1" window opens';
				then: 'I see the full run log of the errored test';
				and: 'I see a disabled "Continue" button';
				and: 'I see a disabled "Step until end of scenario" button';
				and: 'I see a disabled "Step" button';
				and: 'I see an enabled "Restart" button' .
			(self scenario: 'Debugging a feature from the Feature Browser')
				description: {
					'This scenario uses a special step to press the debug button' .
					'because the exception will be unhandled, which normally opens a debugger.' .
					'However, opening the debugger will stop the scenario.' .
					'The special step handles the exception to keep the scenario running.' };
				when: 'I select the "Browse >> Hera Feature Browser on All" menu item from the Pharo menu bar';
				then: 'the "Hera Feature Browser" window opens';
				when: 'I select "Examples for testing >> With error" in the "Features" tree';
				and: 'I press the debug button';
				then: 'an unhandled exception is raised';
				and: 'the "Running 1/1 – Running this scenario in debug mode opens the debugger" window opens';
				and: 'I see the run log upto the failing step';
				and: 'I see an enabled "Continue" button';
				and: 'I see a disabled "Step until end of scenario" button';
				and: 'I see an enabled "Step" button';
				and: 'I see an enabled "Restart" button' .
			(self scenario: 'Stepping a feature from the Feature Browser')
				when: 'I select the "Browse >> Hera Feature Browser on All" menu item from the Pharo menu bar';
				then: 'the "Hera Feature Browser" window opens';
				when: 'I select "Examples for testing >> With single step scenario" in the "Features" tree';
				and: 'I press the "Step selected features" button';
				then: 'the "Running 0/1 – Stepping" window opens';
				and: 'I see an empty run log';
				when: 'I press the "Step" button';
				then: 'I see the feature line of the script in the run log';
				when: 'I press the "Step" button';
				then: 'I see the scenario line of the script in the run log';
				when: 'I press the "Step" button';
				then: 'I see the executed steps';
				when: 'I press the "Continue" button';
				then: 'I see the full run log of the test';
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
				when: 'I open the Feature Browser on:' with: (self dataTable: {
					{ 'HeraAcceptanceTestWithPassForTesting' } });
				when: 'I select "Example with pass and unimplemented step >> Signing in" in the "Features" tree';
				then: 'I see the script of the feature in the browser';
				when: 'I click in a step of the second scenario';
				and: 'I press Command-R';
				then: 'the "Finished 1/1" window opens, identified by "Hera Runner"';
				and: 'I see the run log of the second scenario';
				and: 'I see the following text in the "Run log" field:' with: (self docString: {
					'Running 1 feature.' .
					'' .
					'' .
					'@accessing_the_system' .
					'@signing_in' .
					'Feature: Signing in' .
					'' .
					'	Signing in is required to have access to the application.' .
					'' .
					'	Signing in requires credentials: an email address and a password.' .
					'' .
					'	Scenario: Unsuccessful sign-in' .
					'		Given I have credentials to sign in' .
					'		When I enter the wrong credentials' .
					'		And I press the button to sign in' .
					'		Then I am still on the sign-in page' .
					'		But I see a message that the credentials are wrong' .
					'' .
					'' .
					'Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.' .
					'' });
				when: 'I click the close box of the window identified by "Hera Runner"';
				and: 'I activate the "Signing in" window';
				when: 'I click in a step of the first scenario';
				and: 'I press Command-R';
				then: 'the "Finished 1/1" window opens';
				and: 'I see the following text in the "Run log" field:' with: (self docString: {
					'Running 1 feature.' .
					'' .
					'' .
					'@accessing_the_system' .
					'@signing_in' .
					'Feature: Signing in' .
					'' .
					'	Signing in is required to have access to the application.' .
					'' .
					'	Signing in requires credentials: an email address and a password.' .
					'' .
					'	@sign_in' .
					'	Scenario: Successful sign-in' .
					'' .
					'		Access is allowed when the credentials are recognized.' .
					'' .
					'		Given I have credentials to sign in' .
					'		When I enter my credentials' .
					'		And I press the button to sign in' .
					'		Then I see the home page' .
					'' .
					'' .
					'Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.' .
					'' }) }
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
HeraRunnerAcceptanceTest >> stepAFeatureWithTwoScenarios [

	<heraStepDefinition: #(Given 'a feature with two scenarios')>

	browsingScope := HeraScope new addClass: HeraAcceptanceTestWithPassForTesting
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepAnUnhandledExceptionIsRaised [

	<heraStepDefinition: #(Then 'an unhandled exception is raised')>

	self
		expect: (self stateAt: #errorSignaled)
		description: 'Expected the acceptance test to raise an error'
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
HeraRunnerAcceptanceTest >> stepIPressCommandR [

	<heraStepDefinition: #(When 'I press Command-R')>

	| isMacOS |
	isMacOS := Smalltalk os isMacOS.
	self featureBrowser simulateEventInScriptEditor: (self keyDownEventFromChar: $r alt: false ctrl: isMacOS not command: isMacOS shift: false)
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepIPressTheDebugButton [

	"This test runs a test that raises an error, but this test captures the error unless we catch it here and resume it."

	<heraStepDefinition: #(When 'I press the debug button')>

	self stateAt: #errorSignaled put: false.
	[ self click: 'Debug selected features' ]
		on: ZeroDivide
		do: [ :error | self stateAt: #errorSignaled put: true ]
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeNoOutput [

	<heraStepDefinition: #(Then 'I see an empty run log')>

	self assertEmpty: (self stringContentsOf: 'Run log')
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheExecutedSteps [

	<heraStepDefinition: #(Then 'I see the executed steps')>

	self assertStringContentsOf: 'Run log' equals: 'Running 1 feature.


Feature: With single step scenario

	Scenario: Successful sign-in
		Given I have credentials to sign in'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheFeatureLineOfTheScriptInTheOutput [

	<heraStepDefinition: #(Then 'I see the feature line of the script in the run log')>

	self assertStringContentsOf: 'Run log' equals: 'Running 1 feature.


Feature: With single step scenario'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheFullOutputOfTheErroredTestRun [

	<heraStepDefinition: #(Then 'I see the full run log of the errored test')>

	self assertStringContentsOf: 'Run log' equals: 'Running 1 feature.


Feature: With error

	Scenario: Running this scenario in debug mode opens the debugger
		When an error occurs
			ERROR Zero divide


Total: 1 scenario. Passed: 0. Failed: 0. Error: 1. Duration: 0 seconds.
'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheFullOutputOfThePassedTestRun [

	<heraStepDefinition: #(Then 'I see the full run log of the passed test')>

	self assertStringContentsOf: 'Run log' equals: 'Running 1 feature.


Feature: With single step scenario

	Scenario: Successful sign-in
		Given I have credentials to sign in


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheFullOutputOfTheTestRun [

	<heraStepDefinition: #(Then 'I see the full run log of the test')>

	self assertStringContentsOf: 'Run log' equals: 'Running 1 feature.


Feature: With single step scenario

	Scenario: Successful sign-in
		Given I have credentials to sign in


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheOutputOfRunningTheSecondScenario [

	<heraStepDefinition: #(Then 'I see the run log of the second scenario')>

	self assertStringContentsOf: 'Run log' equals: 'Running 1 feature.


@accessing_the_system
@signing_in
Feature: Signing in

	Signing in is required to have access to the application.

	Signing in requires credentials: an email address and a password.

	Scenario: Unsuccessful sign-in
		Given I have credentials to sign in
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheScenarioLineOfTheScriptInTheOutput [

	<heraStepDefinition: #(Then 'I see the scenario line of the script in the run log')>

	self assertStringContentsOf: 'Run log' equals: 'Running 1 feature.


Feature: With single step scenario

	Scenario: Successful sign-in'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepISeeTheScriptOfTheFeatureInTheBrowser [

	<heraStepDefinition: #(Then 'I see the script of the feature in the browser')>

	self
		assertStringContentsOf: 'Script'
		equals: '@accessing_the_system
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
		But I see a message that the credentials are wrong

'
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheFirstScenarioStoresAValueInAnInstanceVariable [

	<heraStepDefinition: #(When 'the first scenario stores a value in an instance variable')>

	instanceVariable := 123
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheInstanceVariableDoesNotHoldTheValueStoredByTheFirstScenario [

	<heraStepDefinition: #(When 'the instance variable does not hold the value stored by the first scenario')>

	self expectToBeNil: instanceVariable
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheInstanceVariableHoldsTheValue [

	<heraStepDefinition: #(When 'the instance variable holds the value')>

	self expect: instanceVariable toEqual: 123
]

{ #category : 'steps' }
HeraRunnerAcceptanceTest >> stepTheSecondScenarioRuns [

	<heraStepDefinition: #(When 'the second scenario runs')>

	"Nothing to do."
]
