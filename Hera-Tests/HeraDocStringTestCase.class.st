Class {
	#name : 'HeraDocStringTestCase',
	#superclass : 'HeraUnitTestCase',
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
HeraDocStringTestCase >> testAsStepArgument [

	self assert: subject asStepArgument equals: (HeraDocStringArgument new docString: subject)
]

{ #category : 'tests' }
HeraDocStringTestCase >> testAsString [

	self assert: subject asString equals: '<users>
	<user>
		<name>John</name>
		<email>john@testing.org</email>
	</user>
	<user>
		<name>Jane</name>
		<email>jane@testing.org</email>
	</user>
</users>'
]

{ #category : 'tests' }
HeraDocStringTestCase >> testHasParameters [

	subject lines: #().
	self deny: subject hasParameters.
	subject lines: {
		'apples: 3€'.
		'Total: 3€' }.
	self deny: subject hasParameters.
	subject lines: {
		'<product>: <price>'.
		'Total: <total_amount>' }.
	self assert: subject hasParameters.
]

{ #category : 'tests' }
HeraDocStringTestCase >> testParameters [

	subject lines: #().
	self assert: subject parameters equals: Set new.
	subject lines: {
		'apples: 3€'.
		'Total: 3€' }.
	self assert: subject parameters equals: Set new.
	subject lines: {
		'<product>: <price>'.
		'Total: <total_amount>' }.
	self assert: subject parameters equals: (Set with: 'price' with: 'product' with: 'total_amount')
]

{ #category : 'tests' }
HeraDocStringTestCase >> testPrintFormattedOnIndentedWhenEmpty [

	| actualOutput expectedOutput |
	subject lines: #().
	actualOutput := String streamContents: [ :stream | subject printFormattedOn: stream indentation: 2 ].
	expectedOutput := '
		"""
		"""' allButFirst.
	self assert: actualOutput equals: expectedOutput
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
		"""' allButFirst.
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
"""' allButFirst.
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
"""' allButFirst.
	self assert: actualOutput equals: expectedOutput
]
