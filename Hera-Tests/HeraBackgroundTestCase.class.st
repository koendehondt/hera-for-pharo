Class {
	#name : 'HeraBackgroundTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraBackgroundTestCase >> describedClass [

	^ HeraBackground
]

{ #category : 'tests - dsl' }
HeraBackgroundTestCase >> testAnd [

	| expectedStep |
	subject and: 'I have a password'.
	expectedStep := HeraAndStep new description: 'I have a password'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraBackgroundTestCase >> testAndWithDataTable [

	| expectedStep argument expectedArgument |
	argument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } . { '100' . '200' } }).
	subject and: 'these points are connected' with: argument.
	expectedArgument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } . { '100' . '200' } }).
	expectedStep := HeraAndStep new
		description: 'these points are connected';
		argument: expectedArgument.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraBackgroundTestCase >> testBut [

	| expectedStep |
	subject but: 'no email'.
	expectedStep := HeraButStep new description: 'no email'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraBackgroundTestCase >> testButWithDataTable [

	| expectedStep argument expectedArgument |
	argument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } . { '100' . '200' } }).
	subject but: 'these points are not connected' with: argument.
	expectedArgument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } . { '100' . '200' } }).
	expectedStep := HeraButStep new
		description: 'these points are not connected';
		argument: expectedArgument.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraBackgroundTestCase >> testGiven [

	| expectedStep |
	subject given: 'I have credentials to sign in'.
	expectedStep := HeraGivenStep new description: 'I have credentials to sign in'.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests - dsl' }
HeraBackgroundTestCase >> testGivenWithDataTable [

	| expectedStep argument expectedArgument |
	argument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } }).
	subject given: 'the following coordinates' with: argument.
	expectedArgument := HeraDataTableArgument new dataTable: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } }).
	expectedStep := HeraGivenStep new
		description: 'the following coordinates';
		argument: expectedArgument.
	self assert: subject steps equals: (OrderedCollection with: expectedStep)
]

{ #category : 'tests' }
HeraBackgroundTestCase >> testPrintOn [

	self assert: subject printString equals: 'Background:'
]
