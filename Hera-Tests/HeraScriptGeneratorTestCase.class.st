Class {
	#name : 'HeraScriptGeneratorTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Script generation',
	#package : 'Hera-Tests',
	#tag : 'Script generation'
}

{ #category : 'running' }
HeraScriptGeneratorTestCase >> describedClass [

	^ HeraScriptGenerator
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScript [

	| text |
	text := Text fromString:	'@accessing_the_system
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
		But I see a message that the credentials are wrong'.
	text
		addAttribute: TextEmphasis bold from: 35 to: 42;
		addAttribute: TextEmphasis bold from: 195 to: 203;
		addAttribute: TextEmphasis bold from: 416 to: 424.
	^ text
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithBackground [

	| text |
	text := Text fromString:	'Feature: With background

	Background:
		Given I have credentials to sign in

	Scenario: Successful sign-in
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

	Scenario: Unsuccessful sign-in
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 28 to: 38;
		addAttribute: TextEmphasis bold from: 80 to: 88;
		addAttribute: TextEmphasis bold from: 204 to: 212.
	^ text
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithDataTable [

	| text |
	text := Text fromString:	'Feature: With data table

	Scenario: Listing users
		Given the following users exist:
			| Name | Email            |
			| John | john@testing.org |
			| Jane | jane@testing.org |
		Then I see them in the list of users'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 28 to: 36.
	^ text
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithDocString [

	| text |
	text := Text fromString:	'Feature: With doc string

	Scenario: Listing users
		Given the following users exist:
			| Name | Email            |
			| John | john@testing.org |
			| Jane | jane@testing.org |
		When the API receives a GET request "https://testing.org/users"
		Then the API responds with:
			"""
			<users>
				<user>
					<name>John</name>
					<email>john@testing.org</email>
				</user>
				<user>
					<name>Jane</name>
					<email>jane@testing.org</email>
				</user>
			</users>
			"""'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 28 to: 36.
	^ text
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithRules [

	| text |
	text := Text fromString:	'
Feature: With rules

	Managing users is essential to permit and revoke access to the system.

	Background:
		Given an administrator user and a non-administrator user exist

	Scenario: Scenarios before the first rule are not related to a rule
		Given I am an administrator
		Then I can sign in

	Rule: Only administrators are allowed to manage users

		Users are managed by administrators, who can assign permissions to users.

		Background:
			Given I am an administrator

		Scenario: Adding a user
			When I open the user management page
			And I add a new user
			Then the new user can sign in

		Scenario: Removing a user
			When I open the user management page
			And I remove a user
			Then the removed user cannot sign in anymore

	Rule: Non-administrators have no access to user management

		Scenario: No access to user management
			Given I am not an administrator
			Then I cannot open the user management page' allButFirst.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 96 to: 106;
		addAttribute: TextEmphasis bold from: 175 to: 183;
		addAttribute: TextEmphasis bold from: 296 to: 300;
		addAttribute: TextEmphasis bold from: 430 to: 440;
		addAttribute: TextEmphasis bold from: 476 to: 484;
		addAttribute: TextEmphasis bold from: 600 to: 608;
		addAttribute: TextEmphasis bold from: 739 to: 743;
		addAttribute: TextEmphasis bold from: 801 to: 809.
	^ text
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScript [

	| feature |
	feature := HeraAcceptanceTestWithPassForTesting new signingInFeature.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScript
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithBackground [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithBackground.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithBackground
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithDataTable [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithDataTable.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithDataTable
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithDocString [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithDocString.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithDocString
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithRules [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithRules.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithRules
]
