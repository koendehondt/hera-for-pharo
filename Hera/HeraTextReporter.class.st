Class {
	#name : 'HeraTextReporter',
	#superclass : 'HeraAbstractReporter',
	#instVars : [
		'stream',
		'reportsTags',
		'reportsDescriptions'
	],
	#category : 'Hera-Reporting',
	#package : 'Hera',
	#tag : 'Reporting'
}

{ #category : 'initialization' }
HeraTextReporter >> initialize [

	super initialize.
	stream := TextStream on: (Text new: 1000).
	reportsTags := false.
	reportsDescriptions := false
]

{ #category : 'reporting' }
HeraTextReporter >> reportBackground: aBackground [

	stream cr; crtab.
	self reportKeyword: 'Background:'
]

{ #category : 'reporting' }
HeraTextReporter >> reportEmptyFeature: aFeature [

	stream crtab.
	stream
		withAttributes: self textAttributesForError
		do: [ stream nextPutAll: 'ERROR' ].
	stream
		space;
		nextPutAll: 'There are no scenarios.'
]

{ #category : 'reporting' }
HeraTextReporter >> reportEmptyScenario: aScenario [

	stream crtab: 2.
	stream
		withAttributes: self textAttributesForError
		do: [ stream nextPutAll: 'ERROR' ].
	stream
		space;
		nextPutAll: 'There are no steps.'
]

{ #category : 'reporting' }
HeraTextReporter >> reportEndOfBackgroundStep: aStep [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportEndOfFeature: aScenario [

	stream cr
]

{ #category : 'reporting' }
HeraTextReporter >> reportEndOfFeatures [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportEndOfScenario: aScenario [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportEndOfStep: aStep [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportErrorStep: aStep withError: anError [

	stream crtab: 3.
	stream
		withAttributes: (self textAttributesForErrorFor: aStep)
		do: [ stream nextPutAll: 'ERROR' ].
	stream
		space;
		nextPutAll: anError messageText
]

{ #category : 'reporting' }
HeraTextReporter >> reportFailedStep: aStep withFailure: aFailure [

	stream crtab: 3.
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
		nextPutAll: aFeature name
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
HeraTextReporter >> reportScenario: aScenario [

	self reportKeyword: 'Scenario:'.
	stream
		space;
		nextPutAll: aScenario title
]

{ #category : 'reporting' }
HeraTextReporter >> reportStartOfBackgroundStep: aStep [

	stream
		crtab: 2;
		nextPutAll: aStep keyword;
		space;
		nextPutAll: aStep description;
		nextPutAll: ' [Background]'.
	aStep argument ifNotNil: [ :stepArgument |
		stream cr.
		stepArgument printFormattedOn: stream indentation: 3 ]
]

{ #category : 'reporting' }
HeraTextReporter >> reportStartOfFeature: aFeature [

	reportsTags ifTrue: [
		aFeature tags do: [ :each | stream nextPut: $@; nextPutAll: each; cr ] ].
	self reportFeature: aFeature.
	reportsDescriptions ifFalse: [ ^ self ].
	aFeature description ifEmpty: [ ^ self ].
	stream cr.
	aFeature description do: [ :each |
		stream cr.
		each isEmpty ifFalse: [ stream tab ].
		stream nextPutAll: each ]
]

{ #category : 'reporting' }
HeraTextReporter >> reportStartOfFeatures: features withFilter: filter [

	"Do nothing."
]

{ #category : 'reporting' }
HeraTextReporter >> reportStartOfScenario: aScenario [

	stream cr.
	reportsTags ifTrue: [
		aScenario tags do: [ :each | stream crtab; nextPut: $@; nextPutAll: each ] ].
	stream crtab.
	self reportScenario: aScenario.
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

	stream crtab: 2.
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
		stepArgument printFormattedOn: stream indentation: 3 ]
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
