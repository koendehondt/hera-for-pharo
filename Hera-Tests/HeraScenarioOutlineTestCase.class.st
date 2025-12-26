Class {
	#name : 'HeraScenarioOutlineTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraScenarioOutlineTestCase >> describedClass [

	^ HeraScenarioOutline
]

{ #category : 'tests' }
HeraScenarioOutlineTestCase >> testAsScenariosWithResolvedParameters [

	| resolvedScenarios firstResolvedScenario secondResolvedScenario |
	subject
		title: 'Buying <fruit>';
		when: 'I buy <number> <fruit> for these prices:' with: (HeraDataTable new data: {
			{ 'apples' . '0.6' } .
			{ 'oranges' . '0.9' } });
		examples: (HeraDataTable new data: {
			{ 'fruit' . 'number' } .
			{ 'apples' . '5' } .
			{ 'oranges' . '8' } }).
	resolvedScenarios := subject asScenariosWithResolvedParameters.
	self assert: resolvedScenarios size equals: 2.
	firstResolvedScenario := resolvedScenarios first.
	self assert: firstResolvedScenario title equals: 'Buying apples'.
	self assert: firstResolvedScenario steps size equals: 1.
	self assert: firstResolvedScenario steps first description equals: 'I buy 5 apples for these prices:'.
	self assert: firstResolvedScenario steps first argumentValue equals: (HeraDataTable new data: {
			{ 'apples' . '0.6' } .
			{ 'oranges' . '0.9' } }).
	secondResolvedScenario := resolvedScenarios second.
	self assert: secondResolvedScenario title equals: 'Buying oranges'.
	self assert: secondResolvedScenario steps size equals: 1.
	self assert: secondResolvedScenario steps first description equals: 'I buy 8 oranges for these prices:'.
	self assert: secondResolvedScenario steps first argumentValue equals: (HeraDataTable new data: {
			{ 'apples' . '0.6' } .
			{ 'oranges' . '0.9' } }).
]

{ #category : 'tests' }
HeraScenarioOutlineTestCase >> testAsScenariosWithUnresolvedParameters [

	subject
		title: 'Buying <fruit>';
		when: 'I buy <number> <fruit>'.
	self assert: subject asScenariosWithResolvedParameters equals: { subject } 
]

{ #category : 'tests' }
HeraScenarioOutlineTestCase >> testExamples [

	| dataTable |
	self assert: subject examples isNil.
	dataTable := HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } }.
	subject examples: dataTable.
	self assert: subject examples identicalTo: dataTable
]

{ #category : 'tests' }
HeraScenarioOutlineTestCase >> testPrintString [

	subject title: 'Counting <fruit>'.
	self assert: subject printString equals: 'Scenario Outline: Counting <fruit>'
]
