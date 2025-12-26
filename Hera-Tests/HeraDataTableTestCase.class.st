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
HeraDataTableTestCase >> testAsDictionary [

	| expectedDictionary |
	subject data: {
		{ 'Name' . 'John' } .
		{ 'Email' . 'john@testing.org' } }.
	expectedDictionary := Dictionary
		with: 'Name' -> 'John'
		with: 'Email' -> 'john@testing.org'.
	self assert: subject asDictionary equals: expectedDictionary
]

{ #category : 'tests' }
HeraDataTableTestCase >> testAsStepArgument [

	self assert: subject asStepArgument equals: (HeraDataTableArgument new dataTable: subject)
]

{ #category : 'tests' }
HeraDataTableTestCase >> testAssociationsDo [

	| headersAndValues |
	subject data: {
		{ 'Name' . 'John' } .
		{ 'Email' . 'john@testing.org' } }.
	headersAndValues := Dictionary new.
	subject associationsDo: [ :header :value | headersAndValues at: header put: value ].
	self assert: headersAndValues equals: (Dictionary
		with: 'Name' -> 'John'
		with: 'Email' -> 'john@testing.org')
]

{ #category : 'tests' }
HeraDataTableTestCase >> testColumnHeaders [

	self assert: subject columnHeaders equals: { 'Name' . 'Email' }
]

{ #category : 'tests' }
HeraDataTableTestCase >> testEmptyInstance [

	self assert: self describedClass new data equals: #()
]

{ #category : 'tests' }
HeraDataTableTestCase >> testHasParameters [

	self deny: subject hasParameters.
	subject data: {
		{ 'Name field' . '<name>' } .
		{ 'Email field' . '<email>' } }.
	self assert: subject hasParameters
]

{ #category : 'tests' }
HeraDataTableTestCase >> testIsEmpty [

	self assert: self describedClass new isEmpty
]

{ #category : 'tests' }
HeraDataTableTestCase >> testParameters [

	self assert: subject parameters equals: Set new.
	subject data: {
		{ 'Name field' . '<name>' } .
		{ 'Email field' . '<email>' } }.
	self assert: subject parameters equals: (Set with: 'name' with: 'email')
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
HeraDataTableTestCase >> testPrintFormattedOnIndentedWithoutData [

	| actualOutput |
	actualOutput := String streamContents: [ :stream | self describedClass new printFormattedOn: stream indentation: 2 ].
	self assert: actualOutput equals: ''
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
