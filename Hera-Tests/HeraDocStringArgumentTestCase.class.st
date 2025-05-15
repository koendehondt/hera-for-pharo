Class {
	#name : 'HeraDocStringArgumentTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraDocStringArgumentTestCase >> describedClass [

	^ HeraDocStringArgument
]

{ #category : 'tests' }
HeraDocStringArgumentTestCase >> testPrintOn [

	| actualOutput expectedOutput |
	subject docString: (HeraDocString new lines: {
		'<users>' .
		'	<user>' .
		'		<name>John</name>' .
		'		<email>john@testing.org</email>' .
		'	</user>' .
		'	<user>' .
		'		<name>Jane</name>' .
		'		<email>jane@testing.org</email>' .
		'	</user>' .
		'</users>' }).
	actualOutput := String streamContents: [ :stream | subject printOn: stream ].
	expectedOutput := '
"""
<users>
	<user>
		<name>John</name>
		<email>john@testing.org</email>
	</user>
	<user>
		<name>Jane</name>
		<email>jane@testing.org</email>
	</user>
</users>
"""' allButFirst.
	self assert: actualOutput equals: expectedOutput
]
