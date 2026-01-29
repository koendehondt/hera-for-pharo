Class {
	#name : 'HeraRunnerTestCase',
	#superclass : 'HeraUnitTestCase',
	#instVars : [
		'initialOpenRunnerWindows'
	],
	#category : 'Hera-UI-Tests-Runner',
	#package : 'Hera-UI-Tests',
	#tag : 'Runner'
}

{ #category : 'asserting' }
HeraRunnerTestCase >> assertResultSummary: expectedCounts [

	self assert: subject resultSummaryCounts equals: expectedCounts
]

{ #category : 'asserting' }
HeraRunnerTestCase >> assertWindowTitle: expectedWindowTitle [

	self assert: subject currentWindowTitle equals: expectedWindowTitle
]

{ #category : 'running' }
HeraRunnerTestCase >> describedClass [

	^ HeraRunner
]

{ #category : 'running' }
HeraRunnerTestCase >> initializeSubject [

	subject := self describedClass newApplication: HeraApplication new.
	subject open
	
]

{ #category : 'helpers' }
HeraRunnerTestCase >> openRunnerWindows [

	^ (self currentWorld windowsSatisfying: [ :window | window model presenter isKindOf: HeraRunner ]) asSet
]

{ #category : 'helpers' }
HeraRunnerTestCase >> openedRunnerWindows [

	^ self openRunnerWindows asSet difference: initialOpenRunnerWindows
]

{ #category : 'running' }
HeraRunnerTestCase >> setUp [

	super setUp.
	initialOpenRunnerWindows := self openRunnerWindows
]

{ #category : 'running' }
HeraRunnerTestCase >> tearDown [

	self openedRunnerWindows do: [ :each | each window close ].
	subject withWindowDo: [:window | window close ].
	super tearDown
]

{ #category : 'tests - progress in window label' }
HeraRunnerTestCase >> testDebug [

	self should: [ subject debugScope: (HeraAcceptanceTestWithErrorForTesting selector: #signingInFeature) asRunnerScope ] raise: Error.
	self assert: subject currentWindowTitle equals: 'Running 1/2 – Successful sign-in'
]

{ #category : 'tests - progress in window label' }
HeraRunnerTestCase >> testDebugFiltered [

	self should: [
		subject
			debugScope: (HeraAcceptanceTestWithErrorForTesting selector: #signingInFeature) asRunnerScope
			filteredBy: (HeraScenarioFilter new title: 'Unsuccessful sign-in')
	] raise: Error.
	self assert: subject currentWindowTitle equals: 'Running 1/1 – Unsuccessful sign-in'
]

{ #category : 'tests' }
HeraRunnerTestCase >> testDebugScenario [

	| scenario acceptanceTest |
	acceptanceTest := HeraAcceptanceTestWithErrorForTesting selector: #signingInFeature.
	subject runScope: acceptanceTest asRunnerScope.
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

{ #category : 'tests - progress in window label' }
HeraRunnerTestCase >> testDefaultWindowTitleAfterOpening [

	self assert: subject currentWindowTitle equals: 'Hera Runner'
]

{ #category : 'tests - rerunning' }
HeraRunnerTestCase >> testRerunAll [

	subject runScope: (HeraRunnerScope with: (HeraAcceptanceTestExamplesForTesting selector: #featureWithError)).
	self assert: subject currentWindowTitle equals: 'Finished 1/1'.
	subject selectResultItemAt: 1.
	self assert: self openedRunnerWindows size equals: 0.
	subject rerun.
	self assert: self openedRunnerWindows size equals: 1.
	self openedRunnerWindows do: [ :each |
		self assert: each label equals: 'Finished 1/1' ]
]

{ #category : 'tests - rerunning' }
HeraRunnerTestCase >> testRerunAndDebugFeature [

	| uncaughtError |
	subject runScope: (HeraRunnerScope with: (HeraAcceptanceTestExamplesForTesting selector: #featureWithError)).
	self assert: subject currentWindowTitle equals: 'Finished 1/1'.
	subject selectResultItemAt: 2.
	self assert: self openedRunnerWindows size equals: 0.
	uncaughtError := false.
	"Without the #on:do: below, a debugger would open."
	[ subject rerunAndDebug ]
		on: ZeroDivide
		do: [ uncaughtError := true ].
	self assert: self openedRunnerWindows size equals: 1.
	"Due to the open debugger, the runner's window shows 'Running', not 'Finished'."
	self assert: self topMostRunner currentWindowTitle equals: 'Running 1/1 – Running this scenario in debug mode opens the debugger'
]

{ #category : 'tests - rerunning' }
HeraRunnerTestCase >> testRerunAndStepAll [

	| runner |
	subject runScope: (HeraRunnerScope with: (HeraAcceptanceTestExamplesForTesting selector: #featureWithError)).
	self assert: subject currentWindowTitle equals: 'Finished 1/1'.
	subject selectResultItemAt: 1.
	self assert: self openedRunnerWindows size equals: 0.
	subject rerunAndStep.
	self assert: self openedRunnerWindows size equals: 1.
	runner := self topMostRunner.
	self assert: runner currentWindowTitle equals: 'Running 0/1 – Stepping'.
	runner stepOver.
	self assert: runner currentWindowTitle equals: 'Running 0/1 – Stepping'.
	runner stepOver.
	self assert: runner currentWindowTitle equals: 'Running 1/1 – Stepping – Running this scenario in debug mode opens the debugger'.
	runner stepOver.
	self assert: runner currentWindowTitle equals: 'Running 1/1 – Stepping – Running this scenario in debug mode opens the debugger'.
	runner stepOver.
	self assert: runner currentWindowTitle equals: 'Finished 1/1'
]

{ #category : 'tests - rerunning' }
HeraRunnerTestCase >> testRerunAndStepFeature [

	| runner |
	subject runScope: (HeraRunnerScope with: (HeraAcceptanceTestExamplesForTesting selector: #featureWithError)).
	self assert: subject currentWindowTitle equals: 'Finished 1/1'.
	subject selectResultItemAt: 2.
	self assert: self openedRunnerWindows size equals: 0.
	subject rerunAndStep.
	self assert: self openedRunnerWindows size equals: 1.
	runner := self topMostRunner.
	self assert: runner currentWindowTitle equals: 'Running 0/1 – Stepping'.
	runner stepOver.
	self assert: runner currentWindowTitle equals: 'Running 0/1 – Stepping'.
	runner stepOver.
	self assert: runner currentWindowTitle equals: 'Running 1/1 – Stepping – Running this scenario in debug mode opens the debugger'.
	runner stepOver.
	self assert: runner currentWindowTitle equals: 'Running 1/1 – Stepping – Running this scenario in debug mode opens the debugger'.
	runner stepOver.
	self assert: runner currentWindowTitle equals: 'Finished 1/1'
]

{ #category : 'tests - rerunning' }
HeraRunnerTestCase >> testRerunAndStepScenario [

	| runner |
	subject runScope: (HeraRunnerScope with: (HeraAcceptanceTestExamplesForTesting selector: #featureWithError)).
	self assert: subject currentWindowTitle equals: 'Finished 1/1'.
	subject selectResultItemAt: 3.
	self assert: self openedRunnerWindows size equals: 0.
	subject rerunAndStep.
	self assert: self openedRunnerWindows size equals: 1.
	runner := self topMostRunner.
	runner stepOver.
	self assert: runner currentWindowTitle equals: 'Running 0/1 – Stepping'.
	runner stepOver.
	self assert: runner currentWindowTitle equals: 'Running 1/1 – Stepping – Running this scenario in debug mode opens the debugger'.
	runner stepOver.
	self assert: runner currentWindowTitle equals: 'Running 1/1 – Stepping – Running this scenario in debug mode opens the debugger'.
	runner stepOver.
	self assert: runner currentWindowTitle equals: 'Finished 1/1'
]

{ #category : 'tests - rerunning' }
HeraRunnerTestCase >> testRerunFeature [

	subject runScope: (HeraRunnerScope with: (HeraAcceptanceTestExamplesForTesting selector: #featureWithError)).
	self assert: subject currentWindowTitle equals: 'Finished 1/1'.
	subject selectResultItemAt: 2.
	self assert: self openedRunnerWindows size equals: 0.
	subject rerun.
	self assert: self openedRunnerWindows size equals: 1.
	self openedRunnerWindows do: [ :each |
		self assert: each label equals: 'Finished 1/1' ]
]

{ #category : 'tests - rerunning' }
HeraRunnerTestCase >> testRerunScenario [

	subject runScope: (HeraRunnerScope with: (HeraAcceptanceTestExamplesForTesting selector: #featureWithError)).
	self assert: subject currentWindowTitle equals: 'Finished 1/1'.
	subject selectResultItemAt: 3.
	self assert: self openedRunnerWindows size equals: 0.
	subject rerun.
	self assert: self openedRunnerWindows size equals: 1.
	self openedRunnerWindows do: [ :each |
		self assert: each label equals: 'Finished 1/1' ]
]

{ #category : 'tests' }
HeraRunnerTestCase >> testRestart [

	| expectedRunLogRegex |
	expectedRunLogRegex := 'Running 1 feature.


@accessing_the_system
@signing_in
Feature\: Signing in

	Signing in is required to have access to the application\.

	Signing in requires credentials\: an email address and a password\.

	@sign_in
	Scenario\: Successful sign-in

		Access is allowed when the credentials are recognized\.

		Given I have credentials to sign in
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

	Scenario\: Unsuccessful sign-in
		Given I have credentials to sign in
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong


Total\: 2 scenarios. Passed\: 2. Failed\: 0. Error\: 0. Duration\: (1 second|\d+ seconds)\.
'.
	subject runScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	self assert: subject runLogString matches: expectedRunLogRegex.
	subject restart.
	self deny: subject hasRunSteps.
	self deny: subject isRunningScenario.
	subject continue.
	self assert: subject runLogString matches: expectedRunLogRegex
]

{ #category : 'tests - rerunning' }
HeraRunnerTestCase >> testRestartFiltered [

	subject
		runScope: (HeraRunnerScope with: (HeraAcceptanceTestExamplesForTesting selector: #featureWithTwoScenarios))
		filteredBy: (HeraScenarioFilter new title: 'Unsuccessful sign-in').
	self assert: subject currentWindowTitle equals: 'Finished 1/1'.
	self assert: self openedRunnerWindows size equals: 0.
	subject restart.
	self assert: self openedRunnerWindows size equals: 0.
	self assert: subject currentWindowTitle equals: 'Running 0/1 – Stepping'.
	subject continue.
	self assert: self openedRunnerWindows size equals: 0.
	self assert: subject currentWindowTitle equals: 'Finished 1/1'
]

{ #category : 'tests' }
HeraRunnerTestCase >> testRestartFilteredScope [

	| expectedRunLog |
	expectedRunLog := 'Running 1 feature.


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
'.
	subject
		runScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope
		filteredBy: (HeraScenarioFilter new title: 'Unsuccessful sign-in').	
	self assert: subject runLogString equals: expectedRunLog.
	subject restart.
	self deny: subject hasRunSteps.
	self deny: subject isRunningScenario.
	subject continue.
	self assert: subject runLogString equals: expectedRunLog
]

{ #category : 'tests - rerunning' }
HeraRunnerTestCase >> testRestartUnfiltered [

	subject runScope: (HeraRunnerScope with: (HeraAcceptanceTestExamplesForTesting selector: #featureWithTwoScenarios)).
	self assert: subject currentWindowTitle equals: 'Finished 2/2'.
	self assert: self openedRunnerWindows size equals: 0.
	subject restart.
	self assert: self openedRunnerWindows size equals: 0.
	self assert: subject currentWindowTitle equals: 'Running 0/2 – Stepping'.
	subject continue.
	self assert: self openedRunnerWindows size equals: 0.
	self assert: subject currentWindowTitle equals: 'Finished 2/2'
]

{ #category : 'tests - list of results' }
HeraRunnerTestCase >> testResultsWhenSteppingThroughScenario [
	"Step through 2 features with 2 scenarios each. 2 signal an error, 1 fail, and 1 passes.
	Verify everything that is visible in the runner after each step during the run."

	| expectedOutput expectedOutputRegex |
	subject stepScope: (HeraRunnerScope
	withAll: {
		HeraAcceptanceTestWithErrorForTesting selector: #signingInFeature .
		HeraAcceptanceTestWithFailureForTesting selector: #signingInFeature }).

	self assertWindowTitle: 'Running 0/4 – Stepping'.
	self assertResultSummary: {0 . 0 . 0 . 0}.
	self assert: subject resultItemDescriptions equals: {}.
	self assert: subject runLogString equals: ''.

	subject stepOver.
	self assertWindowTitle: 'Running 0/4 – Stepping'.
	self assertResultSummary: {0 . 0 . 0 . 0}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil }.
	expectedOutput := 'Running 2 features.


@accessing_the_system
@signing_in
Feature: Signing in

	Signing in is required to have access to the application.

	Signing in requires credentials: an email address and a password.'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 1/4 – Stepping – Successful sign-in'.
	self assertResultSummary: {0 . 0 . 0 . 0}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#runningResult }.
	expectedOutput := 'Running 2 features.


@accessing_the_system
@signing_in
Feature: Signing in

	Signing in is required to have access to the application.

	Signing in requires credentials: an email address and a password.

	@sign_in
	Scenario: Successful sign-in

		Access is allowed when the credentials are recognized.
'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 1/4 – Stepping – Successful sign-in'.
	self assertResultSummary: {0 . 0 . 0 . 0}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#runningResult }.
	expectedOutput := 'Running 2 features.


@accessing_the_system
@signing_in
Feature: Signing in

	Signing in is required to have access to the application.

	Signing in requires credentials: an email address and a password.

	@sign_in
	Scenario: Successful sign-in

		Access is allowed when the credentials are recognized.

		Given I have credentials to sign in'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 1/4 – Stepping – Successful sign-in'.
	self assertResultSummary: {0 . 0 . 0 . 0}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#runningResult }.
	expectedOutput := 'Running 2 features.


@accessing_the_system
@signing_in
Feature: Signing in

	Signing in is required to have access to the application.

	Signing in requires credentials: an email address and a password.

	@sign_in
	Scenario: Successful sign-in

		Access is allowed when the credentials are recognized.

		Given I have credentials to sign in
		When I enter my credentials'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 1/4 – Stepping – Successful sign-in'.
	self assertResultSummary: {1 . 0 . 0 . 1}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult }.
	expectedOutput := 'Running 2 features.


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
			ERROR Button not found'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 1/4 – Stepping – Successful sign-in'.
	self assertResultSummary: {1 . 0 . 0 . 1}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult }.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 2/4 – Stepping – Unsuccessful sign-in'.
	self assertResultSummary: {1 . 0 . 0 . 1}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#runningResult }.
	expectedOutput := 'Running 2 features.


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

	Scenario: Unsuccessful sign-in'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 2/4 – Stepping – Unsuccessful sign-in'.
	self assertResultSummary: {1 . 0 . 0 . 1}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#runningResult }.
	expectedOutput := 'Running 2 features.


Feature: Signing in

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I enter my credentials
		And I press the button to sign in
			ERROR Button not found

	Scenario: Unsuccessful sign-in
		Given I have credentials to sign in'.

	subject stepOver.
	self assertWindowTitle: 'Running 2/4 – Stepping – Unsuccessful sign-in'.
	self assertResultSummary: {1 . 0 . 0 . 1}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#runningResult }.
	expectedOutput := 'Running 2 features.


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
		When I enter the wrong credentials'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 2/4 – Stepping – Unsuccessful sign-in'.
	self assertResultSummary: {2 . 0 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult }.
	expectedOutput := 'Running 2 features.


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
			ERROR Button not found'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 2/4 – Stepping – Unsuccessful sign-in'.
	self assertResultSummary: {2 . 0 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult }.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 2/4 – Stepping – Unsuccessful sign-in'.
	self assertResultSummary: {2 . 0 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult }.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 2/4 – Stepping'.
	self assertResultSummary: {2 . 0 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil }.
	expectedOutput := 'Running 2 features.


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


@accessing_the_system
@signing_in
Feature: Signing in

	Signing in is required to have access to the application.

	Signing in requires credentials: an email address and a password.'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 3/4 – Stepping – Successful sign-in'.
	self assertResultSummary: {2 . 0 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' .
		'Successful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil .
		#runningResult }.
	expectedOutput := 'Running 2 features.


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


@accessing_the_system
@signing_in
Feature: Signing in

	Signing in is required to have access to the application.

	Signing in requires credentials: an email address and a password.

	@sign_in
	Scenario: Successful sign-in

		Access is allowed when the credentials are recognized.
'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 3/4 – Stepping – Successful sign-in'.
	self assertResultSummary: {2 . 0 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' .
		'Successful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil .
		#runningResult }.
	expectedOutput := 'Running 2 features.


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


@accessing_the_system
@signing_in
Feature: Signing in

	Signing in is required to have access to the application.

	Signing in requires credentials: an email address and a password.

	@sign_in
	Scenario: Successful sign-in

		Access is allowed when the credentials are recognized.

		Given I have credentials to sign in'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 3/4 – Stepping – Successful sign-in'.
	self assertResultSummary: {2 . 0 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' .
		'Successful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil .
		#runningResult }.
	expectedOutput := 'Running 2 features.


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


@accessing_the_system
@signing_in
Feature: Signing in

	Signing in is required to have access to the application.

	Signing in requires credentials: an email address and a password.

	@sign_in
	Scenario: Successful sign-in

		Access is allowed when the credentials are recognized.

		Given I have credentials to sign in
		When I enter my credentials'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 3/4 – Stepping – Successful sign-in'.
	self assertResultSummary: {2 . 0 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' .
		'Successful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil .
		#runningResult }.
	expectedOutput := 'Running 2 features.


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
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 3/4 – Stepping – Successful sign-in'.
	self assertResultSummary: {2 . 0 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' .
		'Successful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil .
		#runningResult }.
		expectedOutput := 'Running 2 features.


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
		Then I see the home page'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 4/4 – Stepping – Unsuccessful sign-in'.
	self assertResultSummary: {3 . 1 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil .
		#passedResult .
		#runningResult }.
	expectedOutput := 'Running 2 features.


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

	Scenario: Unsuccessful sign-in'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 4/4 – Stepping – Unsuccessful sign-in'.
	self assertResultSummary: {3 . 1 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil .
		#passedResult .
		#runningResult }.
	expectedOutput := 'Running 2 features.


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
		Given I have credentials to sign in'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 4/4 – Stepping – Unsuccessful sign-in'.
	self assertResultSummary: {3 . 1 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil .
		#passedResult .
		#runningResult }.
	expectedOutput := 'Running 2 features.


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
		When I enter the wrong credentials'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 4/4 – Stepping – Unsuccessful sign-in'.
	self assertResultSummary: {3 . 1 . 0 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil .
		#passedResult .
		#runningResult }.
	expectedOutput := 'Running 2 features.


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
		And I press the button to sign in'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 4/4 – Stepping – Unsuccessful sign-in'.
	self assertResultSummary: {4 . 1 . 1 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil .
		#passedResult .
		#failedResult }.
	expectedOutput := 'Running 2 features.


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
			FAILED The current page is not the sign-in page.'.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Running 4/4 – Stepping – Unsuccessful sign-in'.
	self assertResultSummary: {4 . 1 . 1 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil .
		#passedResult .
		#failedResult }.
	self assert: subject runLogString equals: expectedOutput.

	subject stepOver.
	self assertWindowTitle: 'Finished 4/4'.
	self assertResultSummary: {4 . 1 . 1 . 2}.
	self assert: subject resultItemDescriptions equals: {
		'2 features' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' .
		'Signing in' .
		'Successful sign-in' .
		'Unsuccessful sign-in' }.
	self assert: subject resultItemIconNames equals: {
		nil .
		nil .
		#errorResult .
		#errorResult .
		nil .
		#passedResult .
		#failedResult }.
	expectedOutputRegex := 'Running 2 features\.


@accessing_the_system
@signing_in
Feature\: Signing in

	Signing in is required to have access to the application\.

	Signing in requires credentials\: an email address and a password\.

	@sign_in
	Scenario\: Successful sign-in

		Access is allowed when the credentials are recognized\.

		Given I have credentials to sign in
		When I enter my credentials
		And I press the button to sign in
			ERROR Button not found

	Scenario\: Unsuccessful sign-in
		Given I have credentials to sign in
		When I enter the wrong credentials
		And I press the button to sign in
			ERROR Button not found


@accessing_the_system
@signing_in
Feature\: Signing in

	Signing in is required to have access to the application\.

	Signing in requires credentials\: an email address and a password\.

	@sign_in
	Scenario\: Successful sign-in

		Access is allowed when the credentials are recognized\.

		Given I have credentials to sign in
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

	Scenario\: Unsuccessful sign-in
		Given I have credentials to sign in
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
			FAILED The current page is not the sign-in page\.


Total\: 4 scenarios. Passed\: 1. Failed\: 1. Error\: 2. Duration\: (1 second|\d+ seconds)\.
'.
	self assert: subject runLogString matches: expectedOutputRegex
]

{ #category : 'tests - progress in window label' }
HeraRunnerTestCase >> testRunFilteredUntilFinished [

	subject runScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope filteredBy: (HeraScenarioFilter new title: 'Unsuccessful sign-in').
	self assert: subject currentWindowTitle equals: 'Finished 1/1'
]

{ #category : 'tests' }
HeraRunnerTestCase >> testRunScope [

	subject runScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	self assert: subject hasRunAllScenarios
]

{ #category : 'tests' }
HeraRunnerTestCase >> testRunScopePopulatesTheResults [

	| resultItems firstItem fourthItem thirdItem secondItem |
	subject runScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	resultItems := subject resultItems.
	self assert: resultItems size equals: 4.

	fourthItem := resultItems fourth.
	self assert: (fourthItem isMemberOf: HeraScenarioResultItem).
	self assert: fourthItem status isIdenticalTo: HeraResultStatus passedStatus.
	self assert: fourthItem logStartPosition equals: 434.
	self assert: fourthItem logEndPosition equals: 668.
	self assert: (fourthItem duration isMemberOf: Duration).

	thirdItem := resultItems third.
	self assert: (thirdItem isMemberOf: HeraScenarioResultItem).
	self assert: thirdItem status isIdenticalTo: HeraResultStatus passedStatus.
	self assert: thirdItem logStartPosition equals: 203.
	self assert: thirdItem logEndPosition equals: 433.
	self assert: (thirdItem duration isMemberOf: Duration).

	secondItem := resultItems second.
	self assert: (secondItem isMemberOf: HeraFeatureResultItem).
	self assert: (secondItem feature isMemberOf: HeraFeature).
	self assert: secondItem logStartPosition equals: 20.
	self assert: secondItem logEndPosition equals: 669.
	self assert: (secondItem duration isMemberOf: Duration).
	self assert: secondItem subItems equals: (OrderedCollection with: thirdItem with: fourthItem).

	firstItem := resultItems first.
	self assert: (firstItem isMemberOf: HeraRootResultItem).
	self assert: firstItem featureCount equals: 1.
	self assert: firstItem logStartPosition equals: 1.
	self assert: firstItem logEndPosition equals: 744.
	self assert: (firstItem duration isMemberOf: Duration).
	self assert: firstItem subItems equals: (OrderedCollection with: secondItem)
]

{ #category : 'tests - progress in window label' }
HeraRunnerTestCase >> testRunUntilFinished [

	subject runScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	self assert: subject currentWindowTitle equals: 'Finished 2/2'
]

{ #category : 'tests - progress in window label' }
HeraRunnerTestCase >> testRunUntilFinishedAndRestart [

	subject runScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	self assert: subject currentWindowTitle equals: 'Finished 2/2'.
	subject restart.
	self assert: subject currentWindowTitle equals: 'Running 0/2 – Stepping'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 0/2 – Stepping'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/2 – Stepping – Successful sign-in'.
	subject continue.
	self assert: subject currentWindowTitle equals: 'Finished 2/2'
]

{ #category : 'tests - progress in window label' }
HeraRunnerTestCase >> testRunUntilPausedAndContinue [

	subject runScope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithPauseStep) asRunnerScope.
	self assert: subject currentWindowTitle equals: 'Running 1/1 – Paused – Successful sign-in'.
	subject continue.
	self assert: subject currentWindowTitle equals: 'Finished 1/1'
]

{ #category : 'tests - progress in window label' }
HeraRunnerTestCase >> testRunUntilPausedAndThenStepOver [

	subject runScope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithPauseStep) asRunnerScope.
	self assert: subject currentWindowTitle equals: 'Running 1/1 – Paused – Successful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/1 – Stepping – Successful sign-in'.
	subject continue.
	self assert: subject currentWindowTitle equals: 'Finished 1/1'
]

{ #category : 'tests - progress in window label' }
HeraRunnerTestCase >> testRunUntilPausedAndThenStepOverScenario [

	subject runScope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithPauseStep) asRunnerScope.
	self assert: subject currentWindowTitle equals: 'Running 1/1 – Paused – Successful sign-in'.
	subject continue.
	self assert: subject currentWindowTitle equals: 'Finished 1/1'
]

{ #category : 'tests - progress in window label' }
HeraRunnerTestCase >> testStepFilteredUntilFinished [

	subject stepScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope filteredBy: (HeraScenarioFilter new title: 'Unsuccessful sign-in').
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 0/1 – Stepping'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/1 – Stepping – Unsuccessful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/1 – Stepping – Unsuccessful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/1 – Stepping – Unsuccessful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/1 – Stepping – Unsuccessful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/1 – Stepping – Unsuccessful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/1 – Stepping – Unsuccessful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Finished 1/1'
]

{ #category : 'tests' }
HeraRunnerTestCase >> testStepScope [

	subject stepScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	self deny: subject hasRunSteps
]

{ #category : 'tests - progress in window label' }
HeraRunnerTestCase >> testStepUntilFinished [

	subject stepScope: (HeraAcceptanceTestWithPassForTesting selector: #signingInFeature) asRunnerScope.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 0/2 – Stepping'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/2 – Stepping – Successful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/2 – Stepping – Successful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/2 – Stepping – Successful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/2 – Stepping – Successful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 1/2 – Stepping – Successful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 2/2 – Stepping – Unsuccessful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 2/2 – Stepping – Unsuccessful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 2/2 – Stepping – Unsuccessful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 2/2 – Stepping – Unsuccessful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 2/2 – Stepping – Unsuccessful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Running 2/2 – Stepping – Unsuccessful sign-in'.
	subject stepOver.
	self assert: subject currentWindowTitle equals: 'Finished 2/2'
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

{ #category : 'helpers' }
HeraRunnerTestCase >> topMostRunner [

	| runnerWindow |
	runnerWindow := self openRunnerWindows detect: [ :window | window isTopWindow ] ifNone: [ ^ nil ].
	^ runnerWindow model presenter
]
