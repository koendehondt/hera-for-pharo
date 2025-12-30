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
	text := Text fromString: 'Running 1 feature.


Feature: With debug step

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I debug'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 49 to: 57.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedDebugStepRunWithSuppressPauseAndDebugSteps [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: With debug step

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I debug [suppressed]
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 49 to: 57.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedEmptyFeatureErrorRunReport [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: Empty
	ERROR There are no scenarios.


Total: 0 scenarios. Passed: 0. Failed: 0. Error: 1. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 38 to: 42;
		addAttribute: (TextColor new color: Color red) from: 38 to: 42.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedEmptyScenarioErrorRunReport [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: With empty scenario

	Scenario: Successful sign-in
		ERROR There are no steps.


Total: 1 scenario. Passed: 0. Failed: 0. Error: 1. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 53 to: 61;
		addAttribute: TextEmphasis bold from: 84 to: 88;
		addAttribute: (TextColor new color: Color red) from: 84 to: 88.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedErrorDebugReportWithTagsAndDescriptions [

	| text |
	text := Text fromString: 'Running 1 feature.


@accessing_the_system
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
		addAttribute: TextEmphasis bold from: 56 to: 63;
		addAttribute: TextEmphasis bold from: 216 to: 224.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedErrorRunReportWithErrorInAfterScenarioHook [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: With single step scenario for testing

	Scenario: Successful sign-in
		Given I have credentials to sign in
		ERROR Some error in the after scenario hook.


Total: 1 scenario. Passed: 0. Failed: 0. Error: 1. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 71 to: 79;
		addAttribute: TextEmphasis bold from: 140 to: 144;
		addAttribute: (TextColor new color: Color red) from: 140 to: 144.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedErrorRunReportWithErrorInBeforeScenarioHook [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: With single step scenario for testing

	Scenario: Successful sign-in
		ERROR Some error in the before scenario hook.


Total: 1 scenario. Passed: 0. Failed: 0. Error: 1. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 71 to: 79;
		addAttribute: TextEmphasis bold from: 102 to: 106;
		addAttribute: (TextColor new color: Color red) from: 102 to: 106.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedErrorRunReportWithTagsAndDescriptions [

	| text |
	text := Text fromString: 'Running 1 feature.


@accessing_the_system
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


Total: 2 scenarios. Passed: 0. Failed: 0. Error: 2. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 56 to: 63;
		addAttribute: TextEmphasis bold from: 216 to: 224;
		addAttribute: TextEmphasis bold from: 411 to: 415;
		addAttribute: (TextColor new color: Color red) from: 411 to: 415;
		addAttribute: TextEmphasis bold from: 436 to: 444;
		addAttribute: TextEmphasis bold from: 581 to: 585;
		addAttribute: (TextColor new color: Color red) from: 581 to: 585.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedFailedDebugReportWithTagsAndDescriptions [

	| text |
	text := Text fromString: 'Running 1 feature.


@accessing_the_system
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
		addAttribute: TextEmphasis bold from: 56 to: 63;
		addAttribute: TextEmphasis bold from: 216 to: 224;
		addAttribute: TextEmphasis bold from: 437 to: 445.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedFailedRunReportWithTagsAndDescriptions [

	| text |
	text := Text fromString: 'Running 1 feature.


@accessing_the_system
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


Total: 2 scenarios. Passed: 1. Failed: 1. Error: 0. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 56 to: 63;
		addAttribute: TextEmphasis bold from: 216 to: 224;
		addAttribute: TextEmphasis bold from: 437 to: 445;
		addAttribute: TextEmphasis bold from: 620 to: 625;
		addAttribute: (TextColor new color: Color orange) from: 620 to: 625.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedHooksRunReport [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: With hooks for testing

	Scenario: Doing and seeing something
		When I do something
		Then I see something


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 56 to: 64.
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
	text := Text fromString: 'Running 1 feature.


@accessing_the_system
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


Total: 2 scenarios. Passed: 2. Failed: 0. Error: 0. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 56 to: 63;
		addAttribute: TextEmphasis bold from: 216 to: 224;
		addAttribute: TextEmphasis bold from: 437 to: 445.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedPausedRunReportWithTagsAndDescriptions [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: With pause step

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I pause
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 49 to: 57.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedPausedRunWithSuppressPauseAndDebugSteps [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: With pause step

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I pause [suppressed]
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 49 to: 57.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithBackground [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: With background

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


Total: 2 scenarios. Passed: 2. Failed: 0. Error: 0. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 49 to: 59;
		addAttribute: TextEmphasis bold from: 122 to: 130;
		addAttribute: TextEmphasis bold from: 344 to: 352.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithDataTable [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: With data table

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


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 49 to: 57.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithDescriptionInBackground [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: With description in background

	Background:

		Signing in is required for all other functionality

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


Total: 2 scenarios. Passed: 2. Failed: 0. Error: 0. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 64 to: 74;
		addAttribute: TextEmphasis bold from: 192 to: 200;
		addAttribute: TextEmphasis bold from: 414 to: 422.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithRules [

	| text |
	text := Text fromString: 'Running 1 feature.


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


Total: 4 scenarios. Passed: 4. Failed: 0. Error: 0. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 117 to: 127;
		addAttribute: TextEmphasis bold from: 196 to: 204;
		addAttribute: TextEmphasis bold from: 395 to: 399;
		addAttribute: TextEmphasis bold from: 529 to: 539;
		addAttribute: TextEmphasis bold from: 575 to: 583;
		addAttribute: TextEmphasis bold from: 743 to: 751;
		addAttribute: TextEmphasis bold from: 926 to: 930;
		addAttribute: TextEmphasis bold from: 988 to: 996.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedUndefinedStepErrorRunReport [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: With undefined step

	Scenario: Undefined steps have a pink background
		Given this step has no definition
			ERROR Step definition not found.


Total: 1 scenario. Passed: 0. Failed: 0. Error: 1. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 53 to: 61;
		addAttribute: TextEmphasis bold from: 141 to: 145;
		addAttribute: (TextColor new color: Color red) from: 141 to: 145.
	^ text
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedUnimplementedStepErrorRunReport [

	| text |
	text := Text fromString: 'Running 1 feature.


Feature: With unimplemented step

	Scenario: Successful sign-in
		Given this step is not implemeted
			ERROR Step not implemented.


Total: 1 scenario. Passed: 0. Failed: 0. Error: 1. Duration: 0 seconds.
'.
	text
		addAttribute: TextEmphasis bold from: 22 to: 29;
		addAttribute: TextEmphasis bold from: 57 to: 65;
		addAttribute: TextEmphasis bold from: 125 to: 129;
		addAttribute: (TextColor new color: Color red) from: 125 to: 129.
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

	subject scope: (HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting selector: #featureWithSingleStepScenarioForTesting) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self deny: subject currentAcceptanceTest afterScenarioWasTriggered
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testDebugRun [

	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithDebugStep) asRunnerScope.
	subject reporter: reporter.
	self should: [ subject run ] raise: Halt.
	self assertText: reporter text equals: self expectedDebugRunReport
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testDebugStepWithSuppressPauseAndDebugSteps [

	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithDebugStep) asRunnerScope.
	subject reporter: reporter.
	subject suppressPauseAndDebugSteps.
	subject run.
	self assertText: reporter text equals: self expectedDebugStepRunWithSuppressPauseAndDebugSteps
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testEmptyFeatureErrorRun [

	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #emptyFeature) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedEmptyFeatureErrorRunReport
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testEmptyScenarioErrorRun [

	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithEmptyScenario) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedEmptyScenarioErrorRunReport
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testErrorDebug [

	subject scope: (HeraAcceptanceTestWithErrorForTesting selector: #signingInFeature) asRunnerScope.
	subject reporter: reporter.
	self should: [ subject debug ] raise: Error description: 'Button not found'.
	self assertText: reporter text equals: self expectedErrorDebugReportWithTagsAndDescriptions
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testErrorInAfterScenarioHook [

	subject scope: (HeraAcceptanceTestWithErrorInAfterScenarioHookForTesting selector: #featureWithSingleStepScenarioForTesting) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedErrorRunReportWithErrorInAfterScenarioHook
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testErrorInBeforeScenarioHook [

	subject scope: (HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting selector: #featureWithSingleStepScenarioForTesting) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedErrorRunReportWithErrorInBeforeScenarioHook
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testErrorRun [

	subject scope: (HeraAcceptanceTestWithErrorForTesting selector: #signingInFeature) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedErrorRunReportWithTagsAndDescriptions
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testFailedDebug [

	subject scope: (HeraAcceptanceTestWithFailureForTesting selector: #signingInFeature) asRunnerScope.
	subject reporter: reporter.
	self should: [ subject debug ] raise: HeraFailure description: 'The current page is not the sign-in page.'.
	self assertText: reporter text equals: self expectedFailedDebugReportWithTagsAndDescriptions
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testFailedRun [

	subject scope: (HeraAcceptanceTestWithFailureForTesting selector: #signingInFeature) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedFailedRunReportWithTagsAndDescriptions
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testHooks [

	| test lastTest |
	test := HeraAcceptanceTestWithHooksForTesting selector: #featureWithHooks.
	subject scope: test asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedHooksRunReport.
	lastTest := subject currentAcceptanceTest.
	self assert: lastTest isBeforeHookInvoked.
	self assert: lastTest isAfterHookInvoked
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testPassedRun [

	subject scope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedPassedRunReportWithTagsAndDescriptions
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testPauseStepWithSuppressPauseAndDebugSteps [

	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithPauseStep) asRunnerScope.
	subject reporter: reporter.
	subject suppressPauseAndDebugSteps.
	subject run.
	self assertText: reporter text equals: self expectedPausedRunWithSuppressPauseAndDebugSteps
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testPausedRun [

	| allOutput |
	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithPauseStep) asRunnerScope.
	subject reporter: reporter.
	allOutput := self expectedPausedRunReportWithTagsAndDescriptions.
	subject run.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 129). "When I pause"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 159). "When I enter my credentials"
	subject continue.
	self assertText: reporter text equals: allOutput "Result summary"
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testRunScenariosInIsolation [

	| result |
	subject scope: (HeraRunnerAcceptanceTest selector: #featureScenariosRunInIsolation) asRunnerScope.
	subject reporter: reporter.
	subject run.
	result := subject result.
	self assert: result totalCount equals: 2.
	self assert: result passedCount equals: 2
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testRunWithBackground [

	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithBackground) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedRunReportWithBackground
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testRunWithDataTable [

	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithDataTable) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedRunReportWithDataTable
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testRunWithDescriptionInBackground [

	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithDescriptionInBackground) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedRunReportWithDescriptionInBackground
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testRunWithRules [

	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithRules) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedRunReportWithRules
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testStepping [

	| allOutput |
	subject scope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	subject reporter: reporter.
	allOutput := self expectedPassedRunReportWithTagsAndDescriptions.
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 202). "Feature"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 302). "First scenario"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 340). "Step 1"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 370). "Step 2"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 406). "Step 3"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 433). "Step 4"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 466). "Second scenario"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 504). "Step 1"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 541). "Step 2"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 577). "Step 3"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 615). "Step 4"
	subject runNext.
	self assertText: reporter text equals: (allOutput copyFrom: 1 to: 668). "Step 5"
	subject runNext.
	self assertText: reporter text equals: allOutput "Result summary"
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testTerminateTriggersAfterScenarioHookOfAccepetanceTest [

	subject scope: (HeraAcceptanceTestWithHooksForTesting selector: #featureWithHooks) asRunnerScope.
	subject reporter: reporter.
	subject runNext. "Start feature"
	subject runNext. "Start scenario"
	self deny: subject currentAcceptanceTest isAfterHookInvoked.
	subject terminate.
	self assert: subject currentAcceptanceTest isAfterHookInvoked
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testUndefineddStepErrorRun [

	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithScenarioWithUndefinedStep) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedUndefinedStepErrorRunReport
]

{ #category : 'tests' }
HeraScriptRunnerWithTextReporterTestCase >> testUnimplementdStepErrorRun [

	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithScenarioWithUnimplementedStep) asRunnerScope.
	subject reporter: reporter.
	subject run.
	self assertText: reporter text equals: self expectedUnimplementedStepErrorRunReport
]
