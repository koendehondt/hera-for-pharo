Class {
	#name : 'HeraTextReporter',
	#superclass : 'HeraReporter',
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
	reportsTags := true.
	reportsDescriptions := true.
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
HeraTextReporter >> reportErrorScenario: aScenario [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportErrorStep: aStep of: aScenario withError: anError [

	stream crtab: indentation + 1.
	stream
		withAttributes: (self textAttributesForErrorFor: aStep of: aScenario)
		do: [ stream nextPutAll: 'ERROR' ].
	stream
		space;
		nextPutAll: anError messageText
]

{ #category : 'reporting' }
HeraTextReporter >> reportFailedScenario: aScenario [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportFailedStep: aStep of: aScenario withFailure: aFailure [

	stream crtab: indentation + 1.
	stream
		withAttributes: (self textAttributesForFailureFor: aStep of: aScenario)
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
HeraTextReporter >> reportPassedScenario: aScenario [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportPassedStep: aStep [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportResult: result [

	| resultMessage durationInSeconds humanreadableDuration duration |
	duration := result duration.
	durationInSeconds := result duration asSeconds.
	humanreadableDuration := durationInSeconds < 60
		ifTrue: [ '' ]
		ifFalse: [ '({1})' format: { Hera settings humanReadableDuration: duration } ].
	resultMessage := 'Total: {1} {2}. Passed: {3}. Failed: {4}. Error: {5}. Duration: {6}{7}.' format: {
		result totalCount .
		result totalCount = 1 ifTrue: [ 'scenario' ] ifFalse: [ 'scenarios' ] .
		result passedCount .
		result failedCount .
		result errorCount .
		('second' heraPluralizeFor: durationInSeconds) .
		humanreadableDuration}.
	stream
		cr;
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
	self increaseIndentation.
	reportsDescriptions ifFalse: [ ^ self ].
	aBackground description ifEmpty: [ ^ self ].
	stream cr.
	aBackground description do: [ :each |
		stream cr.
		each isEmpty ifFalse: [ stream tab: 2 ].
		stream nextPutAll: each ].
	stream cr
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
		stepArgument printFormattedOn: stream indentation: indentation + 1 ]
]

{ #category : 'reporting' }
HeraTextReporter >> reportStartOfFeature: aFeature in: anAcceptanceTest [

	stream cr; cr.
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
HeraTextReporter >> reportStartOfFeatures: totalFeatureCount [

	stream
		nextPutAll: 'Running';
		space;
		print: totalFeatureCount;
		space;
		nextPutAll: (totalFeatureCount = 1 ifTrue: ['feature'] ifFalse: ['features']);
		nextPut: $.;
		cr
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

{ #category : 'reporting' }
HeraTextReporter >> reportSuppressed [

	stream nextPutAll: ' [suppressed]'
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
		TextColor new color: Hera settings errorResultColor }
]

{ #category : 'private - reporting' }
HeraTextReporter >> textAttributesForErrorFor: aStep of: aScenario [

	^ self textAttributesForError
]

{ #category : 'private - reporting' }
HeraTextReporter >> textAttributesForFailureFor: aStep of: aScenario [

	^ {
		TextEmphasis bold .
		TextColor new color: Hera settings failedResultColor }
]
