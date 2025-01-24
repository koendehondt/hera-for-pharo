Class {
	#name : 'HeraTestCase',
	#superclass : 'TestCase',
	#instVars : [
		'subject'
	],
	#category : 'Hera-Tests-Support',
	#package : 'Hera-Tests',
	#tag : 'Support'
}

{ #category : 'asserting' }
HeraTestCase >> assertText: actualText equals: expectedText [
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
HeraTestCase >> assertTextAttribute: actualAttribute equals: expectedAttribute [

	actualAttribute = expectedAttribute or: [
		(actualAttribute isMemberOf: TextAction) and: [ expectedAttribute isMemberOf: TextAction ] ]
]

{ #category : 'asserting' }
HeraTestCase >> assertTextRun: actualRun equals: expectedRun [

	actualRun with: expectedRun do: [ :actualAttribute :expectedAttribute |
		self assertTextAttribute: actualAttribute equals: expectedAttribute ]
]

{ #category : 'running' }
HeraTestCase >> describedClass [

	self subclassResponsibility
]

{ #category : 'running' }
HeraTestCase >> initializeSubject [

	subject := self describedClass new
]

{ #category : 'running' }
HeraTestCase >> setUp [

	super setUp.
	self initializeSubject
]
