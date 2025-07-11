Class {
	#name : 'HeraDataTableTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraDataTableTestCase >> describedClass [

	^ HeraDataTable
]

{ #category : 'running' }
HeraDataTableTestCase >> initializeSubject [

	super initializeSubject.
	subject data: {
		{ 'Name' . 'Email' } .
		{ 'John' . 'john@testing.org' } .
		{ 'Jane' . 'jane@testing.org' } }
]

{ #category : 'tests' }
HeraDataTableTestCase >> testAsArray [

	| expectedValues |
	subject data: {
		{ 'John' } .
		{ 'Jane' } }.
	expectedValues := { 'John' . 'Jane' }.
	self assert: subject asArray equals: expectedValues
]

{ #category : 'tests' }
HeraDataTableTestCase >> testAsAssociations [

	| expectedAssociations |
	subject data: {
		{ 'Name' . 'John' } .
		{ 'Email' . 'john@testing.org' } }.
	expectedAssociations := Array
		with: 'Name' -> 'John'
		with: 'Email' -> 'john@testing.org'.
	self assert: subject asAssociations equals: expectedAssociations
]

{ #category : 'tests' }
HeraDataTableTestCase >> testAsDictionaries [

	| expectedDictionaries |
	expectedDictionaries := Array
		with: (Dictionary with: 'Name' -> 'John' with: 'Email' -> 'john@testing.org')
		with: (Dictionary with: 'Name' -> 'Jane' with: 'Email' -> 'jane@testing.org').
	self assert: subject asDictionaries equals: expectedDictionaries
]

{ #category : 'tests' }
HeraDataTableTestCase >> testAsDictionariesWhenTableHasNoValueRows [

	subject data: { { 'Name' . 'Email' } }.
	self assert: subject asDictionaries equals: #()
]

{ #category : 'tests' }
HeraDataTableTestCase >> testPrintFormattedOnIndentedWithIndentation [

	| actualOutput expectedOutput |
	actualOutput := String streamContents: [ :stream | subject printFormattedOn: stream indentation: 2 ].
	expectedOutput := '
		| Name | Email            |
		| John | john@testing.org |
		| Jane | jane@testing.org |' allButFirst.
	self assert: actualOutput equals: expectedOutput
]

{ #category : 'tests' }
HeraDataTableTestCase >> testPrintFormattedOnIndentedWithoutIndentation [

	| actualOutput expectedOutput |
	actualOutput := String streamContents: [ :stream | subject printFormattedOn: stream indentation: 0 ].
	expectedOutput := '
| Name | Email            |
| John | john@testing.org |
| Jane | jane@testing.org |' allButFirst.
	self assert: actualOutput equals: expectedOutput
]

{ #category : 'tests' }
HeraDataTableTestCase >> testPrintOn [

	| actualOutput expectedOutput |
	actualOutput := String streamContents: [ :stream | subject printOn: stream ].
	expectedOutput := '
| Name | Email            |
| John | john@testing.org |
| Jane | jane@testing.org |' allButFirst.
	self assert: actualOutput equals: expectedOutput
]
