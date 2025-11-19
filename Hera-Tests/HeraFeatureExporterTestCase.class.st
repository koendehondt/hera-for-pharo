Class {
	#name : 'HeraFeatureExporterTestCase',
	#superclass : 'HeraUnitTestCase',
	#instVars : [
		'destinationFolder'
	],
	#category : 'Hera-Tests-Exporting',
	#package : 'Hera-Tests',
	#tag : 'Exporting'
}

{ #category : 'running' }
HeraFeatureExporterTestCase >> describedClass [

	^ HeraFeatureExporter
]

{ #category : 'running' }
HeraFeatureExporterTestCase >> setUp [

	super setUp.
	destinationFolder := FileLocator workingDirectory / 'temp_for_unit_tests'
]

{ #category : 'running' }
HeraFeatureExporterTestCase >> tearDown [

	destinationFolder deleteAll.
	super tearDown
]

{ #category : 'tests' }
HeraFeatureExporterTestCase >> testExportFeatures [

	| errorExampleFolder failureExampleFolder errorFeatureFile failureFeatureFile |
	subject scope: (HeraScope new addClasses: { HeraAcceptanceTestWithErrorForTesting . HeraAcceptanceTestWithFailureForTesting }).
	subject exportFeaturesTo: destinationFolder.
	self assert: destinationFolder entries size equals: 2.
	errorExampleFolder := destinationFolder / 'Example with error'.
	failureExampleFolder := destinationFolder / 'Example with failure'.
	self assert: errorExampleFolder exists.
	self assert: failureExampleFolder exists.
	self assert: errorExampleFolder entries size equals: 1.
	self assert: failureExampleFolder entries size equals: 1.
	errorFeatureFile := errorExampleFolder / 'Signing in.feature'.
	failureFeatureFile := failureExampleFolder / 'Signing in.feature'.
	self assert: errorFeatureFile exists.
	self assert: failureFeatureFile exists.
	self assert: errorFeatureFile contents equals: '@accessing_the_system
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
	self assert: failureFeatureFile contents equals: '@accessing_the_system
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
