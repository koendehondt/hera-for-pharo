Class {
	#name : 'HeraTextReporter',
	#superclass : 'HeraAbstractReporter',
	#instVars : [
		'stream',
		'reportsTags',
		'reportsDescriptions',
		'indentation'
	],
	#category : 'Hera-Reporting',
	#package : 'Hera',
	#tag : 'Reporting'
}

{ #category : 'private - reporting' }
HeraTextReporter >> decreaseIndentation [

	indentation := indentation - 1
]

{ #category : 'private - reporting' }
HeraTextReporter >> increaseIndentation [

	indentation := indentation + 1
]

{ #category : 'initialization' }
HeraTextReporter >> initialize [

	super initialize.
	stream := TextStream on: (Text new: 1000).
	reportsTags := false.
	reportsDescriptions := false.
	indentation := 0
]

{ #category : 'reporting' }
HeraTextReporter >> reportAfterScenarioHookError: anError [

	stream crtab: indentation.
	stream
		withAttributes:  self textAttributesForError
		do: [ stream nextPutAll: 'ERROR' ].
	stream
		space;
		nextPutAll: anError messageText
]

{ #category : 'reporting' }
HeraTextReporter >> reportBeforeScenarioHookError: anError [

	stream crtab: indentation.
	stream
		withAttributes:  self textAttributesForError
		do: [ stream nextPutAll: 'ERROR' ].
	stream
		space;
		nextPutAll: anError messageText
]

{ #category : 'reporting' }
HeraTextReporter >> reportEmptyFeature: aFeature [

	stream crtab: indentation.
	stream
		withAttributes: self textAttributesForError
		do: [ stream nextPutAll: 'ERROR' ].
	stream
		space;
		nextPutAll: 'There are no scenarios.'
]

{ #category : 'reporting' }
HeraTextReporter >> reportEmptyScenario: aScenario [

	stream crtab: indentation.
	stream
		withAttributes: self textAttributesForError
		do: [ stream nextPutAll: 'ERROR' ].
	stream
		space;
		nextPutAll: 'There are no steps.'
]

{ #category : 'reporting' }
HeraTextReporter >> reportEndOfBackground: aBackground [

	self decreaseIndentation
]

{ #category : 'reporting' }
HeraTextReporter >> reportEndOfBackgroundStep: aStep [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportEndOfFeature: aScenario [

	stream cr.
	self decreaseIndentation
]

{ #category : 'reporting' }
HeraTextReporter >> reportEndOfFeatures [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportEndOfRule: aRule [

	self decreaseIndentation
]

{ #category : 'reporting' }
HeraTextReporter >> reportEndOfScenario: aScenario [

	self decreaseIndentation
]

{ #category : 'reporting' }
HeraTextReporter >> reportEndOfStep: aStep [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportErrorStep: aStep withError: anError [

	stream crtab: indentation + 1.
	stream
		withAttributes: (self textAttributesForErrorFor: aStep)
		do: [ stream nextPutAll: 'ERROR' ].
	stream
		space;
		nextPutAll: anError messageText
]

{ #category : 'reporting' }
HeraTextReporter >> reportFailedStep: aStep withFailure: aFailure [

	stream crtab: indentation + 1.
	stream
		withAttributes: (self textAttributesForFailureFor: aStep)
		do: [ stream nextPutAll: 'FAILED' ].
	stream
		space;
		nextPutAll: aFailure messageText
]

{ #category : 'private - reporting' }
HeraTextReporter >> reportFeature: aFeature [

	self reportKeyword: 'Feature:'.
	stream
		space;
		nextPutAll: aFeature title
]

{ #category : 'private - reporting' }
HeraTextReporter >> reportKeyword: aString [

	stream
		withAttribute: TextEmphasis bold
		do: [ stream nextPutAll: aString ]
]

{ #category : 'reporting' }
HeraTextReporter >> reportPassedStep: aStep [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportResult: result [

	| resultMessage |
	resultMessage := 'Total: {1}. Passed: {2}. Failed: {3}. Error: {4}.' format: {
		result totalCount .
		result passedCount .
		result failedCount .
		result errorCount }.
	stream
		cr;
		nextPutAll: resultMessage;
		cr
]

{ #category : 'private - reporting' }
HeraTextReporter >> reportRule: aRule [

	self reportKeyword: 'Rule:'.
	stream
		space;
		nextPutAll: aRule title
]

{ #category : 'private - reporting' }
HeraTextReporter >> reportScenario: aScenario [

	self reportKeyword: 'Scenario:'.
	stream
		space;
		nextPutAll: aScenario title
]

{ #category : 'reporting' }
HeraTextReporter >> reportStartOfBackground: aBackground [

	stream cr; crtab: indentation.
	self reportKeyword: 'Background:'.
	self increaseIndentation
]

{ #category : 'reporting' }
HeraTextReporter >> reportStartOfBackgroundStep: aStep [

	stream
		crtab: indentation;
		nextPutAll: aStep keyword;
		space;
		nextPutAll: aStep description;
		nextPutAll: ' [Background]'.
	aStep argument ifNotNil: [ :stepArgument |
		stream cr.
		stepArgument printFormattedOn: stream indentation: indentation ]
]

{ #category : 'reporting' }
HeraTextReporter >> reportStartOfFeature: aFeature [

	reportsTags ifTrue: [
		aFeature tags do: [ :each | stream nextPut: $@; nextPutAll: each; cr ] ].
	self reportFeature: aFeature.
	self increaseIndentation.
	reportsDescriptions ifFalse: [ ^ self ].
	aFeature description ifEmpty: [ ^ self ].
	stream cr.
	aFeature description do: [ :each |
		stream cr.
		each isEmpty ifFalse: [ stream tab: indentation ].
		stream nextPutAll: each ]
]

{ #category : 'reporting' }
HeraTextReporter >> reportStartOfFeatures: features withFilter: filter [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportStartOfRule: aRule [

	stream cr; crtab: indentation.
	self reportRule: aRule.
	self increaseIndentation.
	reportsDescriptions ifFalse: [ ^ self ].
	aRule description ifEmpty: [ ^ self ].
	stream cr.
	aRule description do: [ :each |
		stream cr.
		each isEmpty ifFalse: [ stream tab: indentation ].
		stream nextPutAll: each ]
]

{ #category : 'reporting' }
HeraTextReporter >> reportStartOfScenario: aScenario [

	stream cr.
	reportsTags ifTrue: [
		aScenario tags do: [ :each | stream crtab; nextPut: $@; nextPutAll: each ] ].
	stream crtab: indentation.
	self reportScenario: aScenario.
	self increaseIndentation.
	reportsDescriptions ifFalse: [ ^ self ].
	aScenario description ifEmpty: [ ^ self ].
	stream cr.
	aScenario description do: [ :each |
		stream cr.
		each isEmpty ifFalse: [ stream tab: 2 ].
		stream nextPutAll: each ].
	stream cr
]

{ #category : 'reporting' }
HeraTextReporter >> reportStartOfStep: aStep [

	stream crtab: indentation.
	self reportStep: aStep
]

{ #category : 'private - reporting' }
HeraTextReporter >> reportStep: aStep [

	stream
		nextPutAll: aStep keyword;
		space;
		nextPutAll: aStep description.
	aStep argument ifNotNil: [ :stepArgument |
		stream cr.
		stepArgument printFormattedOn: stream indentation: indentation + 1 ]
]

{ #category : 'accessing' }
HeraTextReporter >> reportsDescriptions: aBoolean [

	reportsDescriptions := aBoolean
]

{ #category : 'accessing' }
HeraTextReporter >> reportsTags: aBoolean [

	reportsTags := aBoolean
]

{ #category : 'accessing' }
HeraTextReporter >> text [

	^ stream contents
]

{ #category : 'private - reporting' }
HeraTextReporter >> textAttributesForError [

	^ {
		TextEmphasis bold .
		TextColor new color: Color red }
]

{ #category : 'private - reporting' }
HeraTextReporter >> textAttributesForErrorFor: aStep [

	^ self textAttributesForError
]

{ #category : 'private - reporting' }
HeraTextReporter >> textAttributesForFailureFor: aStep [

	^ {
		TextEmphasis bold .
		TextColor new color: Color orange }
]
