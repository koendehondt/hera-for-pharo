Class {
	#name : 'HeraFeatureMethodGeneratorTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-AST',
	#package : 'Hera-Tests',
	#tag : 'AST'
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
