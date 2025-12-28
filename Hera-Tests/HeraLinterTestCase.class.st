Class {
	#name : 'HeraLinterTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Linter',
	#package : 'Hera-Tests',
	#tag : 'Linter'
}

{ #category : 'helpers' }
HeraLinterTestCase >> assertWarning: aString start: startInteger end: endInteger [

	| warning |
	warning := subject warnings
		detect: [ :each | each message = aString and: [ each start = startInteger and: [ each end = endInteger ] ]]
		ifNone: [ self fail: ('Warning not found: {1} [{2} - {3}]' format: { aString . startInteger . endInteger }) ]
]

{ #category : 'helpers' }
HeraLinterTestCase >> assertWarning: aString start: startInteger end: endInteger whenLinting: script [

	| warnings warning |
	self deny: (self lintFeature: script).
	warnings := subject warnings.
	self assert: warnings size equals: 1.
	warning := warnings first.
	self assert: warning message equals: aString.
	self assert: warning start equals: startInteger.
	self assert: warning end equals: endInteger
]

{ #category : 'running' }
HeraLinterTestCase >> describedClass [

	^ HeraLinter
]

{ #category : 'running' }
HeraLinterTestCase >> initializeSubject [

	super initializeSubject.
	subject acceptanceTest: HeraAcceptanceTest new
]

{ #category : 'helpers' }
HeraLinterTestCase >> lintFeature: aScript [

	| ast |
	ast := self parseFeature: aScript.
	^ subject lint: ast
]

{ #category : 'helpers' }
HeraLinterTestCase >> parseFeature: aScript [

	| parser |
	parser := HeraParser new initializeParserWith: aScript.
	^ parser parseFeature
]

{ #category : 'tests' }
HeraLinterTestCase >> testAndCannotBeTheFirstStep [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Signing in

			Scenario: An And step cannot be the first step in a scenario
				And I have credentials to sign in'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 2.
	self assertWarning: 'An And step should not be the first step in a scenario' start: 93 end: 125.
	self assertWarning: 'This step has no definition' start: 93 end: 125
]

{ #category : 'tests' }
HeraLinterTestCase >> testButCannotBeTheFirstStep [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Signing in

			Scenario: A But step cannot be the first step in a scenario
				But I do not have credentials to sign in'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 2.
	self assertWarning: 'A But step should not be the first step in a scenario' start: 92 end: 131.
	self assertWarning: 'This step has no definition' start: 92 end: 131
]

{ #category : 'tests' }
HeraLinterTestCase >> testDuplicateRuleTitle [

	self
		assertWarning: 'This rule has the same title as a previous one.'
		start: 100
		end: 146
		whenLinting: '
			Feature: User management

				Rule: Only administrators are allowed to manage users

				Rule: Only administrators are allowed to manage users'
]

{ #category : 'tests' }
HeraLinterTestCase >> testDuplicateScenarioAndScenarioOutlineTitle [

	| noWarnings |
	noWarnings := self lintFeature: '
			Feature: Eating fruit

				Scenario: Buying fruit

				Scenario Outline: Buying fruit
					Given I buy 5 <fruit>
					Examples:
						| fruit |'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 2.
	self assertWarning: 'This scenario has the same title as a previous one.' start: 78 end: 89.
	self assertWarning: 'This step has no definition' start: 96 end: 116
]

{ #category : 'tests' }
HeraLinterTestCase >> testDuplicateScenarioOutlineAndScenarioTitle [

	| noWarnings |
	noWarnings := self lintFeature: '
			Feature: Eating fruit

				Scenario Outline: Buying fruit
					Given I buy 5 <fruit>
					Examples:
						| fruit |

				Scenario: Buying fruit'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 2.
	self assertWarning: 'This scenario has the same title as a previous one.' start: 136 end: 147.
	self assertWarning: 'This step has no definition' start: 68 end: 88
]

{ #category : 'tests' }
HeraLinterTestCase >> testDuplicateScenarioOutlineTitle [

	| noWarnings |
	noWarnings := self lintFeature: '
			Feature: Eating fruit

				Scenario Outline: Buying fruit
					Given I buy 5 <fruit>
					Examples:
						| fruit |

				Scenario Outline: Buying fruit
					Given I eat 5 <fruit>
					Examples:
						| fruit |'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 3.
	self assertWarning: 'This scenario has the same title as a previous one.' start: 144 end: 155.
	self assertWarning: 'This step has no definition' start: 68 end: 88.
	self assertWarning: 'This step has no definition' start: 162 end: 182
]

{ #category : 'tests' }
HeraLinterTestCase >> testDuplicateScenarioTitle [

	self
		assertWarning: 'This scenario has the same title as a previous one.'
		start: 62
		end: 68
		whenLinting: '
			Feature: Signing in

				Scenario: Sign in
				Scenario: Sign in'
]

{ #category : 'tests' }
HeraLinterTestCase >> testFeatureTitleStartsWithUppercaseLetter [

	self
		assertWarning: 'A title should start with an uppercase letter'
		start: 10
		end: 19
		whenLinting: 'Feature: signing in'
]

{ #category : 'tests' }
HeraLinterTestCase >> testGivenComesBeforeAnyOtherStep [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: With wrong step structure

			Scenario: A Given step comes before any other step
				When I open the sign-in page
				Given I have credentials to sign in
				Then I can sign in'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 4.
	self assertWarning: 'A Given step should come before any other step' start: 131 end: 165.
	self assertWarning: 'This step has no definition' start: 98 end: 125.
	self assertWarning: 'This step has no definition' start: 131 end: 165.
	self assertWarning: 'This step has no definition' start: 171 end: 188
]

{ #category : 'tests' }
HeraLinterTestCase >> testIPauseIsDefined [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Pausing

			Scenario: The "I pause" step is not a lint issue
				When I pause'.
	self assert: noWarnings
]

{ #category : 'tests' }
HeraLinterTestCase >> testNoColonAfterAndStepKeyword [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Signing in

			Scenario: Successful sign-in
				Given I am on the sign-in page
				And: I have credentials'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 3.
	self assertWarning: 'A colon after a step keyword is not necessary' start: 96 end: 118.
	self assertWarning: 'This step has no definition' start: 61 end: 90.
	self assertWarning: 'This step has no definition' start: 96 end: 118
]

{ #category : 'tests' }
HeraLinterTestCase >> testNoColonAfterButStepKeyword [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Signing in

			Scenario: Successful sign-in
				Given I am on the sign-in page
				But: I do not have credentials'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 3.
	self assertWarning: 'A colon after a step keyword is not necessary' start: 96 end: 125.
	self assertWarning: 'This step has no definition' start: 61 end: 90.
	self assertWarning: 'This step has no definition' start: 96 end: 125
]

{ #category : 'tests' }
HeraLinterTestCase >> testNoColonAfterGivenStepKeyword [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Signing in

			Scenario: Successful sign-in
				Given: I have credentials to sign in'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 2.
	self assertWarning: 'A colon after a step keyword is not necessary' start: 61 end: 96.
	self assertWarning: 'This step has no definition' start: 61 end: 96
]

{ #category : 'tests' }
HeraLinterTestCase >> testNoColonAfterGivenStepKeywordInBackground [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Signing in

			Background:
				Given: I have credentials to sign in'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 2.
	self assertWarning: 'A colon after a step keyword is not necessary' start: 44 end: 79.
	self assertWarning: 'This step has no definition' start: 44 end: 79
]

{ #category : 'tests' }
HeraLinterTestCase >> testNoColonAfterThenStepKeyword [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Signing in

			Scenario: Successful sign-in
				Given I am signed in
				Then: I see the home page'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 3.
	self assertWarning: 'A colon after a step keyword is not necessary' start: 86 end: 110.
	self assertWarning: 'This step has no definition' start: 86 end: 110.
	self assertWarning: 'This step has no definition' start: 61 end: 80
]

{ #category : 'tests' }
HeraLinterTestCase >> testNoColonAfterWhenStepKeyword [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Signing in

			Scenario: Successful sign-in
				Given I am on the sign-in page
				When: I sign in'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 3.
	self assertWarning: 'A colon after a step keyword is not necessary' start: 96 end: 110.
	self assertWarning: 'This step has no definition' start: 96 end: 110.
	self assertWarning: 'This step has no definition' start: 61 end: 90
]

{ #category : 'tests' }
HeraLinterTestCase >> testRuleTitleStartsWithUppercaseLetter [

	self
		assertWarning: 'A title should start with an uppercase letter'
		start: 36
		end: 82
		whenLinting: '
			Feature: Signing in

				Rule: only administrators are allowed to manage users'
]

{ #category : 'tests' }
HeraLinterTestCase >> testScenarioOutlineWithEmptyExamples [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Counting fruit

			Scenario Outline: Counting <fruit>
				Given I own <number> "<fruit>"
			Examples:'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 2.
	self assertWarning: 'A scenario outline should have at least one example' start: 105 end: 113.
	self assertWarning: 'This step has no definition' start: 71 end: 100
]

{ #category : 'tests - parameters' }
HeraLinterTestCase >> testScenarioOutlineWithMissingParametersInExamples [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Counting fruit

			Scenario Outline: Counting <fruit>
				Given the following prices:
					| apples | <price> |
				And I own 5 "apples"
			Examples:
				|unknown| Fruit  | price |
				| 5     | apples | 2€    |'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 3.
	self assertWarning: 'The examples include unused parameters: "Fruit", "unknown".' start: 167 end: 223.
	self assertWarning: 'This step has no definition' start: 71 end: 123.
	self assertWarning: 'This step has no definition' start: 129 end: 148
]

{ #category : 'tests - parameters' }
HeraLinterTestCase >> testScenarioOutlineWithUnknownParametersInStep [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Counting fruit

			Scenario Outline: Counting <fruit>
				Given I own <count> "<Fruit>
				Then I can eat <number> <fruit>"
			Examples:
				|number | fruit  |
				| 5     | apples |'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 3.
	self assertWarning: 'This step includes unbound parameters: "count", "Fruit".' start: 71 end: 98.
	self assertWarning: 'This step has no definition' start: 71 end: 98.
	self assertWarning: 'This step has no definition' start: 104 end: 135
]

{ #category : 'tests' }
HeraLinterTestCase >> testScenarioOutlineWithoutExamples [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Counting fruit

			Scenario Outline: Counting <fruit>
				Given I own <number> "<fruit>"'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 2.
	self assertWarning: 'A scenario outline should have an Examples section' start: 32 end: 65.
	self assertWarning: 'This step has no definition' start: 71 end: 100
]

{ #category : 'tests' }
HeraLinterTestCase >> testScenarioTitleStartsWithUppercaseLetter [

	self
		assertWarning: 'A title should start with an uppercase letter'
		start: 40
		end: 57
		whenLinting: '
			Feature: Signing in

				Scenario: successful sign-in'
]

{ #category : 'tests' }
HeraLinterTestCase >> testStarCannotBeTheFirstStep [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Signing in

			Scenario: A * step cannot be the first step in a scenario
				* I have credentials to sign in'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 2.
	self assertWarning: 'A * step should not be the first step in a scenario' start: 90 end: 120.
	self assertWarning: 'This step has no definition' start: 90 end: 120
]

{ #category : 'tests - parameters' }
HeraLinterTestCase >> testStepDataTableParametersAreNotAllowedInScenario [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Counting fruit

			Scenario: Counting fruit
				Given I own:
					| <count> | <fruit> |
				When I own:
					| <count> | <fruit> |
				Then I own:
					| <count> | <fruit> |
				And I own:
					| <count> | <fruit> |
				But I own:
					| <count> | <fruit> |
				* I own:
					| <count> | <fruit> |'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 12.
	self assertWarning: 'Parameters are only allowed in data tables of a scenario outline' start: 79 end: 99.
	self assertWarning: 'Parameters are only allowed in data tables of a scenario outline' start: 122 end: 142.
	self assertWarning: 'Parameters are only allowed in data tables of a scenario outline' start: 165 end: 185.
	self assertWarning: 'Parameters are only allowed in data tables of a scenario outline' start: 207 end: 227.
	self assertWarning: 'Parameters are only allowed in data tables of a scenario outline' start: 249 end: 269.
	self assertWarning: 'Parameters are only allowed in data tables of a scenario outline' start: 289 end: 309.
	self assertWarning: 'This step has no definition' start: 61 end: 99.
	self assertWarning: 'This step has no definition' start: 105 end: 142.
	self assertWarning: 'This step has no definition' start: 148 end: 185.
	self assertWarning: 'This step has no definition' start: 191 end: 227.
	self assertWarning: 'This step has no definition' start: 233 end: 269.
	self assertWarning: 'This step has no definition' start: 275 end: 309
]

{ #category : 'tests - parameters' }
HeraLinterTestCase >> testStepDataTreeParametersAreNotAllowedInScenario [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Buying fruit

			Scenario: Seeing purchases
				Given I see an overview of my purchases in the app:
					>  Today
					>>   Fruit Shop: <price>
				When I see an overview of my purchases in the app:
					>  Today
					>>   Fruit Shop: <price>
				Then I see an overview of my purchases in the app:
					>  Today
					>>   Fruit Shop: <price>
				And I see an overview of my purchases in the app:
					>  Today
					>>   Fruit Shop: <price>
				But I see an overview of my purchases in the app:
					>  Today
					>>   Fruit Shop: <price>
				* I see an overview of my purchases in the app:
					>  Today
					>>   Fruit Shop: <price>'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 12.
	self assertWarning: 'Parameters are only allowed in data trees of a scenario outline' start: 118 end: 155.
	self assertWarning: 'Parameters are only allowed in data trees of a scenario outline' start: 217 end: 254.
	self assertWarning: 'Parameters are only allowed in data trees of a scenario outline' start: 316 end: 353.
	self assertWarning: 'Parameters are only allowed in data trees of a scenario outline' start: 414 end: 451.
	self assertWarning: 'Parameters are only allowed in data trees of a scenario outline' start: 512 end: 549.
	self assertWarning: 'Parameters are only allowed in data trees of a scenario outline' start: 608 end: 645.
	self assertWarning: 'This step has no definition' start: 61 end: 155.
	self assertWarning: 'This step has no definition' start: 161 end: 254.
	self assertWarning: 'This step has no definition' start: 260 end: 353.
	self assertWarning: 'This step has no definition' start: 359 end: 451.
	self assertWarning: 'This step has no definition' start: 457 end: 549.
	self assertWarning: 'This step has no definition' start: 555 end: 645
]

{ #category : 'tests - parameters' }
HeraLinterTestCase >> testStepDocStringParametersAreNotAllowedInScenario [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Buying fruit

			Scenario: Receiving a ticket
				Given I receive a ticket:
					"""
					Total: <price>
					"""
				When I receive a ticket:
					"""
					Total: <price>
					"""
				Then I receive a ticket:
					"""
					Total: <price>
					"""
				And I receive a ticket:
					"""
					Total: <price>
					"""
				But I receive a ticket:
					"""
					Total: <price>
					"""
				* I receive a ticket:
					"""
					Total: <price>
					"""'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 12.
	self assertWarning: 'Parameters are only allowed in doc strings of a scenario outline' start: 94 end: 125.
	self assertWarning: 'Parameters are only allowed in doc strings of a scenario outline' start: 161 end: 192.
	self assertWarning: 'Parameters are only allowed in doc strings of a scenario outline' start: 228 end: 259.
	self assertWarning: 'Parameters are only allowed in doc strings of a scenario outline' start: 294 end: 325.
	self assertWarning: 'Parameters are only allowed in doc strings of a scenario outline' start: 360 end: 391.
	self assertWarning: 'Parameters are only allowed in doc strings of a scenario outline' start: 424 end: 455.
	self assertWarning: 'This step has no definition' start: 63 end: 125.
	self assertWarning: 'This step has no definition' start: 131 end: 192.
	self assertWarning: 'This step has no definition' start: 198 end: 259.
	self assertWarning: 'This step has no definition' start: 265 end: 325.
	self assertWarning: 'This step has no definition' start: 331 end: 391.
	self assertWarning: 'This step has no definition' start: 397 end: 455
]

{ #category : 'tests - parameters' }
HeraLinterTestCase >> testStepParametersAreNotAllowedInScenario [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Counting fruit

			Scenario: Counting fruit
				Given I own <count> "<Fruit>"
				When I own <count> "<Fruit>"
				Then I own <count> "<Fruit>"
				And I own <count> "<Fruit>"
				But I own <count> "<Fruit>"
				* I own <count> "<Fruit>"'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 12.
	self assertWarning: 'Parameters in steps are only allowed in a scenario outline' start: 61 end: 89.
	self assertWarning: 'Parameters in steps are only allowed in a scenario outline' start: 95 end: 122.
	self assertWarning: 'Parameters in steps are only allowed in a scenario outline' start: 128 end: 155.
	self assertWarning: 'Parameters in steps are only allowed in a scenario outline' start: 161 end: 187.
	self assertWarning: 'Parameters in steps are only allowed in a scenario outline' start: 193 end: 219.
	self assertWarning: 'Parameters in steps are only allowed in a scenario outline' start: 225 end: 249.
	self assertWarning: 'This step has no definition' start: 61 end: 89.
	self assertWarning: 'This step has no definition' start: 95 end: 122.
	self assertWarning: 'This step has no definition' start: 128 end: 155.
	self assertWarning: 'This step has no definition' start: 161 end: 187.
	self assertWarning: 'This step has no definition' start: 193 end: 219.
	self assertWarning: 'This step has no definition' start: 225 end: 249
]

{ #category : 'tests' }
HeraLinterTestCase >> testThenCannotBeTheFirstStep [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Signing in

			Scenario: A Then step should not be the first step
				Then I can see the home page'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 2.
	self assertWarning: 'A Then step should not be the first step in a scenario' start: 83 end: 110.
	self assertWarning: 'This step has no definition' start: 83 end: 110
]

{ #category : 'tests - parameters' }
HeraLinterTestCase >> testTitleParametersAreNotAllowedInScenario [

	| noWarnings |
	noWarnings := self lintFeature: '
		Feature: Counting fruit

			Scenario: Counting <fruit>'.
	self deny: noWarnings.
	self assert: subject warnings size equals: 1.
	self assertWarning: 'Parameters are only allowed in the title of a scenario outline' start: 42 end: 57
]
