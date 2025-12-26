Class {
	#name : 'HeraScenarioTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraScenarioTestCase >> describedClass [

	^ HeraScenario
]

{ #category : 'tests - dsl' }
HeraScenarioTestCase >> testAnd [

	| expectedStep |
	subject and: 'I see the new messages'.
	expectedStep := HeraAndStep new
		description: 'I see the new messages'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraScenarioTestCase >> testAndWithDataTable [

	| expectedStep expectedArgument |
	subject and: 'these points are connected' with: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } . { '100' . '200' } }).
	expectedArgument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } . { '100' . '200' } }).
	expectedStep := HeraAndStep new
		description: 'these points are connected';
		argument: expectedArgument.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraScenarioTestCase >> testAsScenariosWithResolvedParameters [

	self assert: subject asScenariosWithResolvedParameters equals: { subject }
]

{ #category : 'tests - dsl' }
HeraScenarioTestCase >> testBut [

	| expectedStep |
	subject but: 'I see no old messages'.
	expectedStep := HeraButStep new
		description: 'I see no old messages'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraScenarioTestCase >> testButWithDataTable [

	| expectedStep expectedArgument |
	subject but: 'these points are not connected' with: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } . { '100' . '200' } }).
	expectedArgument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } . { '100' . '200' } }).
	expectedStep := HeraButStep new
		description: 'these points are not connected';
		argument: expectedArgument.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraScenarioTestCase >> testGiven [

	| expectedStep |
	subject given: 'I have credentials to sign in'.
	expectedStep := HeraGivenStep new
		description: 'I have credentials to sign in'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraScenarioTestCase >> testGivenWithDataTable [

	| expectedStep expectedArgument |
	subject given: 'the following coordinates' with: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } }).
	expectedArgument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } }).
	expectedStep := HeraGivenStep new
		description: 'the following coordinates';
		argument: expectedArgument.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests' }
HeraScenarioTestCase >> testPrintString [

	subject title: 'Successful sign-in'.
	self assert: subject printString equals: 'Scenario: Successful sign-in'
]

{ #category : 'tests - dsl' }
HeraScenarioTestCase >> testStar [

	| expectedStep |
	subject star: 'I see the new messages'.
	expectedStep := HeraStarStep new
		description: 'I see the new messages'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraScenarioTestCase >> testThen [

	| expectedStep |
	subject then: 'I see the home page'.
	expectedStep := HeraThenStep new
		description: 'I see the home page'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraScenarioTestCase >> testThenWithDataTable [

	| expectedStep expectedArgument |
	subject then: 'these points are connected' with: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } . { '100' . '200' } }).
	expectedArgument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } . { '100' . '200' } }).
	expectedStep := HeraThenStep new
		description: 'these points are connected';
		argument: expectedArgument.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraScenarioTestCase >> testWhen [

	| expectedStep |
	subject when: 'I enter my credentials'.
	expectedStep := HeraWhenStep new
		description: 'I enter my credentials'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraScenarioTestCase >> testWhenWithDataTable [

	| expectedStep expectedArgument |
	subject when: 'drawing a figure with these points' with: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } . { '100' . '200' } }).
	expectedArgument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } . { '100' . '200' } }).
	expectedStep := HeraWhenStep new
		description: 'drawing a figure with these points';
		argument: expectedArgument.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]
