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

	^ (Text fromString: 'Running 1 feature.


Feature: With debug step

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I debug')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 49 to: 57;
	makeColor: (Color fromHexString: 'CF222E') from: 49 to: 57;
	makeColor: (Color fromHexString: 'CF222E') from: 80 to: 84;
	makeColor: (Color fromHexString: 'CF222E') from: 118 to: 121;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedDebugStepRunWithSuppressPauseAndDebugSteps [

	^ (Text fromString: 'Running 1 feature.


Feature: With debug step

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I debug [suppressed]
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 49 to: 57;
	makeColor: (Color fromHexString: 'CF222E') from: 49 to: 57;
	makeColor: (Color fromHexString: 'CF222E') from: 80 to: 84;
	makeColor: (Color fromHexString: 'CF222E') from: 118 to: 121;
	makeColor: (Color fromHexString: 'CF222E') from: 146 to: 149;
	makeColor: (Color fromHexString: 'CF222E') from: 176 to: 178;
	makeColor: (Color fromHexString: 'CF222E') from: 212 to: 215;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedEmptyFeatureErrorRunReport [

	^ Text fromString: 'Running 0 features.


Total: 0 scenarios. Passed: 0. Failed: 0. Error: 0. Duration: 0 seconds.
'
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedEmptyScenarioErrorRunReport [

	^ (Text fromString: 'Running 1 feature.


Feature: With empty scenario

	Scenario: Successful sign-in
		ERROR There are no steps.


Total: 1 scenario. Passed: 0. Failed: 0. Error: 1. Duration: 0 seconds.
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 53 to: 61;
	makeColor: (Color fromHexString: 'CF222E') from: 53 to: 61;
	makeBoldFrom: 84 to: 88;
	makeColor: (Color fromHexString: 'FE0000') from: 84 to: 88;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedErrorDebugReportWithTagsAndDescriptions [

	^ (Text fromString: 'Running 1 feature.


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
		And I press the button to sign in')
	makeBoldFrom: 56 to: 63;
	makeColor: (Color fromHexString: 'CF222E') from: 56 to: 63;
	makeBoldFrom: 216 to: 224;
	makeColor: (Color fromHexString: 'CF222E') from: 216 to: 224;
	makeColor: (Color fromHexString: 'CF222E') from: 306 to: 310;
	makeColor: (Color fromHexString: 'CF222E') from: 344 to: 347;
	makeColor: (Color fromHexString: 'CF222E') from: 374 to: 376;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedErrorRunReportWithErrorInAfterScenarioHook [

	^ (Text fromString: 'Running 1 feature.


Feature: With single step scenario for testing

	Scenario: Successful sign-in
		Given I have credentials to sign in
		ERROR Some error in the after scenario hook.


Total: 1 scenario. Passed: 0. Failed: 0. Error: 1. Duration: 0 seconds.
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 71 to: 79;
	makeColor: (Color fromHexString: 'CF222E') from: 71 to: 79;
	makeColor: (Color fromHexString: 'CF222E') from: 102 to: 106;
	makeBoldFrom: 140 to: 144;
	makeColor: (Color fromHexString: 'FE0000') from: 140 to: 144;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedErrorRunReportWithErrorInBeforeScenarioHook [

	^ (Text fromString: 'Running 1 feature.


Feature: With single step scenario for testing

	Scenario: Successful sign-in
		ERROR Some error in the before scenario hook.


Total: 1 scenario. Passed: 0. Failed: 0. Error: 1. Duration: 0 seconds.
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 71 to: 79;
	makeColor: (Color fromHexString: 'CF222E') from: 71 to: 79;
	makeBoldFrom: 102 to: 106;
	makeColor: (Color fromHexString: 'FE0000') from: 102 to: 106;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedErrorRunReportWithTagsAndDescriptions [

	^ (Text fromString: 'Running 1 feature.


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
')
	makeBoldFrom: 56 to: 63;
	makeColor: (Color fromHexString: 'CF222E') from: 56 to: 63;
	makeBoldFrom: 216 to: 224;
	makeColor: (Color fromHexString: 'CF222E') from: 216 to: 224;
	makeColor: (Color fromHexString: 'CF222E') from: 306 to: 310;
	makeColor: (Color fromHexString: 'CF222E') from: 344 to: 347;
	makeColor: (Color fromHexString: 'CF222E') from: 374 to: 376;
	makeBoldFrom: 411 to: 415;
	makeColor: (Color fromHexString: 'FE0000') from: 411 to: 415;
	makeBoldFrom: 436 to: 444;
	makeColor: (Color fromHexString: 'CF222E') from: 436 to: 444;
	makeColor: (Color fromHexString: 'CF222E') from: 469 to: 473;
	makeColor: (Color fromHexString: 'CF222E') from: 507 to: 510;
	makeColor: (Color fromHexString: 'CF222E') from: 544 to: 546;
	makeBoldFrom: 581 to: 585;
	makeColor: (Color fromHexString: 'FE0000') from: 581 to: 585;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedFailedDebugReportWithTagsAndDescriptions [

	^ (Text fromString: 'Running 1 feature.


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
		Then I am still on the sign-in page')
	makeBoldFrom: 56 to: 63;
	makeColor: (Color fromHexString: 'CF222E') from: 56 to: 63;
	makeBoldFrom: 216 to: 224;
	makeColor: (Color fromHexString: 'CF222E') from: 216 to: 224;
	makeColor: (Color fromHexString: 'CF222E') from: 306 to: 310;
	makeColor: (Color fromHexString: 'CF222E') from: 344 to: 347;
	makeColor: (Color fromHexString: 'CF222E') from: 374 to: 376;
	makeColor: (Color fromHexString: 'CF222E') from: 410 to: 413;
	makeBoldFrom: 437 to: 445;
	makeColor: (Color fromHexString: 'CF222E') from: 437 to: 445;
	makeColor: (Color fromHexString: 'CF222E') from: 470 to: 474;
	makeColor: (Color fromHexString: 'CF222E') from: 508 to: 511;
	makeColor: (Color fromHexString: 'CF222E') from: 545 to: 547;
	makeColor: (Color fromHexString: 'CF222E') from: 581 to: 584;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedFailedRunReportWithTagsAndDescriptions [

	^ (Text fromString: 'Running 1 feature.


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
')
	makeBoldFrom: 56 to: 63;
	makeColor: (Color fromHexString: 'CF222E') from: 56 to: 63;
	makeBoldFrom: 216 to: 224;
	makeColor: (Color fromHexString: 'CF222E') from: 216 to: 224;
	makeColor: (Color fromHexString: 'CF222E') from: 306 to: 310;
	makeColor: (Color fromHexString: 'CF222E') from: 344 to: 347;
	makeColor: (Color fromHexString: 'CF222E') from: 374 to: 376;
	makeColor: (Color fromHexString: 'CF222E') from: 410 to: 413;
	makeBoldFrom: 437 to: 445;
	makeColor: (Color fromHexString: 'CF222E') from: 437 to: 445;
	makeColor: (Color fromHexString: 'CF222E') from: 470 to: 474;
	makeColor: (Color fromHexString: 'CF222E') from: 508 to: 511;
	makeColor: (Color fromHexString: 'CF222E') from: 545 to: 547;
	makeColor: (Color fromHexString: 'CF222E') from: 581 to: 584;
	makeBoldFrom: 620 to: 625;
	makeColor: (Color fromHexString: 'FE9900') from: 620 to: 625;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedHooksRunReport [

	^ (Text fromString: 'Running 1 feature.


Feature: With hooks for testing

	Scenario: Doing and seeing something
		When I do something
		Then I see something


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 56 to: 64;
	makeColor: (Color fromHexString: 'CF222E') from: 56 to: 64;
	makeColor: (Color fromHexString: 'CF222E') from: 95 to: 98;
	makeColor: (Color fromHexString: 'CF222E') from: 117 to: 120;
	yourself
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

	^ (Text fromString: 'Running 1 feature.


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
')
	makeBoldFrom: 56 to: 63;
	makeColor: (Color fromHexString: 'CF222E') from: 56 to: 63;
	makeBoldFrom: 216 to: 224;
	makeColor: (Color fromHexString: 'CF222E') from: 216 to: 224;
	makeColor: (Color fromHexString: 'CF222E') from: 306 to: 310;
	makeColor: (Color fromHexString: 'CF222E') from: 344 to: 347;
	makeColor: (Color fromHexString: 'CF222E') from: 374 to: 376;
	makeColor: (Color fromHexString: 'CF222E') from: 410 to: 413;
	makeBoldFrom: 437 to: 445;
	makeColor: (Color fromHexString: 'CF222E') from: 437 to: 445;
	makeColor: (Color fromHexString: 'CF222E') from: 470 to: 474;
	makeColor: (Color fromHexString: 'CF222E') from: 508 to: 511;
	makeColor: (Color fromHexString: 'CF222E') from: 545 to: 547;
	makeColor: (Color fromHexString: 'CF222E') from: 581 to: 584;
	makeColor: (Color fromHexString: 'CF222E') from: 619 to: 621;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedPausedRunReportWithTagsAndDescriptions [

	^ (Text fromString: 'Running 1 feature.


Feature: With pause step

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I pause
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 49 to: 57;
	makeColor: (Color fromHexString: 'CF222E') from: 49 to: 57;
	makeColor: (Color fromHexString: 'CF222E') from: 80 to: 84;
	makeColor: (Color fromHexString: 'CF222E') from: 118 to: 121;
	makeColor: (Color fromHexString: 'CF222E') from: 133 to: 136;
	makeColor: (Color fromHexString: 'CF222E') from: 163 to: 165;
	makeColor: (Color fromHexString: 'CF222E') from: 199 to: 202;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedPausedRunWithSuppressPauseAndDebugSteps [

	^ (Text fromString: 'Running 1 feature.


Feature: With pause step

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I pause [suppressed]
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 49 to: 57;
	makeColor: (Color fromHexString: 'CF222E') from: 49 to: 57;
	makeColor: (Color fromHexString: 'CF222E') from: 80 to: 84;
	makeColor: (Color fromHexString: 'CF222E') from: 118 to: 121;
	makeColor: (Color fromHexString: 'CF222E') from: 146 to: 149;
	makeColor: (Color fromHexString: 'CF222E') from: 176 to: 178;
	makeColor: (Color fromHexString: 'CF222E') from: 212 to: 215;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithBackground [

	^ (Text fromString: 'Running 1 feature.


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
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 49 to: 59;
	makeColor: (Color fromHexString: 'CF222E') from: 49 to: 59;
	makeColor: (Color fromHexString: 'CF222E') from: 63 to: 67;
	makeColor: (Color fromHexString: 'CF222E') from: 90 to: 92;
	makeColor: (Color fromHexString: 'CF222E') from: 107 to: 109;
	makeBoldFrom: 122 to: 130;
	makeColor: (Color fromHexString: 'CF222E') from: 122 to: 130;
	makeColor: (Color fromHexString: 'CF222E') from: 153 to: 157;
	makeColor: (Color fromHexString: 'CF222E') from: 193 to: 195;
	makeColor: (Color fromHexString: 'CF222E') from: 223 to: 225;
	makeColor: (Color fromHexString: 'CF222E') from: 251 to: 254;
	makeColor: (Color fromHexString: 'CF222E') from: 281 to: 283;
	makeColor: (Color fromHexString: 'CF222E') from: 317 to: 320;
	makeBoldFrom: 344 to: 352;
	makeColor: (Color fromHexString: 'CF222E') from: 344 to: 352;
	makeColor: (Color fromHexString: 'CF222E') from: 377 to: 381;
	makeColor: (Color fromHexString: 'CF222E') from: 417 to: 419;
	makeColor: (Color fromHexString: 'CF222E') from: 447 to: 449;
	makeColor: (Color fromHexString: 'CF222E') from: 475 to: 478;
	makeColor: (Color fromHexString: 'CF222E') from: 512 to: 514;
	makeColor: (Color fromHexString: 'CF222E') from: 548 to: 551;
	makeColor: (Color fromHexString: 'CF222E') from: 586 to: 588;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithDataTable [

	^ (Text fromString: 'Running 1 feature.


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
		Then I see exactly these users in the list:
			| Name | Email            |
			| John | john@testing.org |
			| Jane | jane@testing.org |
			| Emma | emma@testing.org |
			| Jill | jill@testing.org |
		* I see these users in the list:
			| Name | Email            |
			| Emma | emma@testing.org |
			| Jill | jill@testing.org |


Total: 1 scenario. Passed: 1. Failed: 0. Error: 0. Duration: 0 seconds.
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 49 to: 57;
	makeColor: (Color fromHexString: 'CF222E') from: 49 to: 57;
	makeColor: (Color fromHexString: 'CF222E') from: 75 to: 79;
	makeColor: (Color fromHexString: '8250DF') from: 108 to: 199;
	makeColor: (Color fromHexString: 'CF222E') from: 203 to: 206;
	makeColor: (Color fromHexString: '8250DF') from: 235 to: 326;
	makeColor: (Color fromHexString: 'CF222E') from: 330 to: 332;
	makeColor: (Color fromHexString: '8250DF') from: 361 to: 421;
	makeColor: (Color fromHexString: 'CF222E') from: 425 to: 427;
	makeColor: (Color fromHexString: '8250DF') from: 459 to: 519;
	makeColor: (Color fromHexString: 'CF222E') from: 523 to: 526;
	makeColor: (Color fromHexString: '8250DF') from: 567 to: 720;
	makeColor: (Color fromHexString: 'CF222E') from: 724 to: 724;
	makeColor: (Color fromHexString: '8250DF') from: 757 to: 848;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithDescriptionInBackground [

	^ (Text fromString: 'Running 1 feature.


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
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 64 to: 74;
	makeColor: (Color fromHexString: 'CF222E') from: 64 to: 74;
	makeColor: (Color fromHexString: 'CF222E') from: 133 to: 137;
	makeColor: (Color fromHexString: 'CF222E') from: 160 to: 162;
	makeColor: (Color fromHexString: 'CF222E') from: 177 to: 179;
	makeBoldFrom: 192 to: 200;
	makeColor: (Color fromHexString: 'CF222E') from: 192 to: 200;
	makeColor: (Color fromHexString: 'CF222E') from: 223 to: 227;
	makeColor: (Color fromHexString: 'CF222E') from: 263 to: 265;
	makeColor: (Color fromHexString: 'CF222E') from: 293 to: 295;
	makeColor: (Color fromHexString: 'CF222E') from: 321 to: 324;
	makeColor: (Color fromHexString: 'CF222E') from: 351 to: 353;
	makeColor: (Color fromHexString: 'CF222E') from: 387 to: 390;
	makeBoldFrom: 414 to: 422;
	makeColor: (Color fromHexString: 'CF222E') from: 414 to: 422;
	makeColor: (Color fromHexString: 'CF222E') from: 447 to: 451;
	makeColor: (Color fromHexString: 'CF222E') from: 487 to: 489;
	makeColor: (Color fromHexString: 'CF222E') from: 517 to: 519;
	makeColor: (Color fromHexString: 'CF222E') from: 545 to: 548;
	makeColor: (Color fromHexString: 'CF222E') from: 582 to: 584;
	makeColor: (Color fromHexString: 'CF222E') from: 618 to: 621;
	makeColor: (Color fromHexString: 'CF222E') from: 656 to: 658;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedRunReportWithRules [

	^ (Text fromString: 'Running 1 feature.


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
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 117 to: 127;
	makeColor: (Color fromHexString: 'CF222E') from: 117 to: 127;
	makeColor: (Color fromHexString: 'CF222E') from: 131 to: 135;
	makeBoldFrom: 196 to: 204;
	makeColor: (Color fromHexString: 'CF222E') from: 196 to: 204;
	makeColor: (Color fromHexString: 'CF222E') from: 266 to: 270;
	makeColor: (Color fromHexString: 'CF222E') from: 344 to: 348;
	makeColor: (Color fromHexString: 'CF222E') from: 374 to: 377;
	makeBoldFrom: 395 to: 399;
	makeColor: (Color fromHexString: 'CF222E') from: 395 to: 399;
	makeBoldFrom: 529 to: 539;
	makeColor: (Color fromHexString: 'CF222E') from: 529 to: 539;
	makeColor: (Color fromHexString: 'CF222E') from: 544 to: 548;
	makeBoldFrom: 575 to: 583;
	makeColor: (Color fromHexString: 'CF222E') from: 575 to: 583;
	makeColor: (Color fromHexString: 'CF222E') from: 602 to: 606;
	makeColor: (Color fromHexString: 'CF222E') from: 646 to: 649;
	makeColor: (Color fromHexString: 'CF222E') from: 686 to: 688;
	makeColor: (Color fromHexString: 'CF222E') from: 710 to: 713;
	makeBoldFrom: 743 to: 751;
	makeColor: (Color fromHexString: 'CF222E') from: 743 to: 751;
	makeColor: (Color fromHexString: 'CF222E') from: 772 to: 776;
	makeColor: (Color fromHexString: 'CF222E') from: 816 to: 819;
	makeColor: (Color fromHexString: 'CF222E') from: 856 to: 858;
	makeColor: (Color fromHexString: 'CF222E') from: 879 to: 882;
	makeBoldFrom: 926 to: 930;
	makeColor: (Color fromHexString: 'CF222E') from: 926 to: 930;
	makeBoldFrom: 988 to: 996;
	makeColor: (Color fromHexString: 'CF222E') from: 988 to: 996;
	makeColor: (Color fromHexString: 'CF222E') from: 1030 to: 1034;
	makeColor: (Color fromHexString: 'CF222E') from: 1065 to: 1068;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedUndefinedStepErrorRunReport [

	^ (Text fromString: 'Running 1 feature.


Feature: With undefined step

	Scenario: Undefined steps have a pink background
		Given this step has no definition
			ERROR Step definition not found.


Total: 1 scenario. Passed: 0. Failed: 0. Error: 1. Duration: 0 seconds.
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 53 to: 61;
	makeColor: (Color fromHexString: 'CF222E') from: 53 to: 61;
	makeColor: (Color fromHexString: 'CF222E') from: 104 to: 108;
	makeBoldFrom: 141 to: 145;
	makeColor: (Color fromHexString: 'FE0000') from: 141 to: 145;
	yourself
]

{ #category : 'expected output' }
HeraScriptRunnerWithTextReporterTestCase >> expectedUnimplementedStepErrorRunReport [

	^ (Text fromString: 'Running 1 feature.


Feature: With unimplemented step

	Scenario: Successful sign-in
		Given this step is not implemeted
			ERROR Step not implemented.


Total: 1 scenario. Passed: 0. Failed: 0. Error: 1. Duration: 0 seconds.
')
	makeBoldFrom: 22 to: 29;
	makeColor: (Color fromHexString: 'CF222E') from: 22 to: 29;
	makeBoldFrom: 57 to: 65;
	makeColor: (Color fromHexString: 'CF222E') from: 57 to: 65;
	makeColor: (Color fromHexString: 'CF222E') from: 88 to: 92;
	makeBoldFrom: 125 to: 129;
	makeColor: (Color fromHexString: 'FE0000') from: 125 to: 129;
	yourself
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
