Class {
	#name : 'HeraDataTableArgumentTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraDataTableArgumentTestCase >> describedClass [

	^ HeraDataTableArgument
]

{ #category : 'tests' }
HeraDataTableArgumentTestCase >> testPrintOn [

	| actualOutput expectedOutput |
	subject dataTable: (HeraDataTable new data: {
		{ 'Name' . 'Email' } .
		{ 'John' . 'john@testing.org' } .
		{ 'Jane' . 'jane@testing.org' } }).
	actualOutput := String streamContents: [ :stream | subject printOn: stream ].
	expectedOutput := '
| Name | Email            |
| John | john@testing.org |
| Jane | jane@testing.org |' allButFirst.
	self assert: actualOutput equals: expectedOutput
]
