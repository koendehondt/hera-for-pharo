Class {
	#name : 'HeraScriptRunnerWithTextReporterTestCase',
	#superclass : 'HeraTestCase',
	#instVars : [
		'reporter'
	],
	#category : 'Hera-Tests-Running',
	#package : 'Hera-Tests',
	#tag : 'Running'
}

{ #category : 'running' }
HeraScriptRunnerWithTextReporterTestCase >> describedClass [

	^ HeraScriptRunner
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedDebugRunReport [

	| text |
	text := Text fromString: 'Feature: With debug step for testing

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I debug'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 40 to: 48.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedEmptyFeatureErrorRunReport [

	| text |
	text := Text fromString: 'Feature: Empty for testing
	ERROR There are no scenarios.

Total: 0. Passed: 0. Failed: 0. Error: 1.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 29 to: 33;
		addAttribute: (TextColor new color: Color red) from: 29 to: 33.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedEmptyScenarioErrorRunReport [

	| text |
	text := Text fromString: 'Feature: With empty scenario for testing

	Scenario: Successful sign-in
		ERROR There are no steps.

Total: 1. Passed: 0. Failed: 0. Error: 1.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 44 to: 52;
		addAttribute: TextEmphasis bold from: 75 to: 79;
		addAttribute: (TextColor new color: Color red) from: 75 to: 79.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedErrorDebugReportWithTagsAndDescriptions [

	| text |
	text := Text fromString: '@accessing_the_system
@signing_in
Feature: Signing in

	Signing in is required to have access to the application.

	Signing in requires credentials: an email address and a password.

	@sign_in
	Scenario: Successful sign-in

		Access is allowed when the credentials are recognized.

		Given I have credentials to sign in
		When I enter my credentials
		And I press the button to sign in'.
	text
		addAttribute: TextEmphasis bold from: 35 to: 42;
		addAttribute: TextEmphasis bold from: 195 to: 203.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedErrorRunReportWithTagsAndDescriptions [

	| text |
	text := Text fromString: '@accessing_the_system
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
			ERROR Button not found

	Scenario: Unsuccessful sign-in
		Given I have credentials to sign in
		When I enter the wrong credentials
		And I press the button to sign in
			ERROR Button not found

Total: 2. Passed: 0. Failed: 0. Error: 2.
'.
	text
		addAttribute: TextEmphasis bold from: 35 to: 42;
		addAttribute: TextEmphasis bold from: 195 to: 203;
		addAttribute: TextEmphasis bold from: 390 to: 394;
		addAttribute: (TextColor new color: Color red) from: 390 to: 394;
		addAttribute: TextEmphasis bold from: 415 to: 423;
		addAttribute: TextEmphasis bold from: 560 to: 564;
		addAttribute: (TextColor new color: Color red) from: 560 to: 564.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedFailedDebugReportWithTagsAndDescriptions [

	| text |
	text := Text fromString: '@accessing_the_system
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
		Then I am still on the sign-in page'.
	text
		addAttribute: TextEmphasis bold from: 35 to: 42;
		addAttribute: TextEmphasis bold from: 195 to: 203;
		addAttribute: TextEmphasis bold from: 416 to: 424.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedFailedRunReportWithTagsAndDescriptions [

	| text |
	text := Text fromString: '@accessing_the_system
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
			FAILED The current page is not the sign-in page.

Total: 2. Passed: 1. Failed: 1. Error: 0.
'.
	text
		addAttribute: TextEmphasis bold from: 35 to: 42;
		addAttribute: TextEmphasis bold from: 195 to: 203;
		addAttribute: TextEmphasis bold from: 416 to: 424;
		addAttribute: TextEmphasis bold from: 599 to: 604;
		addAttribute: (TextColor new color: Color orange) from: 599 to: 604.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedHooksRunReport [

	| text |
	text := Text fromString: 'Feature: With hooks for testing

	Scenario: Doing and seeing something
		When I do something
		Then I see something

Total: 1. Passed: 1. Failed: 0. Error: 0.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 35 to: 43.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedPassedRunReportWithTagsAndDescriptions [

	| text |
	text := Text fromString: '@accessing_the_system
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

Total: 2. Passed: 2. Failed: 0. Error: 0.
'.
	text
		addAttribute: TextEmphasis bold from: 35 to: 42;
		addAttribute: TextEmphasis bold from: 195 to: 203;
		addAttribute: TextEmphasis bold from: 416 to: 424.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedPassedRunReportWithTagsAndDescriptionsForResultBrowser [

	| text |
	text := Text fromString: '@accessing_the_system
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

Total: 2. Passed: 2. Failed: 0. Error: 0.
'.
	text
		addAttribute: TextEmphasis bold from: 35 to: 42;
		addAttribute: TextEmphasis bold from: 195 to: 203;
		addAttribute: TextEmphasis bold from: 416 to: 424.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedPausedRunReportWithTagsAndDescriptions [

	| text |
	text := Text fromString: 'Feature: With pause step for testing

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I pause
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

Total: 1. Passed: 1. Failed: 0. Error: 0.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 40 to: 48.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithBackground [

	| text |
	text := Text fromString: 'Feature: With background for testing

	Background:
		Given I have credentials to sign in

	Scenario: Successful sign-in
		Given I have credentials to sign in [Background]
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

	Scenario: Unsuccessful sign-in
		Given I have credentials to sign in [Background]
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong

Total: 2. Passed: 2. Failed: 0. Error: 0.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 40 to: 50;
		addAttribute: TextEmphasis bold from: 92 to: 100;
		addAttribute: TextEmphasis bold from: 267 to: 275.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithDataTable [

	| text |
	text := Text fromString: 'Feature: With data table for testing

	Scenario: Listing users
		Given the following users exist:
			| Name | Email            |
			| John | john@testing.org |
			| Jane | jane@testing.org |
		Then I see them in the list of users

Total: 1. Passed: 1. Failed: 0. Error: 0.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 40 to: 48.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedUnimplementedStepErrorRunReport [

	| text |
	text := Text fromString: 'Feature: With unimplemented step for testing

	Scenario: Successful sign-in
		Given this step is not implemeted
			ERROR Step definition not found.

Total: 1. Passed: 0. Failed: 0. Error: 1.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 48 to: 56;
		addAttribute: TextEmphasis bold from: 116 to: 120;
		addAttribute: (TextColor new color: Color red) from: 116 to: 120.
	^ text
]

{ #category : 'running' }
HeraScriptRunnerWithTextReporterTestCase >> initializeReporter [

	reporter := HeraTextReporter new
		reportsTags: true;
		reportsDescriptions: true
]

{ #category : 'running' }
HeraScriptRunnerWithTextReporterTestCase >> setUp [

	super setUp.
	self initializeReporter
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testDebugRun [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithDebugStep).
	subject reporter: reporter.
	self should: [ subject run ] raise: Halt.
	self assertText: reporter text equals: self expectedDebugRunReport
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testEmptyFeatureErrorRun [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #emptyFeature).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedEmptyFeatureErrorRunReport
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testEmptyScenarioErrorRun [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithEmptyScenario).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedEmptyScenarioErrorRunReport
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testErrorDebug [

	subject acceptanceTest: (HeraAcceptanceTestWithErrorForTesting selector: #signingInFeature).
	subject reporter: reporter.
	self should: [ subject debug ] raise: Error description: 'Button not found'.
	self assertText: reporter text equals: self expectedErrorDebugReportWithTagsAndDescriptions
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testErrorRun [

	subject acceptanceTest: (HeraAcceptanceTestWithErrorForTesting selector: #signingInFeature).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedErrorRunReportWithTagsAndDescriptions
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testFailedDebug [

	subject acceptanceTest: (HeraAcceptanceTestWithFailureForTesting selector: #signingInFeature).
	subject reporter: reporter.
	self should: [ subject debug ] raise: HeraFailure description: 'The current page is not the sign-in page.'.
	self assertText: reporter text equals: self expectedFailedDebugReportWithTagsAndDescriptions
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testFailedRun [

	subject acceptanceTest: (HeraAcceptanceTestWithFailureForTesting selector: #signingInFeature).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedFailedRunReportWithTagsAndDescriptions
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testHooks [

	| test lastTest |
	test := HeraAcceptanceTestWithHooksForTesting selector: #featureWithHooks.
	subject acceptanceTest: test.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedHooksRunReport.
	lastTest := subject currentAcceptanceTest.
	self assert: lastTest isBeforeHookInvoked.
	self assert: lastTest isAfterHookInvoked
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testPassedRun [

	subject acceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedPassedRunReportWithTagsAndDescriptions
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testPausedRun [

	| allOutput |
	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithPauseStep).
	subject reporter: reporter.
	allOutput := self expectedPausedRunReportWithTagsAndDescriptions.
	subject run.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 120). "When I pause"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 150). "When I enter my credentials"
	subject continue.
	self assertText: reporter text equals: allOutput "Result summary"
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testRunScenariosInIsolation [

	| result |
	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureRunningScenariosInIsolation).
	subject reporter: reporter.
	subject run.
	result := subject result.
	self assert: result totalCount equals: 2.
	self assert: result passedCount equals: 2
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testRunWithBackground [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithBackground).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedRunReportWithBackground
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testRunWithDataTable [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithDataTable).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedRunReportWithDataTable
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testStepping [

	| allOutput |
	subject acceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature).
	subject reporter: reporter.
	allOutput := self expectedPassedRunReportWithTagsAndDescriptions.
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 181). "Feature"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 281). "First scenario"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 319). "Step 1"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 349). "Step 2"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 385). "Step 3"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 412). "Step 4"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 445). "Second scenario"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 483). "Step 1"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 520). "Step 2"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 556). "Step 3"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 594). "Step 4"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 647). "Step 5"
	subject runNext.
	self assertText: reporter text equals: allOutput "Result summary"
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testUnimplementdStepErrorRun [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithScenarioWithUnimplementedStep).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedUnimplementedStepErrorRunReport
]

{ #category : 'private' }
HeraScriptRunnerWithTextReporterTestCase >> textReporter [

	^ HeraTextReporter new
		reportsTags: true;
		reportsDescriptions: true
]
