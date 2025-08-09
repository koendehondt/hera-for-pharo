Class {
	#name : 'HeraScriptRunnerWithTextReporterTestCase',
	#superclass : 'HeraUnitTestCase',
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
	text := Text fromString: 'Feature: With debug step

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I debug'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 28 to: 36.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedDebugStepRunWithSuppressPauseAndDebugSteps [

	| text |
	text := Text fromString: 'Feature: With debug step

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I debug [suppressed]
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

Total: 1. Passed: 1. Failed: 0. Error: 0.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 28 to: 36.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedEmptyFeatureErrorRunReport [

	| text |
	text := Text fromString: 'Feature: Empty
	ERROR There are no scenarios.

Total: 0. Passed: 0. Failed: 0. Error: 1.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 17 to: 21;
		addAttribute: (TextColor new color: Color red) from: 17 to: 21.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedEmptyScenarioErrorRunReport [

	| text |
	text := Text fromString: 'Feature: With empty scenario

	Scenario: Successful sign-in
		ERROR There are no steps.

Total: 1. Passed: 0. Failed: 0. Error: 1.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 32 to: 40;
		addAttribute: TextEmphasis bold from: 63 to: 67;
		addAttribute: (TextColor new color: Color red) from: 63 to: 67.
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
HeraScriptRunnerWithTextReporterTestCase >> expectedErrorRunReportWithErrorInAfterScenarioHook [

	| text |
	text := Text fromString: 'Feature: With single step scenario for testing

	Scenario: Successful sign-in
		Given I have credentials to sign in
		ERROR Some error in the after scenario hook.

Total: 1. Passed: 0. Failed: 0. Error: 1.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 50 to: 58;
		addAttribute: TextEmphasis bold from: 119 to: 123;
		addAttribute: (TextColor new color: Color red) from: 119 to: 123.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedErrorRunReportWithErrorInBeforeScenarioHook [

	| text |
	text := Text fromString: 'Feature: With single step scenario for testing

	Scenario: Successful sign-in
		ERROR Some error in the before scenario hook.

Total: 1. Passed: 0. Failed: 0. Error: 1.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 50 to: 58;
		addAttribute: TextEmphasis bold from: 81 to: 85;
		addAttribute: (TextColor new color: Color red) from: 81 to: 85.
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
HeraScriptRunnerWithTextReporterTestCase >> expectedPassedRunReportWithSuppressResultSummary [

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
'.
	text
		addAttribute: TextEmphasis bold from: 35 to: 42;
		addAttribute: TextEmphasis bold from: 195 to: 203;
		addAttribute: TextEmphasis bold from: 416 to: 424.
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
HeraScriptRunnerWithTextReporterTestCase >> expectedPausedRunReportWithTagsAndDescriptions [

	| text |
	text := Text fromString: 'Feature: With pause step

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
		addAttribute: TextEmphasis bold from: 28 to: 36.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedPausedRunWithSuppressPauseAndDebugSteps [

	| text |
	text := Text fromString: 'Feature: With pause step

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I pause [suppressed]
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

Total: 1. Passed: 1. Failed: 0. Error: 0.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 28 to: 36.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithBackground [

	| text |
	text := Text fromString: 'Feature: With background

	Background:
		Given I have a user name
		And a password
		But no email

	Scenario: Successful sign-in
		Given I have a user name [Background]
		And a password [Background]
		But no email [Background]
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

	Scenario: Unsuccessful sign-in
		Given I have a user name [Background]
		And a password [Background]
		But no email [Background]
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong

Total: 2. Passed: 2. Failed: 0. Error: 0.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 28 to: 38;
		addAttribute: TextEmphasis bold from: 101 to: 109;
		addAttribute: TextEmphasis bold from: 323 to: 331.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithDataTable [

	| text |
	text := Text fromString: 'Feature: With data table

	Scenario: Listing users
		Given the following users exist:
			| Name | Email            |
			| John | john@testing.org |
			| Jane | jane@testing.org |
		When I add the following users:
			| Name | Email            |
			| Jake | jake@testing.org |
			| Emma | emma@testing.org |
		And I add the following users:
			| Name | Email            |
			| Jill | jill@testing.org |
		But I remove the following users:
			| Name | Email            |
			| Jake | jake@testing.org |
		Then I see these users in the list:
			| Name | Email            |
			| John | john@testing.org |
			| Jane | jane@testing.org |
			| Emma | emma@testing.org |
			| Jill | jill@testing.org |

Total: 1. Passed: 1. Failed: 0. Error: 0.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 28 to: 36.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithDescriptionInBackground [

	| text |
	text := Text fromString: 'Feature: With description in background

	Background:
		Given I have a user name
		And a password
		But no email

	Scenario: Successful sign-in
		Given I have a user name [Background]
		And a password [Background]
		But no email [Background]
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

	Scenario: Unsuccessful sign-in
		Given I have a user name [Background]
		And a password [Background]
		But no email [Background]
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong

Total: 2. Passed: 2. Failed: 0. Error: 0.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 43 to: 53;
		addAttribute: TextEmphasis bold from: 116 to: 124;
		addAttribute: TextEmphasis bold from: 338 to: 346.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithRules [

	| text |
	text := Text fromString: '
Feature: With rules

	Managing users is essential to permit and revoke access to the system.

	Background:
		Given an administrator user and a non-administrator user exist

	Scenario: Scenarios before the first rule are not related to a rule
		Given an administrator user and a non-administrator user exist [Background]
		Given I am an administrator
		Then I can sign in

	Rule: Only administrators are allowed to manage users

		Users are managed by administrators, who can assign permissions to users.

		Background:
			Given I am an administrator

		Scenario: Adding a user
			Given I am an administrator [Background]
			When I open the user management page
			And I add a new user
			Then the new user can sign in

		Scenario: Removing a user
			Given I am an administrator [Background]
			When I open the user management page
			And I remove a user
			Then the removed user cannot sign in anymore

	Rule: Non-administrators have no access to user management

		Scenario: No access to user management
			Given I am not an administrator
			Then I cannot open the user management page

Total: 4. Passed: 4. Failed: 0. Error: 0.
' allButFirst.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 96 to: 106;
		addAttribute: TextEmphasis bold from: 175 to: 183;
		addAttribute: TextEmphasis bold from: 374 to: 378;
		addAttribute: TextEmphasis bold from: 508 to: 518;
		addAttribute: TextEmphasis bold from: 554 to: 562;
		addAttribute: TextEmphasis bold from: 722 to: 730;
		addAttribute: TextEmphasis bold from: 905 to: 909;
		addAttribute: TextEmphasis bold from: 967 to: 975.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedUndefinedStepErrorRunReport [

	| text |
	text := Text fromString: 'Feature: With undefined step

	Scenario: Successful sign-in
		Given this step has no definition
			ERROR Step definition not found.

Total: 1. Passed: 0. Failed: 0. Error: 1.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 32 to: 40;
		addAttribute: TextEmphasis bold from: 100 to: 104;
		addAttribute: (TextColor new color: Color red) from: 100 to: 104.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedUnimplementedStepErrorRunReport [

	| text |
	text := Text fromString: 'Feature: With unimplemented step

	Scenario: Successful sign-in
		Given this step is not implemeted
			ERROR Step not implemented.

Total: 1. Passed: 0. Failed: 0. Error: 1.
'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 36 to: 44;
		addAttribute: TextEmphasis bold from: 104 to: 108;
		addAttribute: (TextColor new color: Color red) from: 104 to: 108.
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
HeraScriptRunnerWithTextReporterTestCase >> testAfterScenarioHookIsNotTriggeredAfterErrorInBeforeScenarioHook [

	subject acceptanceTest: (HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting selector: #featureWithSingleStepScenarioForTesting).
	subject reporter: reporter.
	subject run.
	self deny: subject currentAcceptanceTest afterScenarioWasTriggered
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testDebugRun [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithDebugStep).
	subject reporter: reporter.
	self should: [ subject run ] raise: Halt.
	self assertText: reporter text equals: self expectedDebugRunReport
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testDebugStepWithSuppressPauseAndDebugSteps [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithDebugStep).
	subject reporter: reporter.
	subject suppressPauseAndDebugSteps.
	subject run.
	self assertText: reporter text equals: self expectedDebugStepRunWithSuppressPauseAndDebugSteps
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
HeraScriptRunnerWithTextReporterTestCase >> testErrorInAfterScenarioHook [

	subject acceptanceTest: (HeraAcceptanceTestWithErrorInAfterScenarioHookForTesting selector: #featureWithSingleStepScenarioForTesting).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedErrorRunReportWithErrorInAfterScenarioHook
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testErrorInBeforeScenarioHook [

	subject acceptanceTest: (HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting selector: #featureWithSingleStepScenarioForTesting).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedErrorRunReportWithErrorInBeforeScenarioHook
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
HeraScriptRunnerWithTextReporterTestCase >> testPauseStepWithSuppressPauseAndDebugSteps [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithPauseStep).
	subject reporter: reporter.
	subject suppressPauseAndDebugSteps.
	subject run.
	self assertText: reporter text equals: self expectedPausedRunWithSuppressPauseAndDebugSteps
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testPausedRun [

	| allOutput |
	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithPauseStep).
	subject reporter: reporter.
	allOutput := self expectedPausedRunReportWithTagsAndDescriptions.
	subject run.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 108). "When I pause"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 138). "When I enter my credentials"
	subject continue.
	self assertText: reporter text equals: allOutput "Result summary"
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testRunScenariosInIsolation [

	| result |
	subject acceptanceTest: (HeraRunnerAcceptanceTest selector: #featureScenariosRunInIsolation).
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
HeraScriptRunnerWithTextReporterTestCase >> testRunWithDescriptionInBackground [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithDescriptionInBackground).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedRunReportWithDescriptionInBackground
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testRunWithRules [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithRules).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedRunReportWithRules
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
HeraScriptRunnerWithTextReporterTestCase >> testSuppressResultSummary [

	subject acceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature).
	subject reporter: reporter.
	subject suppressResultSummary.
	subject run.
	self assertText: reporter text equals: self expectedPassedRunReportWithSuppressResultSummary
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testTerminateTriggersAfterScenarioHookOfAccepetanceTest [

	subject acceptanceTest: (HeraAcceptanceTestWithHooksForTesting selector: #featureWithHooks).
	subject reporter: reporter.
	subject runNext. "Start feature"
	subject runNext. "Start scenario"
	self deny: subject currentAcceptanceTest isAfterHookInvoked.
	subject terminate.
	self assert: subject currentAcceptanceTest isAfterHookInvoked
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testUndefineddStepErrorRun [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithScenarioWithUndefinedStep).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedUndefinedStepErrorRunReport
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testUnimplementdStepErrorRun [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithScenarioWithUnimplementedStep).
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedUnimplementedStepErrorRunReport
]
