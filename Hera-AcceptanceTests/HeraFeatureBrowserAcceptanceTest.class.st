Class {
	#name : 'HeraFeatureBrowserAcceptanceTest',
	#superclass : 'HeraAcceptanceTest',
	#instVars : [
		'featureBrowser',
		'oldShowThisClassInBrowser',
		'oldShowAcceptanceTestClassInBrowser'
	],
	#classInstVars : [
		'showInBrowser'
	],
	#category : 'Hera-AcceptanceTests',
	#package : 'Hera-AcceptanceTests'
}

{ #category : 'testing' }
HeraFeatureBrowserAcceptanceTest class >> initialize [

	self showInBrowser: false
]

{ #category : 'accessing' }
HeraFeatureBrowserAcceptanceTest class >> nameInBrowser [

	^ 'Hera Feature Browser'
]

{ #category : 'testing' }
HeraFeatureBrowserAcceptanceTest class >> showInBrowser [

	^ showInBrowser
]

{ #category : 'accessing' }
HeraFeatureBrowserAcceptanceTest class >> showInBrowser: aBoolean [

	showInBrowser := aBoolean
]

{ #category : 'running' }
HeraFeatureBrowserAcceptanceTest >> afterScenario [

	featureBrowser ifNotNil: [ featureBrowser window close ].
	self class showInBrowser: oldShowThisClassInBrowser.
	HeraAcceptanceTestWithPassForTesting showInBrowser: oldShowAcceptanceTestClassInBrowser
]

{ #category : 'running' }
HeraFeatureBrowserAcceptanceTest >> beforeScenario [

	oldShowThisClassInBrowser := self class showInBrowser.
	self class showInBrowser: false.
	oldShowAcceptanceTestClassInBrowser := HeraAcceptanceTestWithPassForTesting showInBrowser
]

{ #category : 'features' }
HeraFeatureBrowserAcceptanceTest >> featureBasicBrowsing [

	<heraFeature: 'Basic browsing'>

	^ (self feature: 'Basic browsing')
		description: {
			'In order to read features' .
			'As a test author' .
			'I want to browse the available features' };
		scenarios: {
			(self scenario: 'Browsing when no features exist')
				given: 'no features exist';
				when: 'I open the Feature Browser';
				then: 'I see an empty list of features' .
			(self scenario: 'Browsing features')
				given: 'two features exist';
				when: 'I open the Feature Browser';
				then: 'I see two features in the list';
				when: 'I select the first feature';
				then: 'I see the script of the first feature in the browser';
				when: 'I select the second feature';
				then: 'I see the script of the second feature in the browser' }
]

{ #category : 'steps' }
HeraFeatureBrowserAcceptanceTest >> stepIOpenTheFeatureBrowser [

	<heraStepDefinition: #(When 'I open the Feature Browser')>

	featureBrowser := HeraFeatureBrowser new.
	featureBrowser open
]

{ #category : 'steps' }
HeraFeatureBrowserAcceptanceTest >> stepISeeAnEmptyListOfFeatures [

	<heraStepDefinition: #(Then 'I see an empty list of features')>

	self expect: featureBrowser hasNoFeatures
]

{ #category : 'steps' }
HeraFeatureBrowserAcceptanceTest >> stepISeeTheScriptOfTheFirstFeatureInTheBrowser [

	<heraStepDefinition: #(Then 'I see the script of the first feature in the browser')>

	self
		expect: featureBrowser script
		toEqual: '@accessing_the_system
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
		But I see a message that the credentials are wrong'
]

{ #category : 'steps' }
HeraFeatureBrowserAcceptanceTest >> stepISeeTheScriptOfTheSecondFeatureInTheBrowser [

	<heraStepDefinition: #(Then 'I see the script of the second feature in the browser')>

	self
		expect: featureBrowser script
		toEqual: '@accessing_the_system
@signing_out
Feature: Signing out

	@sign_out
	Scenario: Signing out
		Given I am logged in
		When I sign out
		Then I see the landing page'
]

{ #category : 'steps' }
HeraFeatureBrowserAcceptanceTest >> stepISeeTwoFeaturesInTheList [

	<heraStepDefinition: #(Then 'I see two features in the list')>

	self
		expect: featureBrowser displayedTreeItems
		toEqual: {
			'Example with pass and unimplemented step' -> {
				'Signing in' .
				'Signing out' } }
]

{ #category : 'steps' }
HeraFeatureBrowserAcceptanceTest >> stepISelectTheFirstFeature [

	<heraStepDefinition: #(When 'I select the first feature')>

	featureBrowser selectPath: #(1 1)
]

{ #category : 'steps' }
HeraFeatureBrowserAcceptanceTest >> stepISelectTheSecondFeature [

	<heraStepDefinition: #(When 'I select the second feature')>

	featureBrowser selectPath: #(1 2)
]

{ #category : 'steps' }
HeraFeatureBrowserAcceptanceTest >> stepNoFeaturesExist [

	<heraStepDefinition: #(Given 'no features exist')>

	"Do nothing."
]

{ #category : 'steps' }
HeraFeatureBrowserAcceptanceTest >> stepTwoFeaturesExist [

	<heraStepDefinition: #(Given 'two features exist')>

	HeraAcceptanceTestWithPassForTesting showInBrowser: true
]
