Class {
	#name : 'HeraAcceptanceTestExamplesForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'accessing' }
HeraAcceptanceTestExamplesForTesting class >> nameInBrowser [

	^ 'Examples for testing'
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> emptyFeature [

	<heraFeature: 'Empty'>

	^ self feature: 'Empty'
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithBackground [

	<heraFeature: 'With background'>

	^ (self feature: 'With background')
		background: (self background
			given: 'I have a user name';
			and: 'a password';
			but: 'no email');
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

	<heraFeature: 'With data table'>

	^ (self feature: 'With data table')
		scenarios: {
			(self scenario: 'Listing users')
				given: 'the following users exist:' with: (self dataTable: {
					{ 'Name' . 'Email' } .
					{ 'John' . 'john@testing.org' } .
					{ 'Jane' . 'jane@testing.org' } });
				when: 'I add the following users:' with: (self dataTable: {
					{ 'Name' . 'Email' } .
					{ 'Jake' . 'jake@testing.org' } .
					{ 'Emma' . 'emma@testing.org' } });
				and: 'I add the following users:' with: (self dataTable: {
					{ 'Name' . 'Email' } .
					{ 'Jill' . 'jill@testing.org' } });
				but: 'I remove the following users:' with: (self dataTable: {
					{ 'Name' . 'Email' } .
					{ 'Jake' . 'jake@testing.org' } });
				then: 'I see these users in the list:' with: (self dataTable: {
					{ 'Name' . 'Email' } .
					{ 'John' . 'john@testing.org' } .
					{ 'Jane' . 'jane@testing.org' } .
					{ 'Emma' . 'emma@testing.org' } .
					{ 'Jill' . 'jill@testing.org' } }) }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithDebugStep [

	<heraFeature: 'With debug step'>

	^ (self feature: 'With debug step')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'I have credentials to sign in';
				when: 'I debug';
				when: 'I enter my credentials';
				and: 'I press the button to sign in';
				then: 'I see the home page' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithDescriptionInBackground [

	<heraFeature: 'With description in background'>

	^ (self feature: 'With description in background')
		background: (self background
			description: {
				'Signing in is required for all other functionality' };
			given: 'I have a user name';
			and: 'a password';
			but: 'no email');
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
HeraAcceptanceTestExamplesForTesting >> featureWithDocString [

	<heraFeature: 'With doc string'>

	^ (self feature: 'With doc string')
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

	<heraFeature: 'With empty scenario'>

	^ (self feature: 'With empty scenario')
		scenarios: {
			self scenario: 'Successful sign-in' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithError [

	<heraFeature: 'With error'>

	^ (self feature: 'With error')
		scenarios: {
			(self scenario: 'Running this scenario in debug mode opens the debugger')
				when: 'an error occurs' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithPauseStep [

	<heraFeature: 'With pause step'>

	^ (self feature: 'With pause step')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'I have credentials to sign in';
				when: 'I pause';
				when: 'I enter my credentials';
				and: 'I press the button to sign in';
				then: 'I see the home page' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithRules [

	<heraFeature: 'With rules'>

	^ (self feature: 'With rules')
		description: {
			'Managing users is essential to permit and revoke access to the system.' };
		background: (self background
			given: 'an administrator user and a non-administrator user exist');
		scenarios: {
			(self scenario: 'Scenarios before the first rule are not related to a rule')
				given: 'I am an administrator';
				then: 'I can sign in' };
		rules: {
			(self rule: 'Only administrators are allowed to manage users')
				description: {
					'Users are managed by administrators, who can assign permissions to users.' };
				background: (self background
					given: 'I am an administrator');
				scenarios: {
					(self scenario: 'Adding a user')
						when: 'I open the user management page';
						and: 'I add a new user';
						then: 'the new user can sign in' .
					(self scenario: 'Removing a user')
						when: 'I open the user management page';
						and: 'I remove a user';
						then: 'the removed user cannot sign in anymore' } .
			(self rule: 'Non-administrators have no access to user management')
				scenarios: {
					(self scenario: 'No access to user management')
						given: 'I am not an administrator';
						then: 'I cannot open the user management page' } }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithScenarioWithSingleStep [

	<heraFeature: 'With single step scenario'>

	^ (self feature: 'With single step scenario')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'I have credentials to sign in' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithScenarioWithUndefinedStep [

	<heraFeature: 'With undefined step'>

	^ (self feature: 'With undefined step')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'this step has no definition' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithScenarioWithUnimplementedStep [

	<heraFeature: 'With unimplemented step'>

	^ (self feature: 'With unimplemented step')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'this step is not implemeted' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithStarSteps [

	<heraFeature: 'With * steps'>

	^ (self feature: 'With * steps')
		scenarios: {
			(self scenario: 'Successful sign-in')
				given: 'I have credentials to sign in';
				when: 'I open the sign-in page';
				star: 'I fill in my user name';
				star: 'I fill in my password';
				star: 'I press the sign-in button';
				then: 'I see the home page' }
]

{ #category : 'features' }
HeraAcceptanceTestExamplesForTesting >> featureWithTags [

	<heraFeature: 'With tags'>

	^ (self feature: 'With tags')
		tags: {
			#feature_level_tag };
		scenarios: {
			(self scenario: 'A first scenario')
				tags: {
					#'first-scenario-level-tag' } .
			(self scenario: 'A second scenario')
				tags: {
					#'second-scenario-level-tag' } }
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
HeraAcceptanceTestExamplesForTesting >> stepAPassword [

	<heraStepDefinition: #(Given 'a password')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepAnAdministratorUserAndANonAdministratorUserExist [

	<heraStepDefinition: #(Given 'an administrator user and a non-administrator user exist')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepAnErrorOccurs [

	<heraStepDefinition: #(When 'an error occurs')>

	(ZeroDivide new messageText: 'Zero divide') signal
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIAddANewUser [
	
	<heraStepDefinition: #(When 'I add a new user')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIAddTheFollowingUsers: aDataTable [

	<heraStepDefinition: #(When 'I add the following users:')>

	(self stateAt: #users) addAll: aDataTable asDictionaries
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIAmAnAdministrator [
	
	<heraStepDefinition: #(Given 'I am an administrator')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIAmNotAnAdministrator [
	
	<heraStepDefinition: #(Given 'I am not an administrator')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIAmStillOnTheSignInPage [
	
	<heraStepDefinition: #(Then 'I am still on the sign-in page')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepICanSignIn [
	
	<heraStepDefinition: #(Then 'I can sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepICannotOpenTheUserManagementPage [
	
	<heraStepDefinition: #(Then 'I cannot open the user management page')>
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
HeraAcceptanceTestExamplesForTesting >> stepIHaveAUserName [

	<heraStepDefinition: #(Given 'I have a user name')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIHaveCredentialsToSignIn [
	
	<heraStepDefinition: #(Given 'I have credentials to sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIOpenTheUserManagementPage [
	
	<heraStepDefinition: #(When 'I open the user management page')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIPressTheButtonToSignIn [
	
	<heraStepDefinition: #(When 'I press the button to sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIRemoveAUser [
	
	<heraStepDefinition: #(When 'I remove a user')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepIRemoveTheFollowingUsers: aDataTable [

	<heraStepDefinition: #(Given 'I remove the following users:')>

	(self stateAt: #users) removeAll: aDataTable asDictionaries
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
HeraAcceptanceTestExamplesForTesting >> stepISeeTheseUsersInTheList: aDataTable [

	<heraStepDefinition: #(Then 'I see these users in the list:')>

	| expectedUsers users |
	users := self stateAt: #users.
	expectedUsers := aDataTable asDictionaries.
	self assert: users size equals: expectedUsers size.
	expectedUsers withIndexDo: [ :expectedUser :index | | user |
		user := users at: index.
		self assert: (user at: 'Name') equals: (expectedUser at: 'Name').
		self assert: (user at: 'Email') equals: (expectedUser at: 'Email') ]
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepNoEmail [

	<heraStepDefinition: #(Given 'no email')>
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
HeraAcceptanceTestExamplesForTesting >> stepTheFollowingUsersExist: aDataTable [

	<heraStepDefinition: #(Given 'the following users exist:')>

	self stateAt: #users put: aDataTable asDictionaries asOrderedCollection
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepTheNewUserCanSignIn [
	
	<heraStepDefinition: #(Then 'the new user can sign in')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepTheRemovedUserCannotSignInAnymore [
	
	<heraStepDefinition: #(Then 'the removed user cannot sign in anymore')>
]

{ #category : 'steps' }
HeraAcceptanceTestExamplesForTesting >> stepThisStepIsNotImplemented [
	
	<heraStepDefinition: #(Given 'this step is not implemeted')>

	self stepNotImplemented
]
