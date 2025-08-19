Class {
	#name : 'HeraUnitTestCase',
	#superclass : 'TestCase',
	#instVars : [
		'subject'
	],
	#category : 'Hera-Test support',
	#package : 'Hera',
	#tag : 'Test support'
}

{ #category : 'asserting' }
HeraUnitTestCase >> assertText: actualText equals: expectedText [
	"This assertion is needed because Text>>#= only compares the text, not the text attributes.
	 On top of that, comparing TextAction instances is based on Object>>#=, which is undesired."

	| actualRuns expectedRuns |
	self assert: actualText equals: expectedText.
	actualRuns := actualText runs.
	expectedRuns := expectedText runs.
	actualRuns with: expectedRuns do: [ :actualRun :expectedRun |
		self assertTextRun: actualRun equals: expectedRun ].
]

{ #category : 'asserting' }
HeraUnitTestCase >> assertTextAttribute: actualAttribute equals: expectedAttribute [

	actualAttribute = expectedAttribute or: [
		(actualAttribute isMemberOf: TextAction) and: [ expectedAttribute isMemberOf: TextAction ] ]
]

{ #category : 'asserting' }
HeraUnitTestCase >> assertTextRun: actualRun equals: expectedRun [

	actualRun with: expectedRun do: [ :actualAttribute :expectedAttribute |
		self assertTextAttribute: actualAttribute equals: expectedAttribute ]
]

{ #category : 'running' }
HeraUnitTestCase >> describedClass [

	^ self subclassResponsibility
]

{ #category : 'running' }
HeraUnitTestCase >> initializeSubject [

	subject := self describedClass new
]

{ #category : 'running' }
HeraUnitTestCase >> setUp [

	super setUp.
	self initializeSubject
]
