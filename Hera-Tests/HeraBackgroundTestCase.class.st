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
