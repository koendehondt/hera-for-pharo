Class {
	#name : 'HeraFeatureMethodGeneratorTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Generation',
	#package : 'Hera-Tests',
	#tag : 'Generation'
}

{ #category : 'running' }
HeraFeatureMethodGeneratorTestCase >> describedClass [

	^ HeraFeatureMethodGenerator
]

{ #category : 'running' }
HeraFeatureMethodGeneratorTestCase >> initializeSubject [

	super initializeSubject.
	subject generatedSelector: #feature99
]

{ #category : 'private' }
HeraFeatureMethodGeneratorTestCase >> parse: description [

	| parser |
	parser := HeraParser new.
	parser initializeParserWith: description.
	^ parser parseFeature
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationExcludesEmptyAspects [

	| document ast |
	document := '
	Feature: Signing in
		Scenario: Successful sign-in'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Signing in''>

	^ (self feature: ''Signing in'')
		scenarios: {
			self scenario: ''Successful sign-in'' }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfBackground [

	| document ast |
	document := '
	Feature: Signing in

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
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Signing in''>

	^ (self feature: ''Signing in'')
		background: (self background
			given: ''I have credentials to sign in'');
		scenarios: {
			(self scenario: ''Successful sign-in'')
				when: ''I enter my credentials'';
				and: ''I press the button to sign in'';
				then: ''I see the home page'' .
			(self scenario: ''Unsuccessful sign-in'')
				when: ''I enter the wrong credentials'';
				and: ''I press the button to sign in'';
				then: ''I am still on the sign-in page'';
				but: ''I see a message that the credentials are wrong'' }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfBackgroundOnly [

	| document ast |
	document := '
	Feature: Signing in

		Background:
			Given I have credentials to sign in'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Signing in''>

	^ (self feature: ''Signing in'')
		background: (self background
			given: ''I have credentials to sign in'')'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfBackgroundWithDescription [

	| document ast |
	document := '
	Feature: Signing in

		Background:
			Singing in is required for all other activity.

		Scenario: Successful sign-in			
			When I enter my credentials
			And I press the button to sign in
			Then I see the home page'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Signing in''>

	^ (self feature: ''Signing in'')
		background: (self background
			description: {
				''Singing in is required for all other activity.'' });
		scenarios: {
			(self scenario: ''Successful sign-in'')
				when: ''I enter my credentials'';
				and: ''I press the button to sign in'';
				then: ''I see the home page'' }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfBackgroundWithDescriptionAndOneStep [

	| document ast |
	document := '
	Feature: Signing in

		Background:
			Singing in is required for all other activity.

			Given the sign-in page is open

		Scenario: Successful sign-in			
			When I enter my credentials
			And I press the button to sign in
			Then I see the home page'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Signing in''>

	^ (self feature: ''Signing in'')
		background: (self background
			description: {
				''Singing in is required for all other activity.'' };
			given: ''the sign-in page is open'');
		scenarios: {
			(self scenario: ''Successful sign-in'')
				when: ''I enter my credentials'';
				and: ''I press the button to sign in'';
				then: ''I see the home page'' }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfDataTable [

	| document ast |
	document := '
	Feature: Employee management

		Scenario: 10% raise
			Given the current salaries of the following employees
				| Name  | Salary |
				| John  | 1000   |
				| Jane  | 1250   |
				| Alice | 1000   |
				| Bob   | 1500   |
			When the company raises the salaries of the following users with 10%
				| Name |
				| John |
				| Jane |
			And the company raises the salaries of the following users with 5%
				| Name  |
				| Alice |
			Then I see the raised salaries in the employee overview
				| Name  | Salary |
				| John  | 1100   |
				| Jane  | 1375   |
				| Alice | 1050   |
			But I do not see a raised salary for the other employees
				| Name  | Salary |
				| Bob   | 1500   |'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Employee management''>

	^ (self feature: ''Employee management'')
		scenarios: {
			(self scenario: ''10% raise'')
				given: ''the current salaries of the following employees'' with: (self dataTable: {
					{ ''Name'' . ''Salary'' } .
					{ ''John'' . ''1000'' } .
					{ ''Jane'' . ''1250'' } .
					{ ''Alice'' . ''1000'' } .
					{ ''Bob'' . ''1500'' } });
				when: ''the company raises the salaries of the following users with 10%'' with: (self dataTable: {
					{ ''Name'' } .
					{ ''John'' } .
					{ ''Jane'' } });
				and: ''the company raises the salaries of the following users with 5%'' with: (self dataTable: {
					{ ''Name'' } .
					{ ''Alice'' } });
				then: ''I see the raised salaries in the employee overview'' with: (self dataTable: {
					{ ''Name'' . ''Salary'' } .
					{ ''John'' . ''1100'' } .
					{ ''Jane'' . ''1375'' } .
					{ ''Alice'' . ''1050'' } });
				but: ''I do not see a raised salary for the other employees'' with: (self dataTable: {
					{ ''Name'' . ''Salary'' } .
					{ ''Bob'' . ''1500'' } }) }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfDataTree [

	| script ast |
	script := '
	Feature: Family tree

		Scenario: Reading a family tree
			When I open the application
			Then I see the following family tree:
				>   John
				>>    Jane
				>>>     William
				>>    Mary
				'.
	ast := self parse: script.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Family tree''>

	^ (self feature: ''Family tree'')
		scenarios: {
			(self scenario: ''Reading a family tree'')
				when: ''I open the application'';
				then: ''I see the following family tree:'' with: (self dataTree: {
					''John'' -> {
						''Jane'' -> {
							''William'' -> { } } .
						''Mary'' -> { } } }) }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfDocString [

	| document ast |
	document := '
	Feature: REST API for users

		Scenario: GET users
			Given the following users:
				"""
				John,john@testing.org
				Jane,jane@testing.org
				"""
			When the API receives a GET request:
				"""
				https://testing.org/users
				"""
			Then the response Content-Type is:
			"""
			application/json
			"""
			And the API responds with:
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
				"""
			But the status code is:
			"""
			200 OK
			"""'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''REST API for users''>

	^ (self feature: ''REST API for users'')
		scenarios: {
			(self scenario: ''GET users'')
				given: ''the following users:'' with: (self docString: {
					''John,john@testing.org'' .
					''Jane,jane@testing.org'' });
				when: ''the API receives a GET request:'' with: (self docString: {
					''https://testing.org/users'' });
				then: ''the response Content-Type is:'' with: (self docString: {
					''application/json'' });
				and: ''the API responds with:'' with: (self docString: {
					''<users>'' .
					''	<user>'' .
					''		<name>John</name>'' .
					''		<email>john@testing.org</email>'' .
					''	</user>'' .
					''	<user>'' .
					''		<name>Jane</name>'' .
					''		<email>jane@testing.org</email>'' .
					''	</user>'' .
					''</users>'' });
				but: ''the status code is:'' with: (self docString: {
					''200 OK'' }) }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfEmptyBackground [

	| document ast |
	document := '
	Feature: Signing in

		Background:

		Scenario: Successful sign-in			
			When I enter my credentials
			And I press the button to sign in
			Then I see the home page'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Signing in''>

	^ (self feature: ''Signing in'')
		background: self background;
		scenarios: {
			(self scenario: ''Successful sign-in'')
				when: ''I enter my credentials'';
				and: ''I press the button to sign in'';
				then: ''I see the home page'' }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfEmptyBackgroundAtTheEnd [

	| document ast |
	document := '
	Feature: Signing in

		Background:'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Signing in''>

	^ (self feature: ''Signing in'')
		background: self background'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfEmptyFeature [

	| document ast |
	document := 'Feature: Signing in'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Signing in''>

	^ self feature: ''Signing in'''
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfFeatureWithRules [

	| document ast |
	document := '
Feature: User management
	Managing users is essential to permit and revoke access to the system.

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
			Then I cannot open the user management page'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''User management''>

	^ (self feature: ''User management'')
		description: {
			''Managing users is essential to permit and revoke access to the system.'' };
		scenarios: {
			(self scenario: ''Scenarios before the first rule are not related to a rule'')
				given: ''I am an administrator'';
				then: ''I can sign in'' };
		rules: {
			(self rule: ''Only administrators are allowed to manage users'')
				description: {
					''Users are managed by administrators, who can assign permissions to users.'' };
				background: (self background
					given: ''I am an administrator'');
				scenarios: {
					(self scenario: ''Adding a user'')
						when: ''I open the user management page'';
						and: ''I add a new user'';
						then: ''the new user can sign in'' .
					(self scenario: ''Removing a user'')
						when: ''I open the user management page'';
						and: ''I remove a user'';
						then: ''the removed user cannot sign in anymore'' } .
			(self rule: ''Non-administrators have no access to user management'')
				scenarios: {
					(self scenario: ''No access to user management'')
						given: ''I am not an administrator'';
						then: ''I cannot open the user management page'' } }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfFeatureWithSingleQuoteInTitle [

	| document ast |
	document := '
	Feature: Managing a user''s account'.
	ast := self parse: document.
	subject useSuggestedFeatureMethodSelectorFor: 'Managing a user''s account'.
	subject visit: ast.
	self assert: subject generatedCode equals: 'featureManagingAUsersAccount

	<heraFeature: ''Managing a user''''s account''>

	^ self feature: ''Managing a user''''s account'''
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfFeatureWithStarSteps [

	| document ast |
	document := '
Feature: With * steps

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I open the sign-in page
		* I fill in my user name
		* I fill in my password
		* I press the sign-in button
		Then I see the home page'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''With * steps''>

	^ (self feature: ''With * steps'')
		scenarios: {
			(self scenario: ''Successful sign-in'')
				given: ''I have credentials to sign in'';
				when: ''I open the sign-in page'';
				star: ''I fill in my user name'';
				star: ''I fill in my password'';
				star: ''I press the sign-in button'';
				then: ''I see the home page'' }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfFeatureWithTagsWithMinusSigns [

	| document ast |
	document := '
	@story-1234
	Feature: Tags with special characters

		@github-1234
		Scenario: Using a tag with special characters'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Tags with special characters''>

	^ (self feature: ''Tags with special characters'')
		tags: {
			#''story-1234'' };
		scenarios: {
			(self scenario: ''Using a tag with special characters'')
				tags: {
					#''github-1234'' } }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationOfFullFeature [

	| document ast |
	document := '
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
			But I see a message that the credentials are wrong'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Signing in''>

	^ (self feature: ''Signing in'')
		tags: {
			#accessing_the_system .
			#signing_in };
		description: {
			''Signing in is required to have access to the application.'' .
			'''' .
			''Signing in requires credentials: an email address and a password.'' };
		scenarios: {
			(self scenario: ''Successful sign-in'')
				tags: {
					#sign_in };
				description: {
					''Access is allowed when the credentials are recognized.'' };
				given: ''I have credentials to sign in'';
				when: ''I enter my credentials'';
				and: ''I press the button to sign in'';
				then: ''I see the home page'' .
			(self scenario: ''Unsuccessful sign-in'')
				given: ''I have credentials to sign in'';
				when: ''I enter the wrong credentials'';
				and: ''I press the button to sign in'';
				then: ''I am still on the sign-in page'';
				but: ''I see a message that the credentials are wrong'' }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testCodeGenerationWithSingleQuotesInTitlesAndDescriptions [

	| document ast |
	document := '
	Feature: Single '' quote in feature title

		Single '' quote in feature description.
		
		Rule: Single '' quote in rule title

			Single '' quote in rule description.

			Scenario: Single '' quote in scenario title

				Single '' quote in scenario description.
				
				Given a step with aa single '' quote
				When I do something with a single '' quote
				And I do something else with a single '' quote
				But I don''t do something else
				Then I see a single '' quote'.
	ast := self parse: document.
	subject visit: ast.
	self assert: subject generatedCode equals: 'feature99

	<heraFeature: ''Single '''' quote in feature title''>

	^ (self feature: ''Single '''' quote in feature title'')
		description: {
			''Single '''' quote in feature description.'' };
		rules: {
			(self rule: ''Single '''' quote in rule title'')
				description: {
					''Single '''' quote in rule description.'' };
				scenarios: {
					(self scenario: ''Single '''' quote in scenario title'')
						description: {
							''Single '''' quote in scenario description.'' };
						given: ''a step with aa single '''' quote'';
						when: ''I do something with a single '''' quote'';
						and: ''I do something else with a single '''' quote'';
						but: ''I don''''t do something else'';
						then: ''I see a single '''' quote'' } }'
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testSuggestedFeatureMethodSelectorFor [

	self assert: (subject suggestedFeatureMethodSelectorFor: 'Managing users') equals: #featureManagingUsers
]

{ #category : 'tests' }
HeraFeatureMethodGeneratorTestCase >> testSuggestedFeatureMethodSelectorForWithDisallowedCharacter [

	self assert: (subject suggestedFeatureMethodSelectorFor: 'Managing a user''s account') equals: #featureManagingAUsersAccount
]
