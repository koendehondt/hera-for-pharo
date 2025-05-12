Class {
	#name : 'HeraParserTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Parser',
	#package : 'Hera-Tests',
	#tag : 'Parser'
}

{ #category : 'helpers' }
HeraParserTestCase >> assertError: aString start: startInteger end: endInteger whenParsing: script [

	| error |
	self assert: (self parseFeature: script) isNil.
	error := subject parseError.
	self assert: error messageText equals: aString.
	self assert: error start equals: startInteger.
	self assert: error end equals: endInteger
]

{ #category : 'running' }
HeraParserTestCase >> describedClass [

	^ HeraParser
]

{ #category : 'helpers' }
HeraParserTestCase >> parseFeature: aScript [

	subject initializeParserWith: aScript.
	^ subject parseFeature
]

{ #category : 'tests' }
HeraParserTestCase >> testAstContainsTextPositions [

	| script ast tags |
	script := '
	@accessing_the_system
	@signing_in
	Feature: Signing in

		Signing in is required to have access to the application.
		Signing in requires credentials: an email address and a password.

		Scenario: Successful sign-in
			
			Given I have credentials to sign in
			When I enter my credentials
			And I press the button to sign in
			Then I see the home page'.
	ast := self parseFeature: script.
	tags := ast tags.
	self assert: tags first start equals: 3.
	self assert: tags first end equals: 23.
	self assert: tags second start equals: 26.
	self assert: tags second end equals: 36.
	self assert: ast start equals: 39.
	self assert: ast end equals: 357
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseBackgroundWithText [

	self
		assertError: 'Text after background keyword is not allowed'
		start: 30
		end: 40
		whenParsing: '
			Feature: Signing in

				Background: credentials
					Given I have credentials to sign in

				Scenario: Successful sign-in'
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseBackgroundWithThenStep [

	self
		assertError: 'This step is not allowed in a background'
		start: 47
		end: 50
		whenParsing: '
			Feature: Signing in

				Background:
					Then I have credentials to sign in

				Scenario: Successful sign-in'
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseBackgroundWithWhenStep [

	self
		assertError: 'This step is not allowed in a background'
		start: 47
		end: 50
		whenParsing: '
			Feature: Signing in

				Background:
					When I have credentials to sign in

				Scenario: Successful sign-in'
]

{ #category : 'tests' }
HeraParserTestCase >> testParseDataTable [

	| script ast scenarioNode stepNodes givenStepNode whenStepNode andStepNode thenStepNode butStepNode |
	script := '
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
	ast := self parseFeature: script.
	scenarioNode := ast scenarios first.
	stepNodes := scenarioNode steps.
	self assert: stepNodes size equals: 5.

	givenStepNode := stepNodes first.
	self assert: givenStepNode class equals: HeraGivenAstNode.
	self assert: givenStepNode description equals: 'the current salaries of the following employees'.
	self assert: givenStepNode argument class equals: HeraDataTableStepArgumentAstNode.
	self assert: givenStepNode argument dataTable equals: (HeraDataTable new data: {
		{ 'Name' . 'Salary' } .
		{ 'John' . '1000' } .
		{ 'Jane' . '1250' } .
		{ 'Alice' . '1000' } .
		{ 'Bob' . '1500' } }).
	self assert: givenStepNode start equals: 58.
	self assert: givenStepNode end equals: 225.

	whenStepNode := stepNodes second.
	self assert: whenStepNode class equals: HeraWhenAstNode.
	self assert: whenStepNode description equals: 'the company raises the salaries of the following users with 10%'.
	self assert: whenStepNode argument class equals: HeraDataTableStepArgumentAstNode.
	self assert: whenStepNode argument dataTable equals: (HeraDataTable new data: {
		{ 'Name' } .
		{ 'John' } .
		{ 'Jane' }}).
	self assert: whenStepNode start equals: 230.
	self assert: whenStepNode end equals: 336.

	andStepNode := stepNodes third.
	self assert: andStepNode class equals: HeraAndAstNode.
	self assert: andStepNode description equals: 'the company raises the salaries of the following users with 5%'.
	self assert: andStepNode argument class equals: HeraDataTableStepArgumentAstNode.
	self assert: andStepNode argument dataTable equals: (HeraDataTable new data: {
		{ 'Name' } .
		{ 'Alice' } }).
	self assert: andStepNode start equals: 341.
	self assert: andStepNode end equals: 434.

	thenStepNode := stepNodes fourth.
	self assert: thenStepNode class equals: HeraThenAstNode.
	self assert: thenStepNode description equals: 'I see the raised salaries in the employee overview'.
	self assert: thenStepNode argument class equals: HeraDataTableStepArgumentAstNode.
	self assert: thenStepNode argument dataTable equals: (HeraDataTable new data: {
		{ 'Name' . 'Salary' } .
		{ 'John' . '1100' } .
		{ 'Jane' . '1375' } .
		{ 'Alice' . '1050' } }).
	self assert: thenStepNode start equals: 439.
	self assert: thenStepNode end equals: 585.

	butStepNode := stepNodes fifth.
	self assert: butStepNode class equals: HeraButAstNode.
	self assert: butStepNode description equals: 'I do not see a raised salary for the other employees'.
	self assert: butStepNode argument class equals: HeraDataTableStepArgumentAstNode.
	self assert: butStepNode argument dataTable equals: (HeraDataTable new data: {
		{ 'Name' . 'Salary' } .
		{ 'Bob' . '1500' } }).
	self assert: butStepNode start equals: 590.
	self assert: butStepNode end equals: 691
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseDataTableWithEmptyLine [

	self
		assertError: 'Empty lines in data tables are not allowed'
		start: 103
		end: 164
		whenParsing: '
			Feature: User management

				Scenario: Listing users
					Given the following users exist:
						| Name | Email            |

						| Jane | jane@testing.org |
					Then I see them in the list of users'
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseDataTableWithMissingCell [

	self
		assertError: 'Data table has missing cells'
		start: 103
		end: 178
		whenParsing: '
			Feature: User management

				Scenario: Listing users
					Given the following users exist:
						| Name | Email            |
						| John |
						| Jane | jane@testing.org |
					Then I see them in the list of users'
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseDataTableWithMissingTerminatingBar [

	self
		assertError: 'Data table row not closed with |'
		start: 116
		end: 116
		whenParsing: '
			Feature: User management

				Scenario: Listing users
					Given the following users exist:
						| Name | Email
						| John | john@testing.org |
						| Jane | jane@testing.org |
					Then I see them in the list of users'
]

{ #category : 'tests' }
HeraParserTestCase >> testParseDataTableWithoutFormatting [

	| script ast scenarioNode firstStepNode secondStepNode |
	"The extra white space in the table is there on purpose, as the parser removes the white space.
	 There are also spaces after the vertical bars."
	script := '
	Feature: User management

		Scenario: Listing users
			Given the following users exist:
				| Name   | Email |   
			|  John |            john@testing.org             |   
		|   Jane |      jane@testing.org       |  
			Then I see them in the list of users'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast tags isEmpty.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'User management'.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode tags isEmpty.
	self assert: scenarioNode title text equals: 'Listing users'.
	self assert: scenarioNode steps size equals: 2.
	firstStepNode := scenarioNode steps first.
	self assert: firstStepNode class equals: HeraGivenAstNode.
	self assert: firstStepNode description equals: 'the following users exist:'.
	self assert: firstStepNode argument dataTable equals: (HeraDataTable new data: {
		{ 'Name' . 'Email' } .
		{ 'John' . 'john@testing.org' } .
		{ 'Jane' . 'jane@testing.org' }}).
	self assert: firstStepNode start equals: 58.
	self assert: firstStepNode end equals: 216.
	secondStepNode := scenarioNode steps second.
	self assert: secondStepNode class equals: HeraThenAstNode.
	self assert: secondStepNode description equals: 'I see them in the list of users'.
	self assert: secondStepNode argument isNil
]

{ #category : 'tests' }
HeraParserTestCase >> testParseDocString [

	| script ast scenarioNode stepNodes thenStepNode givenStepNode whenStepNode andStepNode butStepNode |
	script := '
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
	ast := self parseFeature: script.
	scenarioNode := ast scenarios first.
	stepNodes := scenarioNode steps.
	self assert: stepNodes size equals: 5.

	givenStepNode := stepNodes first.
	self assert: givenStepNode class equals: HeraGivenAstNode.
	self assert: givenStepNode description equals: 'the following users:'.
	self assert: givenStepNode argument class equals: HeraDocStringStepArgumentAstNode.
	self assert: givenStepNode argument docString equals: (HeraDocString new lines: { 
		'John,john@testing.org' .
		'Jane,jane@testing.org' }).
	self assert: givenStepNode start equals: 57.
	self assert: givenStepNode end equals: 150.

	whenStepNode := stepNodes second.
	self assert: whenStepNode class equals: HeraWhenAstNode.
	self assert: whenStepNode description equals: 'the API receives a GET request:'.
	self assert: whenStepNode argument class equals: HeraDocStringStepArgumentAstNode.
	self assert: whenStepNode argument docString equals: (HeraDocString new lines: { 
		'https://testing.org/users' }).
	self assert: whenStepNode start equals: 155.
	self assert: whenStepNode end equals: 236.

	thenStepNode := stepNodes third.
	self assert: thenStepNode class equals: HeraThenAstNode.
	self assert: thenStepNode description equals: 'the response Content-Type is:'.
	self assert: thenStepNode argument class equals: HeraDocStringStepArgumentAstNode.
	self assert: thenStepNode argument docString equals: (HeraDocString new lines: { 
		'application/json' }).
	self assert: thenStepNode start equals: 241.
	self assert: thenStepNode end equals: 308.

	andStepNode := stepNodes fourth.
	self assert: andStepNode class equals: HeraAndAstNode.
	self assert: andStepNode description equals: 'the API responds with:'.
	self assert: andStepNode argument class equals: HeraDocStringStepArgumentAstNode.
	self assert: andStepNode argument docString equals: (HeraDocString new string: '<users>
	<user>
		<name>John</name>
		<email>john@testing.org</email>
	</user>
	<user>
		<name>Jane</name>
		<email>jane@testing.org</email>
	</user>
</users>').
	self assert: andStepNode start equals: 313.
	self assert: andStepNode end equals: 553.

	butStepNode := stepNodes fifth.
	self assert: butStepNode class equals: HeraButAstNode.
	self assert: butStepNode description equals: 'the status code is:'.
	self assert: butStepNode argument class equals: HeraDocStringStepArgumentAstNode.
	self assert: butStepNode argument docString equals: (HeraDocString new lines: { 
		'200 OK' }).
	self assert: butStepNode start equals: 558.
	self assert: butStepNode end equals: 604
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseDocStringWithLessIndentationIsNotAllowed [

	self
		assertError: 'Inconsistent indentation of doc string'
		start: 164
		end: 204
		whenParsing: '
			Feature: REST API for users

				Scenario: GET users
					When the API receives a GET request https://testing.org/users
					Then the API responds with:
						"""
					<users>
						</users>
						"""'
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseDocStringWithMissingClosingTripleQuotes [

	self
		assertError: 'Doc string is not closed with """'
		start: 164
		end: 202
		whenParsing: '
			Feature: REST API for users

				Scenario: GET users
					When the API receives a GET request https://testing.org/users
					Then the API responds with:
						"""
						<users>
						</users>
						'
]

{ #category : 'tests' }
HeraParserTestCase >> testParseDocStringWithMoreIndentationIsAllowed [

	| script |
	script := '
	Feature: REST API for users

		Scenario: GET users
			Given the following users:
				| Name  | Email |
				| John  | john@testing.org |
				| Jane  | jane@testing.org |
			When the API receives a GET request https://testing.org/users
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
	self assert: (self parseFeature: script) isNotNil
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseDocStringWithTextAfterClosingTripleQuotes [

	self
		assertError: 'Text after """ is not allowed'
		start: 206
		end: 215
		whenParsing: '
			Feature: REST API for users

				Scenario: GET users
					When the API receives a GET request https://testing.org/users
					Then the API responds with:
						"""
						<users>
						</users>
						""" something'
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseDocStringWithTextAfterOpeningTripleQuotes [

	self
		assertError: 'Text after """ is not allowed'
		start: 167
		end: 173
		whenParsing: '
			Feature: REST API for users

				Scenario: GET users
					When the API receives a GET request https://testing.org/users
					Then the API responds with:
						"""<users>
						</users>
						"""'
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseDocStringWithTextBeforeOpeningTripleQuotes [

	self
		assertError: 'Step, step argument, or scenario expected'
		start: 164
		end: 176
		whenParsing: '
			Feature: REST API for users

				Scenario: GET users
					When the API receives a GET request https://testing.org/users
					Then the API responds with:
						something """
						"""'
]

{ #category : 'tests' }
HeraParserTestCase >> testParseEmptyFeature [

	| script ast |
	script := 'Feature: Signing in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'Signing in'.
	self assert: ast title start equals: 10.
	self assert: ast title end equals: 19.
	self assert: ast description isNil
]

{ #category : 'tests' }
HeraParserTestCase >> testParseFeatureWithBackgroundAndTaggedScenario [

	| script ast scenarioNode backgroundSteps backgroundStepNode |
	script := '
	Feature: Signing in

	Background:
		Given I am a user

	@successful_sign_in
	Scenario: Successful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'Signing in'.
	self assert: ast description isNil.
	self assert: ast background class equals: HeraBackgroundAstNode.
	backgroundSteps := ast background steps.
	self assert: backgroundSteps size equals: 1.
	backgroundStepNode := backgroundSteps first.
	self assert: backgroundStepNode class equals: HeraGivenAstNode.
	self assert: backgroundStepNode description equals: 'I am a user'.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title class equals: HeraTitleAstNode.
	self assert: scenarioNode title text equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests' }
HeraParserTestCase >> testParseFeatureWithDescription [

	| script ast scenarioNode |
	script := '
	Feature: Signing in

		Signing in is required to have access to the application.

		Signing in requires credentials: an email address and a password.

		Scenario: Successful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'Signing in'.
	self assert: ast description class equals: HeraDescriptionAstNode.
	self assert: ast description lines equals: (OrderedCollection with: 'Signing in is required to have access to the application.' with: '' with: 'Signing in requires credentials: an email address and a password.').
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title class equals: HeraTitleAstNode.
	self assert: scenarioNode title text equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests' }
HeraParserTestCase >> testParseFeatureWithEmptyBackground [

	| script ast |
	script := '
	Feature: Signing in

		Background:

		Scenario: Successful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'Signing in'.
	self assert: ast description isNil.
	self assert: ast background class equals: HeraBackgroundAstNode.
	self assert: ast background steps isEmpty.
	self assert: ast scenarios size equals: 1.
	self assert: ast scenarios first steps isEmpty
]

{ #category : 'tests' }
HeraParserTestCase >> testParseFeatureWithEmptyBackgroundAtTheEnd [

	| script ast |
	script := '
	Feature: Signing in

	Background:'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'Signing in'.
	self assert: ast description isNil.
	self assert: ast background class equals: HeraBackgroundAstNode.
	self assert: ast background steps isEmpty.
	self assert: ast scenarios isEmpty
]

{ #category : 'tests' }
HeraParserTestCase >> testParseFeatureWithEmptyLinesInBackground [

	| script ast backgroundSteps |
	script := '
	Feature: Signing in
		Background:

			Given I am an administrator

			And my account is active

		Scenario: Successful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'Signing in'.
	self assert: ast description isNil.
	self assert: ast background class equals: HeraBackgroundAstNode.
	backgroundSteps := ast background steps.
	self assert: backgroundSteps size equals: 2.
	self assert: backgroundSteps first class equals: HeraGivenAstNode.
	self assert: backgroundSteps first description equals: 'I am an administrator'.
	self assert: backgroundSteps second class equals: HeraAndAstNode.
	self assert: backgroundSteps second description equals: 'my account is active'.
	self assert: ast scenarios size equals: 1.
	self assert: ast scenarios first steps isEmpty
]

{ #category : 'tests' }
HeraParserTestCase >> testParseFeatureWithEmptyScenario [

	| script ast scenarioNode |
	script := '
	Feature: Signing in

		Scenario: Successful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'Signing in'.
	self assert: ast description isNil.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title class equals: HeraTitleAstNode.
	self assert: scenarioNode title text equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests' }
HeraParserTestCase >> testParseFeatureWithKeywordAsFirstWordInName [

	| script ast scenarioNode |
	script := '
	Feature: But is allowed at the beginning of a feature name

		Scenario: Signing in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast tags isEmpty.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'But is allowed at the beginning of a feature name'.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode tags isEmpty.
	self assert: scenarioNode title class equals: HeraTitleAstNode.
	self assert: scenarioNode title text equals: 'Signing in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests' }
HeraParserTestCase >> testParseFeatureWithRules [

	| script ast firstScenarioNode stepNode backgroundNode givenNode firstRule secondRule secondScenarioNode |
	script := '
	Feature: User management
		Managing users is essential to permit and revoke access to the system.

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
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast tags isEmpty.
	self assert: ast description class equals: HeraDescriptionAstNode.
	self assert: ast description lines equals: (OrderedCollection with: 'Managing users is essential to permit and revoke access to the system.').

	self assert: ast rules size equals: 2.
	firstRule := ast rules first.
	self assert: firstRule class equals: HeraRuleAstNode.
	self assert: firstRule title text equals: 'Only administrators are allowed to manage users'.

	backgroundNode := firstRule background.
	self assert: backgroundNode class equals: HeraBackgroundAstNode.
	self assert: backgroundNode steps size equals: 1.
	givenNode := backgroundNode steps first.
	self assert: givenNode class equals: HeraGivenAstNode.
	self assert: givenNode description equals: 'I am an administrator'.

	self assert: firstRule scenarios size equals: 2.
	firstScenarioNode := firstRule scenarios first.
	self assert: firstScenarioNode class equals: HeraScenarioAstNode.
	self assert: firstScenarioNode title text equals: 'Adding a user'.
	self assert: firstScenarioNode steps size equals: 3.
	stepNode := firstScenarioNode steps first.
	self assert: stepNode class equals: HeraWhenAstNode.
	self assert: stepNode description equals: 'I open the user management page'.
	stepNode := firstScenarioNode steps second.
	self assert: stepNode class equals: HeraAndAstNode.
	self assert: stepNode description equals: 'I add a new user'.
	stepNode := firstScenarioNode steps third.
	self assert: stepNode class equals: HeraThenAstNode.
	self assert: stepNode description equals: 'the new user can sign in'.

	secondScenarioNode := firstRule scenarios second.
	self assert: secondScenarioNode class equals: HeraScenarioAstNode.
	self assert: secondScenarioNode title text equals: 'Removing a user'.
	self assert: secondScenarioNode steps size equals: 3.
	stepNode := firstScenarioNode steps first.
	self assert: stepNode class equals: HeraWhenAstNode.
	self assert: stepNode description equals: 'I open the user management page'.
	stepNode := secondScenarioNode steps second.
	self assert: stepNode class equals: HeraAndAstNode.
	self assert: stepNode description equals: 'I remove a user'.
	stepNode := secondScenarioNode steps third.
	self assert: stepNode class equals: HeraThenAstNode.
	self assert: stepNode description equals: 'the removed user cannot sign in anymore'.

	secondRule := ast rules second.
	self assert: secondRule scenarios size equals: 1.
	self assert: secondRule class equals: HeraRuleAstNode.
	self assert: secondRule title text equals: 'Non-administrators have no access to user management'.
	self assert: secondRule background isNil.

	firstScenarioNode := secondRule scenarios first.
	self assert: firstScenarioNode class equals: HeraScenarioAstNode.
	self assert: firstScenarioNode title text equals: 'No access to user management'.
	self assert: firstScenarioNode steps size equals: 2.
	stepNode := firstScenarioNode steps first.
	self assert: stepNode class equals: HeraGivenAstNode.
	self assert: stepNode description equals: 'I am not an administrator'.
	stepNode := firstScenarioNode steps second.
	self assert: stepNode class equals: HeraThenAstNode.
	self assert: stepNode description equals: 'I cannot open the user management page'
]

{ #category : 'tests' }
HeraParserTestCase >> testParseFeatureWithStarSteps [

	| script ast scenarioNode stepNode |
	script := '
	Feature: With * steps

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I open the sign-in page
		* I fill in my user name
		* I fill in my password
		* I press the sign-in button
		Then I see the home page'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast tags isEmpty.
	self assert: ast description isNil.
	self assert: ast background isNil.
	
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title text equals: 'Successful sign-in'.
	self assert: scenarioNode steps size equals: 6.
	stepNode := scenarioNode steps first.
	self assert: stepNode class equals: HeraGivenAstNode.
	self assert: stepNode description equals: 'I have credentials to sign in'.
	stepNode := scenarioNode steps second.
	self assert: stepNode class equals: HeraWhenAstNode.
	self assert: stepNode description equals: 'I open the sign-in page'.
	stepNode := scenarioNode steps third.
	self assert: stepNode class equals: HeraStarAstNode.
	self assert: stepNode description equals: 'I fill in my user name'.
	stepNode := scenarioNode steps fourth.
	self assert: stepNode class equals: HeraStarAstNode.
	self assert: stepNode description equals: 'I fill in my password'.
	stepNode := scenarioNode steps fifth.
	self assert: stepNode class equals: HeraStarAstNode.
	self assert: stepNode description equals: 'I press the sign-in button'.
	stepNode := scenarioNode steps sixth.
	self assert: stepNode class equals: HeraThenAstNode.
	self assert: stepNode description equals: 'I see the home page'
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseFeatureWithStepButNoScenario [

	self
		assertError: 'Scenario keyword expected'
		start: 30
		end: 34
		whenParsing: '
			Feature: Signing in

				Given I have credentials to sign in'
]

{ #category : 'tests' }
HeraParserTestCase >> testParseFeatureWithTags [

	| script ast scenarioNode |
	script := '
	@accessing_the_system
	@signing_in
	Feature: Signing in

		Scenario: Successful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast tags size equals: 2.
	self assert: ast tags first class equals: HeraTagAstNode.
	self assert: ast tags first name equals: 'accessing_the_system'.
	self assert: ast tags second class equals: HeraTagAstNode.
	self assert: ast tags second name equals: 'signing_in'.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'Signing in'.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title text equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests' }
HeraParserTestCase >> testParseFeatureWithTwoEmptyScenarios [

	| script ast scenarioNode |
	script := '
	Feature: Signing in

		Scenario: Successful sign-in

		Scenario: Unsuccessful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'Signing in'.
	self assert: ast description isNil.
	self assert: ast scenarios size equals: 2.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title class equals: HeraTitleAstNode.
	self assert: scenarioNode title text equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty.
	scenarioNode := ast scenarios second.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title class equals: HeraTitleAstNode.
	self assert: scenarioNode title text equals: 'Unsuccessful sign-in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseFeatureWithoutFeatureKeyword [

	self
		assertError: 'Feature keyword expected'
		start: 1
		end: 9
		whenParsing: 'Scenario: Successful sign-in'
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseFeatureWithoutName [

	self
		assertError: 'Feature name expected after feature keyword'
		start: 5
		end: 12
		whenParsing: '
			Feature:

				Scenario: Successful sign-in'
]

{ #category : 'tests' }
HeraParserTestCase >> testParseFullFeature [

	| script ast scenarioNode stepNode backgroundNode givenNode |
	script := '
	@accessing_the_system
	@signing_in
	Feature: Signing in

		Signing in is required to have access to the application.
		Signing in requires credentials: an email address and a password.
		
		Background:
			Given I have credentials to sign in

		Scenario: Successful sign-in
			
			When I enter my credentials
			And I press the button to sign in
			Then I see the home page'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast tags size equals: 2.
	self assert: ast tags first class equals: HeraTagAstNode.
	self assert: ast tags first name equals: 'accessing_the_system'.
	self assert: ast tags second class equals: HeraTagAstNode.
	self assert: ast tags second name equals: 'signing_in'.
	self assert: ast description class equals: HeraDescriptionAstNode.
	self assert: ast description lines equals: (OrderedCollection with: 'Signing in is required to have access to the application.' with: 'Signing in requires credentials: an email address and a password.').

	backgroundNode := ast background.
	self assert: backgroundNode class equals: HeraBackgroundAstNode.
	self assert: backgroundNode steps size equals: 1.
	givenNode := backgroundNode steps first.
	self assert: givenNode class equals: HeraGivenAstNode.
	self assert: givenNode description equals: 'I have credentials to sign in'.
	
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title text equals: 'Successful sign-in'.
	self assert: scenarioNode steps size equals: 3.
	stepNode := scenarioNode steps first.
	self assert: stepNode class equals: HeraWhenAstNode.
	self assert: stepNode description equals: 'I enter my credentials'.
	stepNode := scenarioNode steps second.
	self assert: stepNode class equals: HeraAndAstNode.
	self assert: stepNode description equals: 'I press the button to sign in'.
	stepNode := scenarioNode steps third.
	self assert: stepNode class equals: HeraThenAstNode.
	self assert: stepNode description equals: 'I see the home page'
]

{ #category : 'tests' }
HeraParserTestCase >> testParseScenarioWithAndKeywordAsFirstWordInTitle [

	| script ast |
	script := '
	Feature: Signing in

		Scenario: And is allowed at the beginning of a scenario title'.
	ast := self parseFeature: script.
	self assert: ast scenarios first title text equals: 'And is allowed at the beginning of a scenario title'
]

{ #category : 'tests' }
HeraParserTestCase >> testParseScenarioWithButKeywordAsFirstWordInTitle [

	| script ast |
	script := '
	Feature: Signing in

		Scenario: But is allowed at the beginning of a scenario title'.
	ast := self parseFeature: script.
	self assert: ast scenarios first title text equals: 'But is allowed at the beginning of a scenario title'
]

{ #category : 'tests' }
HeraParserTestCase >> testParseScenarioWithDescription [

	| script ast scenarioNode |
	script := '
	Feature: Signing in

		@accessing_the_system
		@signing_in
		Scenario: Successful sign-in

			Access is allowed when the credentials are recognized.'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast tags isEmpty.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'Signing in'.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode tags size equals: 2.
	self assert: scenarioNode tags first class equals: HeraTagAstNode.
	self assert: scenarioNode tags first name equals: 'accessing_the_system'.
	self assert: scenarioNode tags second class equals: HeraTagAstNode.
	self assert: scenarioNode tags second name equals: 'signing_in'.
	self assert: scenarioNode title class equals: HeraTitleAstNode.
	self assert: scenarioNode title text equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty.
	self assert: scenarioNode description class equals: HeraDescriptionAstNode.
	self assert: scenarioNode description lines equals: (
		OrderedCollection with: 'Access is allowed when the credentials are recognized.')
]

{ #category : 'tests' }
HeraParserTestCase >> testParseScenarioWithGivenKeywordAsFirstWordInTitle [

	| script ast title |
	script := '
	Feature: Signing in

		Scenario: Given is allowed at the beginning of a scenario title'.
	ast := self parseFeature: script.
	title := ast scenarios first title.
	self assert: title class equals: HeraTitleAstNode.
	self assert: title text equals: 'Given is allowed at the beginning of a scenario title'
]

{ #category : 'tests' }
HeraParserTestCase >> testParseScenarioWithTags [

	| script ast scenarioNode title |
	script := '
	Feature: Signing in

		@accessing_the_system
		@signing_in
		Scenario: Successful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast tags isEmpty.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'Signing in'.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode tags size equals: 2.
	self assert: scenarioNode tags first class equals: HeraTagAstNode.
	self assert: scenarioNode tags first name equals: 'accessing_the_system'.
	self assert: scenarioNode tags second class equals: HeraTagAstNode.
	self assert: scenarioNode tags second name equals: 'signing_in'.
	title := ast scenarios first title.
	self assert: title class equals: HeraTitleAstNode.
	self assert: title text equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests' }
HeraParserTestCase >> testParseScenarioWithThenKeywordAsFirstWordInTitle [

	| script ast title |
	script := '
	Feature: Signing in

		Scenario: Then is allowed at the beginning of a scenario title'.
	ast := self parseFeature: script.
	title := ast scenarios first title.
	self assert: title class equals: HeraTitleAstNode.
	self assert: title text equals: 'Then is allowed at the beginning of a scenario title'.
]

{ #category : 'tests' }
HeraParserTestCase >> testParseScenarioWithWhenKeywordAsFirstWordInTitle [

	| script ast title |
	script := '
	Feature: Signing in

		Scenario: When is allowed at the beginning of a scenario title'.
	ast := self parseFeature: script.
	title := ast scenarios first title.
	self assert: title class equals: HeraTitleAstNode.
	self assert: title text equals: 'When is allowed at the beginning of a scenario title'
]

{ #category : 'tests' }
HeraParserTestCase >> testParseScenarioWithoutTags [

	| script ast scenarioNode  |
	script := '
	Feature: Signing in

		Scenario: Successful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast tags isEmpty.
	self assert: ast title class equals: HeraTitleAstNode.
	self assert: ast title text equals: 'Signing in'.
	self assert: ast title start equals: 12.
	self assert: ast title end equals: 21.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode tags isEmpty.
	self assert: scenarioNode title class equals: HeraTitleAstNode.
	self assert: scenarioNode title text equals: 'Successful sign-in'.
	self assert: scenarioNode title start equals: 36.
	self assert: scenarioNode title end equals: 53.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseScenarioWithoutTitle [

	self
		assertError: 'Scenario title expected after scenario keyword'
		start: 30
		end: 38
		whenParsing: '
			Feature: Signing in

				Scenario:  '
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseWrongFeatureKeywordAfterTag [

	self
		assertError: 'Feature keyword expected'
		start: 20
		end: 43
		whenParsing: '
			@signing_in
			FeatureBogus: Signing in'
]

{ #category : 'tests - parsing errors' }
HeraParserTestCase >> testParseWrongScenarioKeywordAfterTag [

	self
		assertError: 'Scenario keyword expected'
		start: 43
		end: 75
		whenParsing: '
			Feature: Signing in

				@sign_in
				ScenarioBogus: Successful sing-in'
]
