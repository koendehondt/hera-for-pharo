Class {
	#name : 'HeraScriptGeneratorTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Generation',
	#package : 'Hera-Tests',
	#tag : 'Generation'
}

{ #category : 'running' }
HeraScriptGeneratorTestCase >> describedClass [

	^ HeraScriptGenerator
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScript [

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

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithBackground [

	^ (Text fromString: 'Feature: With background

	Background:
		Given I have a user name
		And a password
		But no email

	Scenario: Successful sign-in
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

	Scenario: Unsuccessful sign-in
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong

')
	makeBoldFrom: 1 to: 8;
	makeColor: (Color fromHexString: 'CF222E') from: 1 to: 8;
	makeColor: (Color fromHexString: '0A3069') from: 10 to: 24;
	makeBoldFrom: 28 to: 38;
	makeColor: (Color fromHexString: 'CF222E') from: 28 to: 38;
	makeColor: (Color fromHexString: 'CF222E') from: 42 to: 46;
	makeColor: (Color fromHexString: 'CF222E') from: 69 to: 71;
	makeColor: (Color fromHexString: 'CF222E') from: 86 to: 88;
	makeBoldFrom: 101 to: 109;
	makeColor: (Color fromHexString: 'CF222E') from: 101 to: 109;
	makeColor: (Color fromHexString: '0A3069') from: 111 to: 128;
	makeColor: (Color fromHexString: 'CF222E') from: 132 to: 135;
	makeColor: (Color fromHexString: 'CF222E') from: 162 to: 164;
	makeColor: (Color fromHexString: 'CF222E') from: 198 to: 201;
	makeBoldFrom: 225 to: 233;
	makeColor: (Color fromHexString: 'CF222E') from: 225 to: 233;
	makeColor: (Color fromHexString: '0A3069') from: 235 to: 254;
	makeColor: (Color fromHexString: 'CF222E') from: 258 to: 261;
	makeColor: (Color fromHexString: 'CF222E') from: 295 to: 297;
	makeColor: (Color fromHexString: 'CF222E') from: 331 to: 334;
	makeColor: (Color fromHexString: 'CF222E') from: 369 to: 371;
	yourself
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithDataTable [

	^ (Text fromString: 'Feature: With data table

	Scenario: Listing users
		Given the following users exist:
			| Name | Email            |
			| John | john@testing.org |
			| Jane | jane@testing.org |
		When I add the following users:
			| Name | Email            |
			| Jake | jake@testing.org |
			| Emma | emma@testing.org |
		And I add the following users:
			| Name | Email            |
			| Jill | jill@testing.org |
		But I remove the following users:
			| Name | Email            |
			| Jake | jake@testing.org |
		Then I see exactly these users in the list:
			| Name | Email            |
			| John | john@testing.org |
			| Jane | jane@testing.org |
			| Emma | emma@testing.org |
			| Jill | jill@testing.org |
		* I see these users in the list:
			| Name | Email            |
			| Emma | emma@testing.org |
			| Jill | jill@testing.org |

')
	makeBoldFrom: 1 to: 8;
	makeColor: (Color fromHexString: 'CF222E') from: 1 to: 8;
	makeColor: (Color fromHexString: '0A3069') from: 10 to: 24;
	makeBoldFrom: 28 to: 36;
	makeColor: (Color fromHexString: 'CF222E') from: 28 to: 36;
	makeColor: (Color fromHexString: '0A3069') from: 38 to: 50;
	makeColor: (Color fromHexString: 'CF222E') from: 54 to: 58;
	makeColor: (Color fromHexString: '8250DF') from: 87 to: 178;
	makeColor: (Color fromHexString: 'CF222E') from: 182 to: 185;
	makeColor: (Color fromHexString: '8250DF') from: 214 to: 305;
	makeColor: (Color fromHexString: 'CF222E') from: 309 to: 311;
	makeColor: (Color fromHexString: '8250DF') from: 340 to: 400;
	makeColor: (Color fromHexString: 'CF222E') from: 404 to: 406;
	makeColor: (Color fromHexString: '8250DF') from: 438 to: 498;
	makeColor: (Color fromHexString: 'CF222E') from: 502 to: 505;
	makeColor: (Color fromHexString: '8250DF') from: 546 to: 699;
	makeColor: (Color fromHexString: 'CF222E') from: 703 to: 703;
	makeColor: (Color fromHexString: '8250DF') from: 736 to: 827;
	yourself
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithDescriptionInBackground [

	^ (Text fromString: 'Feature: With description in background

	Background:

		Signing in is required for all other functionality

		Given I have a user name
		And a password
		But no email

	Scenario: Successful sign-in
		When I enter my credentials
		And I press the button to sign in
		Then I see the home page

	Scenario: Unsuccessful sign-in
		When I enter the wrong credentials
		And I press the button to sign in
		Then I am still on the sign-in page
		But I see a message that the credentials are wrong

')
	makeBoldFrom: 1 to: 8;
	makeColor: (Color fromHexString: 'CF222E') from: 1 to: 8;
	makeColor: (Color fromHexString: '0A3069') from: 10 to: 39;
	makeBoldFrom: 43 to: 53;
	makeColor: (Color fromHexString: 'CF222E') from: 43 to: 53;
	makeColor: (Color fromHexString: 'CF222E') from: 112 to: 116;
	makeColor: (Color fromHexString: 'CF222E') from: 139 to: 141;
	makeColor: (Color fromHexString: 'CF222E') from: 156 to: 158;
	makeBoldFrom: 171 to: 179;
	makeColor: (Color fromHexString: 'CF222E') from: 171 to: 179;
	makeColor: (Color fromHexString: '0A3069') from: 181 to: 198;
	makeColor: (Color fromHexString: 'CF222E') from: 202 to: 205;
	makeColor: (Color fromHexString: 'CF222E') from: 232 to: 234;
	makeColor: (Color fromHexString: 'CF222E') from: 268 to: 271;
	makeBoldFrom: 295 to: 303;
	makeColor: (Color fromHexString: 'CF222E') from: 295 to: 303;
	makeColor: (Color fromHexString: '0A3069') from: 305 to: 324;
	makeColor: (Color fromHexString: 'CF222E') from: 328 to: 331;
	makeColor: (Color fromHexString: 'CF222E') from: 365 to: 367;
	makeColor: (Color fromHexString: 'CF222E') from: 401 to: 404;
	makeColor: (Color fromHexString: 'CF222E') from: 439 to: 441;
	yourself
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithDocString [

	^ (Text fromString: 'Feature: With doc string

	Scenario: Listing users
		Given the following users exist:
			| Name | Email            |
			| John | john@testing.org |
			| Jane | jane@testing.org |
		When the API receives a GET request "https://testing.org/users"
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
			"""

')
	makeBoldFrom: 1 to: 8;
	makeColor: (Color fromHexString: 'CF222E') from: 1 to: 8;
	makeColor: (Color fromHexString: '0A3069') from: 10 to: 24;
	makeBoldFrom: 28 to: 36;
	makeColor: (Color fromHexString: 'CF222E') from: 28 to: 36;
	makeColor: (Color fromHexString: '0A3069') from: 38 to: 50;
	makeColor: (Color fromHexString: 'CF222E') from: 54 to: 58;
	makeColor: (Color fromHexString: '8250DF') from: 87 to: 178;
	makeColor: (Color fromHexString: 'CF222E') from: 182 to: 185;
	makeColor: (Color fromHexString: 'CF222E') from: 248 to: 251;
	makeColor: (Color fromHexString: '8250DF') from: 276 to: 477;
	yourself
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithEmptyDocString [

	^ (Text fromString: 'Feature: With empty doc string

	Scenario: Empty doc strings are accepted
		Given the following empty doc string:
			"""
			"""

')
	makeBoldFrom: 1 to: 8;
	makeColor: (Color fromHexString: 'CF222E') from: 1 to: 8;
	makeColor: (Color fromHexString: '0A3069') from: 10 to: 30;
	makeBoldFrom: 34 to: 42;
	makeColor: (Color fromHexString: 'CF222E') from: 34 to: 42;
	makeColor: (Color fromHexString: '0A3069') from: 44 to: 73;
	makeColor: (Color fromHexString: 'CF222E') from: 77 to: 81;
	makeColor: (Color fromHexString: '8250DF') from: 115 to: 127;
	yourself
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithRules [

	^ (Text fromString: 'Feature: With rules

	Managing users is essential to permit and revoke access to the system.

	Background:
		Given an administrator user and a non-administrator user exist

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
			Then I cannot open the user management page

')
	makeBoldFrom: 1 to: 8;
	makeColor: (Color fromHexString: 'CF222E') from: 1 to: 8;
	makeColor: (Color fromHexString: '0A3069') from: 10 to: 19;
	makeBoldFrom: 96 to: 106;
	makeColor: (Color fromHexString: 'CF222E') from: 96 to: 106;
	makeColor: (Color fromHexString: 'CF222E') from: 110 to: 114;
	makeBoldFrom: 175 to: 183;
	makeColor: (Color fromHexString: 'CF222E') from: 175 to: 183;
	makeColor: (Color fromHexString: '0A3069') from: 185 to: 241;
	makeColor: (Color fromHexString: 'CF222E') from: 245 to: 249;
	makeColor: (Color fromHexString: 'CF222E') from: 275 to: 278;
	makeBoldFrom: 296 to: 300;
	makeColor: (Color fromHexString: 'CF222E') from: 296 to: 300;
	makeColor: (Color fromHexString: '0A3069') from: 302 to: 348;
	makeBoldFrom: 430 to: 440;
	makeColor: (Color fromHexString: 'CF222E') from: 430 to: 440;
	makeColor: (Color fromHexString: 'CF222E') from: 445 to: 449;
	makeBoldFrom: 476 to: 484;
	makeColor: (Color fromHexString: 'CF222E') from: 476 to: 484;
	makeColor: (Color fromHexString: '0A3069') from: 486 to: 498;
	makeColor: (Color fromHexString: 'CF222E') from: 503 to: 506;
	makeColor: (Color fromHexString: 'CF222E') from: 543 to: 545;
	makeColor: (Color fromHexString: 'CF222E') from: 567 to: 570;
	makeBoldFrom: 600 to: 608;
	makeColor: (Color fromHexString: 'CF222E') from: 600 to: 608;
	makeColor: (Color fromHexString: '0A3069') from: 610 to: 624;
	makeColor: (Color fromHexString: 'CF222E') from: 629 to: 632;
	makeColor: (Color fromHexString: 'CF222E') from: 669 to: 671;
	makeColor: (Color fromHexString: 'CF222E') from: 692 to: 695;
	makeBoldFrom: 739 to: 743;
	makeColor: (Color fromHexString: 'CF222E') from: 739 to: 743;
	makeColor: (Color fromHexString: '0A3069') from: 745 to: 796;
	makeBoldFrom: 801 to: 809;
	makeColor: (Color fromHexString: 'CF222E') from: 801 to: 809;
	makeColor: (Color fromHexString: '0A3069') from: 811 to: 838;
	makeColor: (Color fromHexString: 'CF222E') from: 843 to: 847;
	makeColor: (Color fromHexString: 'CF222E') from: 878 to: 881;
	yourself
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithScenarioOutline [

	^ (Text fromString: 'Feature: With scenario outline

	@counting_<fruit>
	@shop_<shop_name>
	Scenario Outline: Counting <fruit>

		Adding <fruit> is easy.

		Given I own <number> "<fruit>"
		When I buy <additional> "<fruit>"
		Then I have:
			| <sum> | <fruit> |
		And I receive a ticket:
			"""
			Your purchase at the Fruit Shop.
			
			<additional> <fruit>: <price>
			--------------------------------
			Total: <price>
			
			Thank you for your visit!
			"""
		And I see an overview of my purchases in the app:
			>  Today
			>>   Fruit Shop: <price>

		Examples:
			| fruit   | number | additional | sum | price |
			| apples  | 5      | 2          | 7   | 1.5 € |
			| oranges | 8      | 1          | 9   | 0.8 € |

')
	makeBoldFrom: 1 to: 8;
	makeColor: (Color fromHexString: 'CF222E') from: 1 to: 8;
	makeColor: (Color fromHexString: '0A3069') from: 10 to: 30;
	makeColor: (Color fromHexString: '116329') from: 34 to: 50;
	makeColor: (Color fromHexString: '116329') from: 53 to: 69;
	makeBoldFrom: 72 to: 88;
	makeColor: (Color fromHexString: 'CF222E') from: 72 to: 88;
	makeColor: (Color fromHexString: '0A3069') from: 90 to: 105;
	makeColor: (Color fromHexString: 'CF222E') from: 137 to: 141;
	makeColor: (Color fromHexString: 'CF222E') from: 170 to: 173;
	makeColor: (Color fromHexString: 'CF222E') from: 206 to: 209;
	makeColor: (Color fromHexString: '8250DF') from: 219 to: 240;
	makeColor: (Color fromHexString: 'CF222E') from: 244 to: 246;
	makeColor: (Color fromHexString: '8250DF') from: 268 to: 440;
	makeColor: (Color fromHexString: 'CF222E') from: 444 to: 446;
	makeColor: (Color fromHexString: '8250DF') from: 494 to: 532;
	makeBoldFrom: 537 to: 545;
	makeColor: (Color fromHexString: 'CF222E') from: 537 to: 545;
	makeColor: (Color fromHexString: '8250DF') from: 547 to: 698;
	yourself
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithScenarioOutlineWithEmptyExamples [

	^ (Text fromString: 'Feature: With scenario outline with empty examples

	@counting_fruit
	Scenario Outline: Counting <fruit>

		Adding is easy.

		Given I have <number> <fruit>
		When I buy <additional> <fruit>
		Then I have <sum> <fruit>

		Examples:

')
	makeBoldFrom: 1 to: 8;
	makeColor: (Color fromHexString: 'CF222E') from: 1 to: 8;
	makeColor: (Color fromHexString: '0A3069') from: 10 to: 50;
	makeColor: (Color fromHexString: '116329') from: 54 to: 68;
	makeBoldFrom: 71 to: 87;
	makeColor: (Color fromHexString: 'CF222E') from: 71 to: 87;
	makeColor: (Color fromHexString: '0A3069') from: 89 to: 104;
	makeColor: (Color fromHexString: 'CF222E') from: 128 to: 132;
	makeColor: (Color fromHexString: 'CF222E') from: 160 to: 163;
	makeColor: (Color fromHexString: 'CF222E') from: 194 to: 197;
	makeBoldFrom: 223 to: 231;
	makeColor: (Color fromHexString: 'CF222E') from: 223 to: 231;
	yourself
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithScenarioOutlineWithoutExamples [

	^ (Text fromString: 'Feature: With scenario outline without examples

	@counting_fruit
	Scenario Outline: Counting <fruit>

		Adding is easy.

		Given I have <number> <fruit>
		When I buy <additional> <fruit>
		Then I have <sum> <fruit>

')
	makeBoldFrom: 1 to: 8;
	makeColor: (Color fromHexString: 'CF222E') from: 1 to: 8;
	makeColor: (Color fromHexString: '0A3069') from: 10 to: 47;
	makeColor: (Color fromHexString: '116329') from: 51 to: 65;
	makeBoldFrom: 68 to: 84;
	makeColor: (Color fromHexString: 'CF222E') from: 68 to: 84;
	makeColor: (Color fromHexString: '0A3069') from: 86 to: 101;
	makeColor: (Color fromHexString: 'CF222E') from: 125 to: 129;
	makeColor: (Color fromHexString: 'CF222E') from: 157 to: 160;
	makeColor: (Color fromHexString: 'CF222E') from: 191 to: 194;
	yourself
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithStarSteps [

	^ (Text fromString: 'Feature: With * steps

	Scenario: Successful sign-in
		Given I have credentials to sign in
		When I open the sign-in page
		* I fill in my user name
		* I fill in my password
		* I press the sign-in button
		Then I see the home page

')
	makeBoldFrom: 1 to: 8;
	makeColor: (Color fromHexString: 'CF222E') from: 1 to: 8;
	makeColor: (Color fromHexString: '0A3069') from: 10 to: 21;
	makeBoldFrom: 25 to: 33;
	makeColor: (Color fromHexString: 'CF222E') from: 25 to: 33;
	makeColor: (Color fromHexString: '0A3069') from: 35 to: 52;
	makeColor: (Color fromHexString: 'CF222E') from: 56 to: 60;
	makeColor: (Color fromHexString: 'CF222E') from: 94 to: 97;
	makeColor: (Color fromHexString: 'CF222E') from: 125 to: 125;
	makeColor: (Color fromHexString: 'CF222E') from: 152 to: 152;
	makeColor: (Color fromHexString: 'CF222E') from: 178 to: 178;
	makeColor: (Color fromHexString: 'CF222E') from: 209 to: 212;
	yourself
]

{ #category : 'private' }
HeraScriptGeneratorTestCase >> expectedGeneratedScriptWithTags [

	^ (Text fromString: '@tag_feature_two
Feature: Two

	@tag_scenario_2A
	Scenario: 2A
		When I do something
		Then I see something

	@tag_scenario_2B
	Scenario: 2B
		When I do something
		Then I see something

	@tag_rule_R
	Rule: R

		@tag_scenario_RA
		Scenario: RA
			When I do something
			Then I see something

		Scenario: RB
			When I do something
			Then I see something

')
	makeColor: (Color fromHexString: '116329') from: 1 to: 16;
	makeBoldFrom: 18 to: 25;
	makeColor: (Color fromHexString: 'CF222E') from: 18 to: 25;
	makeColor: (Color fromHexString: '0A3069') from: 27 to: 29;
	makeColor: (Color fromHexString: '116329') from: 33 to: 48;
	makeBoldFrom: 51 to: 59;
	makeColor: (Color fromHexString: 'CF222E') from: 51 to: 59;
	makeColor: (Color fromHexString: '0A3069') from: 61 to: 62;
	makeColor: (Color fromHexString: 'CF222E') from: 66 to: 69;
	makeColor: (Color fromHexString: 'CF222E') from: 88 to: 91;
	makeColor: (Color fromHexString: '116329') from: 111 to: 126;
	makeBoldFrom: 129 to: 137;
	makeColor: (Color fromHexString: 'CF222E') from: 129 to: 137;
	makeColor: (Color fromHexString: '0A3069') from: 139 to: 140;
	makeColor: (Color fromHexString: 'CF222E') from: 144 to: 147;
	makeColor: (Color fromHexString: 'CF222E') from: 166 to: 169;
	makeColor: (Color fromHexString: '116329') from: 189 to: 199;
	makeBoldFrom: 202 to: 206;
	makeColor: (Color fromHexString: 'CF222E') from: 202 to: 206;
	makeColor: (Color fromHexString: '0A3069') from: 208 to: 208;
	makeColor: (Color fromHexString: '116329') from: 213 to: 228;
	makeBoldFrom: 232 to: 240;
	makeColor: (Color fromHexString: 'CF222E') from: 232 to: 240;
	makeColor: (Color fromHexString: '0A3069') from: 242 to: 243;
	makeColor: (Color fromHexString: 'CF222E') from: 248 to: 251;
	makeColor: (Color fromHexString: 'CF222E') from: 271 to: 274;
	makeBoldFrom: 295 to: 303;
	makeColor: (Color fromHexString: 'CF222E') from: 295 to: 303;
	makeColor: (Color fromHexString: '0A3069') from: 305 to: 306;
	makeColor: (Color fromHexString: 'CF222E') from: 311 to: 314;
	makeColor: (Color fromHexString: 'CF222E') from: 334 to: 337;
	yourself
]

{ #category : 'running' }
HeraScriptGeneratorTestCase >> initializeSubject [

	super initializeSubject.
	subject syntaxTheme: HeraSyntaxLightTheme new
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScript [

	| feature |
	feature := HeraAcceptanceTestWithPassForTesting new signingInFeature.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScript
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithBackground [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithBackground.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithBackground
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithDataTable [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithDataTable.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithDataTable
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithDescriptionInBackground [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithDescriptionInBackground.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithDescriptionInBackground
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithDocString [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithDocString.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithDocString
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithEmptyDocString [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithEmptyDocString.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithEmptyDocString
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithRules [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithRules.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithRules
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithScenarioOutline [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithScenarioOutline.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithScenarioOutline
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithScenarioOutlineWithEmptyExamples [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithScenarioOutlineWithEmptyExamples.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithScenarioOutlineWithEmptyExamples
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithScenarioOutlineWithoutExamples [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithScenarioOutlineWithoutExamples.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithScenarioOutlineWithoutExamples
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithStarSteps [

	| feature |
	feature := HeraAcceptanceTestExamplesForTesting new featureWithStarSteps.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithStarSteps
]

{ #category : 'tests' }
HeraScriptGeneratorTestCase >> testGeneratedScriptWithTags [

	| feature |
	feature := HeraAcceptanceTestWithTwoFeaturesForTesting new featureTwo.
	subject visit: feature.
	self assertText: subject generatedScript equals: self expectedGeneratedScriptWithTags
]
