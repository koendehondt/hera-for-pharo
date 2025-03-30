Class {
	#name : 'HeraGherkinLinterTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Linter',
	#package : 'Hera-Tests',
	#tag : 'Linter'
}

{ #category : 'helpers' }
HeraGherkinLinterTestCase >> assertWarning: aString start: startInteger end: endInteger whenLinting: script [

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
HeraGherkinLinterTestCase >> describedClass [

	^ HeraGherkinLinter
]

{ #category : 'helpers' }
HeraGherkinLinterTestCase >> lintFeature: aScript [

	| ast |
	ast := self parseFeature: aScript.
	^ subject lint: ast
]

{ #category : 'helpers' }
HeraGherkinLinterTestCase >> parseFeature: aScript [

	| parser |
	parser := HeraGherkinParser new initializeParserWith: aScript.
	^ parser parseFeature
]

{ #category : 'tests' }
HeraGherkinLinterTestCase >> testAndCannotBeTheFirstStep [

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
HeraGherkinLinterTestCase >> testButCannotBeTheFirstStep [

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
HeraGherkinLinterTestCase >> testFeatureNameStartsWithUppercaseLetter [

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
HeraGherkinLinterTestCase >> testGivenComesBeforeAnyOtherStep [

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
HeraGherkinLinterTestCase >> testScenarioTitleStartsWithUppercaseLetter [

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
HeraGherkinLinterTestCase >> testThenCannotBeTheFirstStep [

	self
		assertWarning: 'A Then step should not be the first step in a scenario'
		start: 86
		end: 113
		whenLinting: '
			Feature: Signing in

				Scenario: A Then step should not be the first step
					Then I can see the home page'
]
