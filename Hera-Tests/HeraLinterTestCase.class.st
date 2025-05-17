Class {
	#name : 'HeraLinterTestCase',
	#superclass : 'HeraTestCase',
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
		assertWarning: 'A rule title should start with an uppercase letter'
		start: 36
		end: 82
		whenLinting: '
			Feature: Signing in

				Rule: only administrators are allowed to manage users'
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
