Class {
	#name : 'HeraGherkinParser',
	#superclass : 'Object',
	#instVars : [
		'source',
		'scanner',
		'currentToken',
		'nextToken',
		'previousToken',
		'parseError'
	],
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'parsing' }
HeraGherkinParser >> dataValuesFrom: aDataTableToken [

	| concatenatedValues |
	concatenatedValues := aDataTableToken text.
	concatenatedValues last = $| ifFalse: [ self parseError: 'Data table row not closed with |.' ].
	^ ($| split: concatenatedValues allButLast) collect: [ :each | each trimBoth ] as: Array
]

{ #category : 'initialization' }
HeraGherkinParser >> initializeParserWith: aTextOrString [

	source := aTextOrString asString.
	scanner := HeraGherkinScanner on: (ReadStream on: source).
	currentToken := HeraEndOfLineToken new
]

{ #category : 'parsing' }
HeraGherkinParser >> nextToken [

	previousToken := currentToken.
	currentToken := scanner scanToken.
	^ currentToken
]

{ #category : 'parsing' }
HeraGherkinParser >> parseBackground [

	| start end steps |
	currentToken isBackgroundToken ifFalse: [ ^ nil ].
	start := currentToken start.
	end := currentToken end.
	self nextToken.
	currentToken isEndOfLineToken ifFalse: [ self parseError: 'Text after Background: is not allowed.' ].
	self nextToken.
	steps := self parseStepsRestricted: [ :stepToken |
		stepToken isAllowedInBackground ifFalse: [ self parseError: 'This step is not allowed in Background:.' ] ].
	^ HeraBackgroundAstNode new
		steps: steps;
		start: start;
		end: end
]

{ #category : 'parsing' }
HeraGherkinParser >> parseDataTableStepArgument [

	"DataTableToken has already been read."
	| rows rowSizes end skippedEmptyLines start |
	start := currentToken start.
	rowSizes := Set new.
	rows := OrderedCollection new.
	skippedEmptyLines := false.
	[ currentToken isDataTableToken ] whileTrue: [ | cellValues |
		cellValues := self dataValuesFrom: currentToken.
		rowSizes add: cellValues size.
		rows add: cellValues.
		end := currentToken end.
		self nextToken. "Read end of line"
		skippedEmptyLines := skippedEmptyLines or: [ self skipEmptyLines ] ].
	rows ifEmpty: [ ^ nil ].
	skippedEmptyLines ifTrue: [ self parseError: 'Empty lines in data tables are not allowed.' ].
	rowSizes size > 1 ifTrue: [ self parseError: 'Data table has missing cells.' ].
	^ HeraDataTableStepArgumentAstNode new
		dataTable: (HeraDataTable new data: rows asArray);
		start: start;
		end: end
]

{ #category : 'parsing' }
HeraGherkinParser >> parseDescription [

	| lines start end |
	lines := OrderedCollection new.
	self skipEmptyLines.
	currentToken isEndOfFileToken ifTrue: [ ^ nil ].
	start := currentToken start.
	[ currentToken isTextToken or: [ currentToken isEndOfLineToken ] ] whileTrue: [ | line |
		currentToken isTextToken
			ifTrue: [
				line := currentToken text.
				end := currentToken end.
				self skipEndOfLineToken.
				lines add: line ]
			ifFalse: [ previousToken isEndOfLineToken
							ifTrue: [ lines add: '' ] ].
		self nextToken ].
	(lines isNotEmpty and: [ lines last isEmpty ]) ifTrue: [ lines removeLast ].
	lines ifEmpty:  [^ nil ].
	^ HeraDescriptionAstNode new
		lines: lines;
		start: start;
		end: end
]

{ #category : 'parsing' }
HeraGherkinParser >> parseDocStringStepArgument [

	| unindentedLines docStringToken |
	docStringToken := currentToken.
	unindentedLines := self removeIndentation: docStringToken indentation from: docStringToken lines.
	self skipEmptyLines.
	^ HeraDocStringStepArgumentAstNode new
		docString: (HeraDocString new lines: unindentedLines asArray);
		start: docStringToken start;
		end: docStringToken end
]

{ #category : 'parsing' }
HeraGherkinParser >> parseError [

	^ parseError
]

{ #category : 'parsing' }
HeraGherkinParser >> parseError: aString [

	parseError := aString.
	HeraGherkinParsingError signal: aString
]

{ #category : 'parsing' }
HeraGherkinParser >> parseFeature [

	| name featureNode tags start description scenarios nameToken background |
	[
		self skipEmptyLines.
		tags := self parseTags.
		currentToken isFeatureToken ifFalse: [ self parseError: '"Feature:" expected.' ].
		start := currentToken start.
		nameToken := self nextToken.
		nameToken isTextToken ifFalse: [ self parseError: 'Feature name expected.' ].
		name := nameToken text.
		self nextToken.
		description := nil.
		scenarios := OrderedCollection new.
		currentToken isEndOfFileToken ifFalse: [ description := self parseDescription ].
		currentToken isEndOfFileToken ifFalse: [ background := self parseBackground ].
		currentToken isEndOfFileToken ifFalse: [ scenarios := self parseScenarios ].
		currentToken isEndOfFileToken ifFalse: [ self parseError: '"Scenario:" expected.' ].
		featureNode := HeraFeatureAstNode new.
		featureNode
			name: name;
			tags: tags;
			description: description;
			background: background;
			scenarios: scenarios;
			start: start;
			end: scanner position.
	] on: HeraGherkinParsingError do: [ ^ nil ].
	^ featureNode
]

{ #category : 'parsing' }
HeraGherkinParser >> parseScenario [

	| scenarioNode tags description steps titleToken start |
	"scenarioToken or tagToken has already been read."
	tags := self parseTags.
	start := currentToken start.
	titleToken := self nextToken.
	titleToken isTextToken ifFalse: [ self parseError: 'Scenario title expected.' ].
	self skipEndOfLineToken.
	description := nil.
	steps := OrderedCollection new.
	currentToken isEndOfFileToken ifFalse: [ description := self parseDescription ].
	currentToken isEndOfFileToken ifFalse: [
		steps := self parseStepsRestricted: [ :ignore | ] ].
	scenarioNode := HeraScenarioAstNode new.
	scenarioNode
		tags: tags;
		title: titleToken text;
		description: description;
		steps: steps;
		start: start;
		end: scanner position.
	^ scenarioNode
]

{ #category : 'parsing' }
HeraGherkinParser >> parseScenarios [

	| scenarioNodes |
	scenarioNodes := OrderedCollection new.
	[ currentToken isScenarioToken or: [ currentToken isTagToken ] ] whileTrue: [
		scenarioNodes add: self parseScenario ].
	^ scenarioNodes
]

{ #category : 'parsing' }
HeraGherkinParser >> parseStep [

	"The step token has already been read."
	| stepNode token start description end |
	stepNode := currentToken stepAstNodeClass new.
	start := currentToken start.
	token := self nextToken.
	token isTextToken ifFalse: [ self parseError: 'Step description expected.' ].
	description := token text.
	end := token end.
	stepNode
		description: description;
		start: start;
		end: end.
	self skipEndOfLineToken.
	scanner skipWhiteSpace.
	self nextToken.
	self parseStepArgument ifNotNil: [ :argumentAstNode |
		stepNode
			argument: argumentAstNode;
			end: argumentAstNode end ].
	^ stepNode
]

{ #category : 'parsing' }
HeraGherkinParser >> parseStepArgument [

	"The first token has already been read."
	currentToken isDataTableToken ifTrue: [ ^ self parseDataTableStepArgument ].
	currentToken isDocStringToken ifTrue: [ ^ self parseDocStringStepArgument ].
	^ nil
]

{ #category : 'parsing' }
HeraGherkinParser >> parseStepsRestricted: aBlock [

	| stepNodes |
	stepNodes := OrderedCollection new.
	[ currentToken isStepToken ] whileTrue: [ | stepNode |
		aBlock value: currentToken.
		stepNode := self parseStep.
		stepNodes add: stepNode.
		currentToken isEndOfLineToken ifTrue: [ self skipEmptyLines ] ].
	(currentToken isEndOfFileToken or: [ currentToken isScenarioToken ])
		ifFalse: [ self parseError: 'Step, step argument, or scenario expected.' ].
	^ stepNodes
]

{ #category : 'parsing' }
HeraGherkinParser >> parseTags [

	| tags start |
	tags := OrderedCollection new.
	[ currentToken isTagToken ] whileTrue: [ | tagNode |
		tagNode := HeraTagAstNode named: currentToken text.
		tagNode start: currentToken start; end: currentToken end.
		tags add: tagNode.
		self skipEndOfLineToken.
		self nextToken.
		start := scanner position ].
	^ tags asArray
]

{ #category : 'parsing' }
HeraGherkinParser >> removeIndentation: indentation from: lines [

	| tabs unindentedLines |
	tabs := String new: indentation withAll: Character tab.
	unindentedLines := OrderedCollection new.
	lines first ifNotEmpty: [ self parseError: 'Text after """ is not allowed.' ].
	(scanner lineDoesNotStartWithThreeDoubleQuotes: lines last) ifTrue: [ self parseError: 'Doc string is not closed with """.' ].
	lines allButFirstDo: [ :eachLine |
		(eachLine copyFrom: 1 to: indentation) = tabs
			ifFalse: [ self parseError: 'Inconsistent indentation of doc string.' ].
		unindentedLines add: (eachLine copyFrom: indentation + 1 to: eachLine size) ].
	unindentedLines last size > 3 ifTrue: [ self parseError: 'Text after """ is not allowed.' ].
	unindentedLines removeLast.
	^ unindentedLines
]

{ #category : 'parsing' }
HeraGherkinParser >> skipEmptyLines [

	| skippedEmptyLines |
	skippedEmptyLines := false.
	[
		| foundEmptyLine |
		foundEmptyLine := self nextToken isEndOfLineToken and: [ previousToken isEndOfLineToken ].
		skippedEmptyLines := skippedEmptyLines or: [ foundEmptyLine ].
		foundEmptyLine ] whileTrue.
	^ skippedEmptyLines
]

{ #category : 'parsing' }
HeraGherkinParser >> skipEndOfLineToken [

	self nextToken.
	currentToken isEndOfFileToken ifTrue: [ ^ self ].
	currentToken isEndOfLineToken ifTrue: [ ^ self ].
	self flag: 'This is an internal errror. It should not bubble up to the user of the receiver.'.
	self parseError: 'End of line expected.'
]
