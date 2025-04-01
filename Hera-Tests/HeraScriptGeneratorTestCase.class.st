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
		addAttribute: TextEmphasis bold from: 415 to: 423.
	^ text
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithBackground [

	| text |
	text := Text fromString:	'Feature: With background for testing

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
		addAttribute: TextEmphasis bold from: 40 to: 50;
		addAttribute: TextEmphasis bold from: 92 to: 100;
		addAttribute: TextEmphasis bold from: 216 to: 224.
	^ text
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithDataTable [

	| text |
	text := Text fromString:	'Feature: With data table for testing

	Scenario: Listing users
		Given the following users exist:
			| Name | Email            |
			| John | john@testing.org |
			| Jane | jane@testing.org |
		Then I see them in the list of users'.
	text
		addAttribute: TextEmphasis bold from: 1 to: 8;
		addAttribute: TextEmphasis bold from: 40 to: 48.
	^ text
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithDocString [

	| text |
	text := Text fromString:	'Feature: With doc string for testing

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
		addAttribute: TextEmphasis bold from: 40 to: 48.
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
