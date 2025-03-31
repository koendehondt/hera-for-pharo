Class {
	#name : 'HeraAcceptanceTestExamplesForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#instVars : [
		'users'
	],
	#category : 'Hera-Tests-Support',
	#package : 'Hera-Tests',
	#tag : 'Support'
}

{ #category : 'accessing' }
HeraAcceptanceTestExamplesForTesting class >> nameInBrowser [

	^ 'Examples for testing'
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> emptyFeature [

	<heraFeature: 'Empty for testing'>

	^ self feature: 'Empty for testing'
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithBackground [

	<heraFeature: 'With background for testing'>

	^ (self feature: 'With background for testing')
		background: (self background
			given: 'I have credentials to sign in');
		scenarios: {
			(self scenario: 'Successful sign-in')
				when: 'I enter my credentials';
				and: 'I press the button to sign in';
				then: 'I see the home page' .
			(self scenario: 'Unsuccessful sign-in')
				when: 'I enter the wrong credentials';
				and: 'I press the button to sign in';
				then: 'I am still on the sign-in page';
				but: 'I see a message that the credentials are wrong' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithDataTable [

	<heraFeature: 'With data table for testing'>

	^ (self feature: 'With data table for testing')
		scenarios: {
			(self scenario: 'Listing users')
				given: 'the following users exist:' with: (self dataTable: {
					{ 'Name' . 'Email' } .
					{ 'John' . 'john@testing.org' } .
					{ 'Jane' . 'jane@testing.org' } });
				then: 'I see them in the list of users' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithDebugStep [

	<heraFeature: 'With debug step for testing'>

	^ (self feature: 'With debug step for testing')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'I have credentials to sign in';
				when: 'I debug';
				when: 'I enter my credentials';
				and: 'I press the button to sign in';
				then: 'I see the home page' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithDocString [

	<heraFeature: 'With doc string for testing'>

	^ (self feature: 'With doc string for testing')
		scenarios: {
			(self scenario: 'Listing users')
				given: 'the following users exist:' with: (self dataTable: {
					{ 'Name' . 'Email' } .
					{ 'John' . 'john@testing.org' } .
					{ 'Jane' . 'jane@testing.org' } });
				when: 'the API receives a GET request "https://testing.org/users"';
				then: 'the API responds with:' with: (self docString: {
					'<users>' .
					'	<user>' .
					'		<name>John</name>' .
					'		<email>john@testing.org</email>' .
					'	</user>' .
					'	<user>' .
					'		<name>Jane</name>' .
					'		<email>jane@testing.org</email>' .
					'	</user>' .
					'</users>' }) }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithEmptyScenario [

	<heraFeature: 'With empty scenario for testing'>

	^ (self feature: 'With empty scenario for testing')
		scenarios: {
			self scenario: 'Successful sign-in' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithPauseStep [

	<heraFeature: 'With pause step for testing'>

	^ (self feature: 'With pause step for testing')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'I have credentials to sign in';
				when: 'I pause';
				when: 'I enter my credentials';
				and: 'I press the button to sign in';
				then: 'I see the home page' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithScenarioWithSingleStep [

	<heraFeature: 'With single step scenario for testing'>

	^ (self feature: 'With single step scenario for testing')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'I have credentials to sign in' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithScenarioWithUndefinedStep [

	<heraFeature: 'With undefined step for testing'>

	^ (self feature: 'With undefined step for testing')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'this step has no definition' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithScenarioWithUnimplementedStep [

	<heraFeature: 'With unimplemented step for testing'>

	^ (self feature: 'With unimplemented step for testing')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'this step is not implemeted' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithTwoScenarios [

	<heraFeature: 'Signing in'>

	^ (self feature: 'Signing in')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'I have credentials to sign in';
				when: 'I enter my credentials';
				and: 'I press the button to sign in';
				then: 'I see the home page' .
			(self scenario: 'Unsuccessful sign-in')
				given: 'I have credentials to sign in';
				when: 'I enter the wrong credentials';
				and: 'I press the button to sign in';
				then: 'I am still on the sign-in page';
				but: 'I see a message that the credentials are wrong' }
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIAmStillOnTheSignInPage [
	
	<heraStepDefinition: #(Then 'I am still on the sign-in page')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIEnterMyCredentials [
	
	<heraStepDefinition: #(When 'I enter my credentials')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIEnterTheWrongCredentials [
	
	<heraStepDefinition: #(When 'I enter the wrong credentials')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIHaveCredentialsToSignIn [
	
	<heraStepDefinition: #(Given 'I have credentials to sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIPressTheButtonToSignIn [
	
	<heraStepDefinition: #(When 'I press the button to sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepISeeAMessageThatTheCredentialsAreWrong [
	
	<heraStepDefinition: #(Then 'I see a message that the credentials are wrong')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepISeeTheHomePage [
	
	<heraStepDefinition: #(Then 'I see the home page')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepISeeThemInTheListOfUsers [

	<heraStepDefinition: #(Then 'I see them in the list of users')>

	| john jane |
	john := users first.
	jane := users second.
	self assert: (john at: 'Name') equals: 'John'.
	self assert: (john at: 'Email') equals: 'john@testing.org'.
	self assert: (jane at: 'Name') equals: 'Jane'.
	self assert: (jane at: 'Email') equals: 'jane@testing.org'
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepTheAPIReceivesARequest: aHttpVerb for: aUrl [

	<heraStepDefinition: #(When match 'the API receives a {word} request {}')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepTheAPIRespondsWith: expectedResponseBody [

	<heraStepDefinition: #(Then 'the API responds with:')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepTheFollowingUsersExist: dataTable [

	<heraStepDefinition: #(Given 'the following users exist:')>

	users := dataTable asDictionaries
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepThisStepIsNotImplemented [
	
	<heraStepDefinition: #(Given 'this step is not implemeted')>

	self stepNotImplemented
]
