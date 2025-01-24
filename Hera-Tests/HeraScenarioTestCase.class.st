Class {
	#name : 'HeraScenarioTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraScenarioTestCase >> describedClass [

	^ HeraScenario
]

{ #category : 'tests' }
HeraScenarioTestCase >> testAnd [

	| expectedStep |
	subject and: 'I see the new messages'.
	expectedStep := HeraAndStep new description: 'I see the new messages'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests' }
HeraScenarioTestCase >> testBut [

	| expectedStep |
	subject but: 'I see no old messages'.
	expectedStep := HeraButStep new description: 'I see no old messages'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests' }
HeraScenarioTestCase >> testGiven [

	| expectedStep |
	subject given: 'I have credentials to sign in'.
	expectedStep := HeraGivenStep new description: 'I have credentials to sign in'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests' }
HeraScenarioTestCase >> testGivenWithDataTable [

	| expectedStep argument expectedArgument |
	argument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { 10 . 20 } }).
	subject given: 'the following users exist' with: argument.
	expectedArgument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { 10 . 20 } }).
	expectedStep := HeraGivenStep new
		description: 'the following users exist';
		argument: expectedArgument.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests' }
HeraScenarioTestCase >> testPrintString [

	subject title: 'Successful sign-in'.
	self assert: subject printString equals: 'Scenario: Successful sign-in'
]

{ #category : 'tests' }
HeraScenarioTestCase >> testThen [

	| expectedStep |
	subject then: 'I see the home page'.
	expectedStep := HeraThenStep new description: 'I see the home page'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests' }
HeraScenarioTestCase >> testWhen [

	| expectedStep |
	subject when: 'I enter my credentials'.
	expectedStep := HeraWhenStep new description: 'I enter my credentials'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]
