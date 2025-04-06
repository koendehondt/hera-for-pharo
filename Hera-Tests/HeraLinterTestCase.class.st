Class {
	#name : 'HeraLinterTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Linter',
	#package : 'Hera-Tests',
	#tag : 'Linter'
}

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

{ #category : 'helpers' }
HeraLinterTestCase >> lintFeature: aScript [

	| ast |
	ast := self parseFeature: aScript.
	^ subject lint: ast
]

{ #category : 'helpers' }
HeraLinterTestCase >> parseFeature: aScript [

	| parser |
	parser := HeraGherkinParser new initializeParserWith: aScript.
	^ parser parseFeature
]

{ #category : 'tests' }
HeraLinterTestCase >> testAndCannotBeTheFirstStep [

	self
		assertWarning: 'An And step should not be the first step in a scenario'
		start: 96
		end: 128
		whenLinting: '
			Feature: Signing in

				Scenario: An And step cannot be the first step in a scenario
					And I have credentials to sign in'
]

{ #category : 'tests' }
HeraLinterTestCase >> testButCannotBeTheFirstStep [

	self
		assertWarning: 'A But step should not be the first step in a scenario'
		start: 95
		end: 134
		whenLinting: '
			Feature: Signing in

				Scenario: A But step cannot be the first step in a scenario
					But I do not have credentials to sign in'
]

{ #category : 'tests' }
HeraLinterTestCase >> testFeatureNameStartsWithUppercaseLetter [

	self
		assertWarning: 'A feature name should start with an uppercase letter'
		start: 5
		end: 23
		whenLinting: '
			Feature: signing in

				Scenario: Successful sign-in
					Given I have credentials to sign in'
]

{ #category : 'tests' }
HeraLinterTestCase >> testGivenComesBeforeAnyOtherStep [

	self
		assertWarning: 'A Given step should come before any other step'
		start: 135
		end: 169
		whenLinting: '
			Feature: With wrong step structure

				Scenario: A Given step comes before any other step
					When I open the sign-in page
					Given I have credentials to sign in
					Then I can sign in'
]

{ #category : 'tests' }
HeraLinterTestCase >> testNoColonAfterAndStepKeyword [

	self
		assertWarning: 'A colon after a step keyword is not necessary'
		start: 100
		end: 122
		whenLinting: '
			Feature: Signing in

				Scenario: Successful sign-in
					Given I am on the sign-in page
					And: I have credentials'
]

{ #category : 'tests' }
HeraLinterTestCase >> testNoColonAfterButStepKeyword [

	self
		assertWarning: 'A colon after a step keyword is not necessary'
		start: 100
		end: 129
		whenLinting: '
			Feature: Signing in

				Scenario: Successful sign-in
					Given I am on the sign-in page
					But: I do not have credentials'
]

{ #category : 'tests' }
HeraLinterTestCase >> testNoColonAfterGivenStepKeyword [

	self
		assertWarning: 'A colon after a step keyword is not necessary'
		start: 64
		end: 99
		whenLinting: '
			Feature: Signing in

				Scenario: Successful sign-in
					Given: I have credentials to sign in'
]

{ #category : 'tests' }
HeraLinterTestCase >> testNoColonAfterThenStepKeyword [

	self
		assertWarning: 'A colon after a step keyword is not necessary'
		start: 90
		end: 114
		whenLinting: '
			Feature: Signing in

				Scenario: Successful sign-in
					Given I am signed in
					Then: I see the home page'
]

{ #category : 'tests' }
HeraLinterTestCase >> testNoColonAfterWhenStepKeyword [

	self
		assertWarning: 'A colon after a step keyword is not necessary'
		start: 100
		end: 114
		whenLinting: '
			Feature: Signing in

				Scenario: Successful sign-in
					Given I am on the sign-in page
					When: I sign in'
]

{ #category : 'tests' }
HeraLinterTestCase >> testScenarioTitleStartsWithUppercaseLetter [

	self
		assertWarning: 'A scenario title should start with an uppercase letter'
		start: 30
		end: 57
		whenLinting: '
			Feature: Signing in

				Scenario: successful sign-in
					Given I have credentials to sign in'
]

{ #category : 'tests' }
HeraLinterTestCase >> testThenCannotBeTheFirstStep [

	self
		assertWarning: 'A Then step should not be the first step in a scenario'
		start: 86
		end: 113
		whenLinting: '
			Feature: Signing in

				Scenario: A Then step should not be the first step
					Then I can see the home page'
]
