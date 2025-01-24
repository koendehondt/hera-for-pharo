Class {
	#name : 'HeraDocStringTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraDocStringTestCase >> describedClass [

	^ HeraDocString
]

{ #category : 'running' }
HeraDocStringTestCase >> initializeSubject [

	super initializeSubject.
	subject lines: {
		'<users>' .
		'	<user>' .
		'		<name>John</name>' .
		'		<email>john@testing.org</email>' .
		'	</user>' .
		'	<user>' .
		'		<name>Jane</name>' .
		'		<email>jane@testing.org</email>' .
		'	</user>' .
		'</users>' }
]

{ #category : 'tests' }
HeraDocStringTestCase >> testPrintFormattedOnIndentedWithIndentation [

	| actualOutput expectedOutput |
	actualOutput := String streamContents: [ :stream | subject printFormattedOn: stream indentation: 2 ].
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
		"""' trimLeft: [ :char | char = Character cr ].
	self assert: actualOutput equals: expectedOutput
]

{ #category : 'tests' }
HeraDocStringTestCase >> testPrintFormattedOnIndentedWithoutIndentation [

	| actualOutput expectedOutput |
	actualOutput := String streamContents: [ :stream | subject printFormattedOn: stream indentation: 0 ].
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
"""' trimLeft: [ :char | char = Character cr ].
	self assert: actualOutput equals: expectedOutput
]

{ #category : 'tests' }
HeraDocStringTestCase >> testPrintOn [

	| actualOutput expectedOutput |
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
"""' trimLeft: [ :char | char = Character cr ].
	self assert: actualOutput equals: expectedOutput
]
