Class {
	#name : 'HeraGherkinParser',
	#superclass : 'Object',
	#instVars : [
		'scanner',
		'currentToken',
		'previousToken',
		'parseError'
	],
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'parsing' }
HeraGherkinParser >> dataValuesFrom: aDataTableToken [

	| concatenatedValues |
	concatenatedValues := aDataTableToken text.
	concatenatedValues last = $| ifTrue: [
		^ ($| split: concatenatedValues allButLast) collect: [ :each | each trimBoth ] as: Array ].
	self parseError: 'Data table row not closed with |' from: aDataTableToken end to: aDataTableToken end
]

{ #category : 'initialization' }
HeraGherkinParser >> initializeParserWith: aTextOrString [

	scanner := HeraGherkinScanner on: (ReadStream on: aTextOrString asString).
	currentToken := HeraEndOfLineToken new start: 1
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
	currentToken isEndOfLineToken ifFalse: [
		self parseError: 'Text after background keyword is not allowed' from: start to: end ].
	self nextToken.
	steps := self parseStepsRestricted: [ :stepToken |
		stepToken isAllowedInBackground ifFalse: [
			self parseError: 'This step is not allowed in a background' from: stepToken start to: stepToken end ] ].
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
	skippedEmptyLines ifTrue: [
		self parseError: 'Empty lines in data tables are not allowed' from: start to: end ].
	rowSizes size > 1 ifTrue: [
		self parseError: 'Data table has missing cells' from: start to: end ].
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
	unindentedLines := self removeIndentation: docStringToken.
	self skipEmptyLines.
	^ HeraDocStringStepArgumentAstNode new
		docString: (HeraDocString new lines: unindentedLines asArray);
		start: docStringToken start;
		end: docStringToken end
]

{ #category : 'accessing' }
HeraGherkinParser >> parseError [

	^ parseError
]

{ #category : 'parsing' }
HeraGherkinParser >> parseError: aString from: sourceStartIndex to: sourceEndIndex [

	parseError := HeraGherkinParsingError new
		start: sourceStartIndex;
		end: sourceEndIndex.
	parseError signal: aString
]

{ #category : 'parsing' }
HeraGherkinParser >> parseFeature [

	| name featureNode tags description scenarios nameToken background featureToken |
	[
		self skipEmptyLines.
		tags := self parseTags.
		currentToken isFeatureToken ifFalse: [
			self parseError: 'Feature keyword expected' from: currentToken start to: currentToken end ].
		featureToken := currentToken.
		nameToken := self tryScanTextToken.
		nameToken isTextToken ifFalse: [
			self parseError: 'Feature name expected after feature keyword' from: featureToken start to: featureToken end ].
		name := nameToken text.
		self nextToken.
		description := nil.
		scenarios := OrderedCollection new.
		currentToken isEndOfFileToken ifFalse: [ description := self parseDescription ].
		currentToken isEndOfFileToken ifFalse: [ background := self parseBackground ].
		currentToken isEndOfFileToken ifFalse: [ scenarios := self parseScenarios ].
		currentToken isEndOfFileToken ifFalse: [
			self parseError: 'Scenario keyword expected' from: currentToken start to: currentToken end ].
		featureNode := HeraFeatureAstNode new.
		featureNode
			name: name;
			tags: tags;
			description: description;
			background: background;
			scenarios: scenarios;
			start: featureToken start;
			end: scanner position.
	] on: HeraGherkinParsingError do: [ ^ nil ].
	^ featureNode
]

{ #category : 'parsing' }
HeraGherkinParser >> parseScenario [

	| scenarioNode tags description steps titleToken scenarioToken |
	"scenarioToken or tagToken has already been read."
	tags := self parseTags.
	scenarioToken := currentToken.
	titleToken := self tryScanTextToken.
	titleToken isTextToken ifFalse: [
		self parseError: 'Scenario title expected after scenario keyword' from: scenarioToken start to: scenarioToken end ].
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
		start: scenarioToken start;
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
	| stepNode description stepToken |
	stepNode := currentToken stepAstNodeClass new.
	stepToken := currentToken.
	self nextToken.
	currentToken isTextToken ifFalse: [
		self parseError: 'Step description expected after step keyword' from: stepToken start to: stepToken end ].
	description := currentToken text.
	stepNode
		description: description;
		start: stepToken start;
		end: currentToken end.
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
		ifFalse: [ self parseError: 'Step, step argument, or scenario expected' from: currentToken start to: currentToken end ].
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
HeraGherkinParser >> removeIndentation: docStringToken [

	| tabs unindentedLines indentation lines |
	indentation := docStringToken indentation.
	lines := docStringToken lines.
	tabs := String new: indentation withAll: Character tab.
	unindentedLines := OrderedCollection new.
	lines first ifNotEmpty: [
		self parseError: 'Text after """ is not allowed' from: docStringToken start + 3 to: docStringToken start + 2 + lines first size ].
	(scanner lineDoesNotStartWithThreeDoubleQuotes: lines last) ifTrue: [
		self parseError: 'Doc string is not closed with """' from: docStringToken start to: docStringToken end ].
	lines allButFirstDo: [ :eachLine |
		(eachLine copyFrom: 1 to: indentation) = tabs ifFalse: [
			self parseError: 'Inconsistent indentation of doc string' from: docStringToken start to: docStringToken end ].
		unindentedLines add: (eachLine copyFrom: indentation + 1 to: eachLine size) ].
	unindentedLines last size > 3 ifTrue: [
			self parseError: 'Text after """ is not allowed' from: docStringToken end - unindentedLines last size + 4 to: docStringToken end ].
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
	self parseError: 'End of line expected' from: currentToken start to: currentToken end
]

{ #category : 'parsing' }
HeraGherkinParser >> tryScanTextToken [

	previousToken := currentToken.
	currentToken := scanner tryScanTextToken.
	^ currentToken
]
