Class {
	#name : 'HeraGherkinParserTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Gherkin parser',
	#package : 'Hera-Tests',
	#tag : 'Gherkin parser'
}

{ #category : 'running' }
HeraGherkinParserTestCase >> describedClass [

	^ HeraGherkinParser
]

{ #category : 'helpers' }
HeraGherkinParserTestCase >> parseFeature: aScript [

	subject initializeParserWith: aScript.
	^ subject parseFeature
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testAstContainsTextPositions [

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
HeraGherkinParserTestCase >> testParseBackgroundWithNonGivenStep [

	| script |
	script := '
	Feature: Signing in

		Background:
			When I have credentials to sign in

		Scenario: Successful sign-in'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: 'This step is not allowed in Background:.'
]

{ #category : 'tests - parsing errors' }
HeraGherkinParserTestCase >> testParseBackgroundWithText [

	| script |
	script := '
	Feature: Signing in

		Background: credentials
			Given I have credentials to sign in

		Scenario: Successful sign-in'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: 'Text after Background: is not allowed.'
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testParseDataTable [

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
HeraGherkinParserTestCase >> testParseDataTableWithEmptyLine [

	| script |
	script := '
	Feature: User management

		Scenario: Listing users
			Given the following users exist:
				| Name | Email            |

				| Jane | jane@testing.org |
			Then I see them in the list of users'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: 'Empty lines in data tables are not allowed.'
]

{ #category : 'tests - parsing errors' }
HeraGherkinParserTestCase >> testParseDataTableWithMissingCell [

	| script |
	script := '
	Feature: User management

		Scenario: Listing users
			Given the following users exist:
				| Name | Email            |
				| John |
				| Jane | jane@testing.org |
			Then I see them in the list of users'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: 'Data table has missing cells.'
]

{ #category : 'tests - parsing errors' }
HeraGherkinParserTestCase >> testParseDataTableWithMissingTerminatingBar [

	| script |
	script := '
	Feature: User management

		Scenario: Listing users
			Given the following users exist:
				| Name | Email
				| John | john@testing.org |
				| Jane | jane@testing.org |
			Then I see them in the list of users'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: 'Data table row not closed with |.'
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testParseDataTableWithoutFormatting [

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
	self assert: ast name equals: 'User management'.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode tags isEmpty.
	self assert: scenarioNode title equals: 'Listing users'.
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
HeraGherkinParserTestCase >> testParseDocString [

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
HeraGherkinParserTestCase >> testParseDocStringWithLessIndentationIsNotAllowed [

	| script |
	script := '
	Feature: REST API for users

		Scenario: GET users
			When the API receives a GET request https://testing.org/users
			Then the API responds with:
				"""
			<users>
				</users>
				"""'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: 'Inconsistent indentation of doc string.'
]

{ #category : 'tests - parsing errors' }
HeraGherkinParserTestCase >> testParseDocStringWithMissingClosingTripleQuotes [

	| script |
	script := '
	Feature: REST API for users

		Scenario: GET users
			When the API receives a GET request https://testing.org/users
			Then the API responds with:
				"""
				<users>
				</users>
				'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: 'Doc string is not closed with """.'
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testParseDocStringWithMoreIndentationIsAllowed [

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
HeraGherkinParserTestCase >> testParseDocStringWithTextAfterClosingTripleQuotes [

	| script |
	script := '
	Feature: REST API for users

		Scenario: GET users
			When the API receives a GET request https://testing.org/users
			Then the API responds with:
				"""
				<users>
				</users>
				""" something'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: 'Text after """ is not allowed.'
]

{ #category : 'tests - parsing errors' }
HeraGherkinParserTestCase >> testParseDocStringWithTextAfterOpeningTripleQuotes [

	| script |
	script := '
	Feature: REST API for users

		Scenario: GET users
			When the API receives a GET request https://testing.org/users
			Then the API responds with:
				"""<users>
				</users>
				"""'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: 'Text after """ is not allowed.'
]

{ #category : 'tests - parsing errors' }
HeraGherkinParserTestCase >> testParseDocStringWithTextBeforeOpeningTripleQuotes [

	| script |
	script := '
	Feature: REST API for users

		Scenario: GET users
			When the API receives a GET request https://testing.org/users
			Then the API responds with:
				something """
				"""'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: 'Step, step argument, or scenario expected.'
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testParseEmptyFeature [

	| script ast |
	script := 'Feature: Signing in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast name equals: 'Signing in'.
	self assert: ast description isNil
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testParseFeatureWithDescription [

	| script ast scenarioNode |
	script := '
	Feature: Signing in

		Signing in is required to have access to the application.

		Signing in requires credentials: an email address and a password.

		Scenario: Successful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast name equals: 'Signing in'.
	self assert: ast description class equals: HeraDescriptionAstNode.
	self assert: ast description lines equals: (OrderedCollection with: 'Signing in is required to have access to the application.' with: '' with: 'Signing in requires credentials: an email address and a password.').
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testParseFeatureWithEmptyScenario [

	| script ast scenarioNode |
	script := '
	Feature: Signing in

		Scenario: Successful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast name equals: 'Signing in'.
	self assert: ast description isNil.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testParseFeatureWithStepButNoScenario [

	| script |
	script := '
	Feature: Signing in

		Given I have credentials to sign in'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: '"Scenario:" expected.'
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testParseFeatureWithTags [

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
	self assert: ast name equals: 'Signing in'.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testParseFeatureWithTwoEmptyScenarios [

	| script ast scenarioNode |
	script := '
	Feature: Signing in

		Scenario: Successful sign-in

		Scenario: Unsuccessful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast name equals: 'Signing in'.
	self assert: ast description isNil.
	self assert: ast scenarios size equals: 2.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty.
	scenarioNode := ast scenarios second.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode title equals: 'Unsuccessful sign-in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests - parsing errors' }
HeraGherkinParserTestCase >> testParseFeatureWithoutFeatureKeyword [

	| script |
	script := 'Scenario: Successful sign-in'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: '"Feature:" expected.'
]

{ #category : 'tests - parsing errors' }
HeraGherkinParserTestCase >> testParseFeatureWithoutName [

	| script |
	script := '
	Feature:

		Scenario: Successful sign-in'.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: 'Feature name expected.'
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testParseFullFeature [

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
	self assert: scenarioNode title equals: 'Successful sign-in'.
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
HeraGherkinParserTestCase >> testParseScenarioWithDescription [

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
	self assert: ast name equals: 'Signing in'.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode tags size equals: 2.
	self assert: scenarioNode tags first class equals: HeraTagAstNode.
	self assert: scenarioNode tags first name equals: 'accessing_the_system'.
	self assert: scenarioNode tags second class equals: HeraTagAstNode.
	self assert: scenarioNode tags second name equals: 'signing_in'.
	self assert: scenarioNode title equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty.
	self assert: scenarioNode description class equals: HeraDescriptionAstNode.
	self assert: scenarioNode description lines equals: (
		OrderedCollection with: 'Access is allowed when the credentials are recognized.')
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testParseScenarioWithTags [

	| script ast scenarioNode |
	script := '
	Feature: Signing in

		@accessing_the_system
		@signing_in
		Scenario: Successful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast tags isEmpty.
	self assert: ast name equals: 'Signing in'.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode tags size equals: 2.
	self assert: scenarioNode tags first class equals: HeraTagAstNode.
	self assert: scenarioNode tags first name equals: 'accessing_the_system'.
	self assert: scenarioNode tags second class equals: HeraTagAstNode.
	self assert: scenarioNode tags second name equals: 'signing_in'.
	self assert: scenarioNode title equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests' }
HeraGherkinParserTestCase >> testParseScenarioWithoutTags [

	| script ast scenarioNode |
	script := '
	Feature: Signing in

		Scenario: Successful sign-in'.
	ast := self parseFeature: script.
	self assert: ast class equals: HeraFeatureAstNode.
	self assert: ast tags isEmpty.
	self assert: ast name equals: 'Signing in'.
	self assert: ast scenarios size equals: 1.
	scenarioNode := ast scenarios first.
	self assert: scenarioNode class equals: HeraScenarioAstNode.
	self assert: scenarioNode tags isEmpty.
	self assert: scenarioNode title equals: 'Successful sign-in'.
	self assert: scenarioNode steps isEmpty
]

{ #category : 'tests - parsing errors' }
HeraGherkinParserTestCase >> testParseScenarioWithoutTitle [

	| script |
	script := '
	Feature: Signing in

		Scenario: '.
	self assert: (self parseFeature: script) isNil.
	self assert: subject parseError equals: 'Scenario title expected.'
]
