Class {
	#name : 'HeraFeatureTestCase',
	#superclass : 'HeraUnitTestCase',
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

	^ (Text fromString: '@accessing_the_system
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

')
	makeColor: (Color fromHexString: '116329') from: 1 to: 21;
	makeColor: (Color fromHexString: '116329') from: 23 to: 33;
	makeBoldFrom: 35 to: 42;
	makeColor: (Color fromHexString: 'CF222E') from: 35 to: 42;
	makeColor: (Color fromHexString: '0A3069') from: 44 to: 53;
	makeColor: (Color fromHexString: '116329') from: 185 to: 192;
	makeBoldFrom: 195 to: 203;
	makeColor: (Color fromHexString: 'CF222E') from: 195 to: 203;
	makeColor: (Color fromHexString: '0A3069') from: 205 to: 222;
	makeColor: (Color fromHexString: 'CF222E') from: 285 to: 289;
	makeColor: (Color fromHexString: 'CF222E') from: 323 to: 326;
	makeColor: (Color fromHexString: 'CF222E') from: 353 to: 355;
	makeColor: (Color fromHexString: 'CF222E') from: 389 to: 392;
	makeBoldFrom: 416 to: 424;
	makeColor: (Color fromHexString: 'CF222E') from: 416 to: 424;
	makeColor: (Color fromHexString: '0A3069') from: 426 to: 445;
	makeColor: (Color fromHexString: 'CF222E') from: 449 to: 453;
	makeColor: (Color fromHexString: 'CF222E') from: 487 to: 490;
	makeColor: (Color fromHexString: 'CF222E') from: 524 to: 526;
	makeColor: (Color fromHexString: 'CF222E') from: 560 to: 563;
	makeColor: (Color fromHexString: 'CF222E') from: 598 to: 600;
	yourself
]

{ #category : 'tests' }
HeraFeatureTestCase >> testPrintString [

	subject title: 'Signing in'.
	self assert: subject printString equals: 'Feature: Signing in'
]

{ #category : 'tests' }
HeraFeatureTestCase >> testRichScriptWithFullScenario [

	| feature |
	feature := HeraAcceptanceTestWithPassForTesting new signingInFeature.
	Hera settings syntaxLightThemeDuring: [
		self assertText: feature richScript equals: self expectedGeneratedRichScript ]
]

{ #category : 'tests' }
HeraFeatureTestCase >> testScriptOfEmptyFeature [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new emptyFeature.
	self assert: feature script equals: 'Feature: Empty

'
	
]

{ #category : 'tests' }
HeraFeatureTestCase >> testScriptWithEmptyScenario [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithEmptyScenario.
	self assert: feature script equals: 'Feature: With empty scenario

	Scenario: Successful sign-in

'
	
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
		Given I have credentials to sign in

'
	
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
		But I see a message that the credentials are wrong

'
	
]
