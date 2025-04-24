Class {
	#name : 'HeraFeatureTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraFeatureTestCase >> describedClass [

	^ HeraFeature
]

{ #category : 'private' }
HeraFeatureTestCase >> expectedGeneratedRichScript [

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

{ #category : 'tests' }
HeraFeatureTestCase >> testPrintString [

	subject name: 'Signing in'.
	self assert: subject printString equals: 'Feature: Signing in'
]

{ #category : 'tests' }
HeraFeatureTestCase >> testRichScriptWithFullScenario [

	| feature |
	feature := HeraAcceptanceTestWithPassForTesting new signingInFeature.
	self assertText: feature richScript equals: self expectedGeneratedRichScript
]

{ #category : 'tests' }
HeraFeatureTestCase >> testScriptOfEmptyFeature [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new emptyFeature.
	self assert: feature script equals: 'Feature: Empty'
	
]

{ #category : 'tests' }
HeraFeatureTestCase >> testScriptWithEmptyScenario [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithEmptyScenario.
	self assert: feature script equals: 'Feature: With empty scenario

	Scenario: Successful sign-in'
	
]

{ #category : 'tests' }
HeraFeatureTestCase >> testScriptWithFullScenario [

	| feature |
	feature := HeraAcceptanceTestWithPassForTesting new signingInFeature.
	self assert: feature script equals: self expectedGeneratedRichScript string
]

{ #category : 'tests' }
HeraFeatureTestCase >> testScriptWithSingleStep [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithScenarioWithSingleStep.
	self assert: feature script equals: 'Feature: With single step scenario

	Scenario: Successful sign-in
		Given I have credentials to sign in'
	
]

{ #category : 'tests' }
HeraFeatureTestCase >> testScriptWithTwoScenarios [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithTwoScenarios.
	self assert: feature script equals: 'Feature: Signing in

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

	Scenario: Unsuccessful sign-in
		Given I have credentials to sign in
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong'
	
]
