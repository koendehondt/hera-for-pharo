Class {
	#name : 'HeraParser',
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
HeraParser >> dataValuesFrom: aDataTableToken [

	| concatenatedValues |
	concatenatedValues := aDataTableToken text.
	concatenatedValues last = $| ifTrue: [
		^ ($| split: concatenatedValues allButLast) collect: [ :each | each trimBoth ] as: Array ].
	self parseError: 'Data table row not closed with |' from: aDataTableToken end to: aDataTableToken end
]

{ #category : 'initialization' }
HeraParser >> initializeParserWith: aTextOrString [

	scanner := HeraScanner on: (ReadStream on: aTextOrString asString).
	currentToken := HeraEndOfLineToken new start: 1
]

{ #category : 'parsing' }
HeraParser >> nextToken [

	previousToken := currentToken.
	currentToken := scanner scanToken.
	^ currentToken
]

{ #category : 'parsing' }
HeraParser >> parseBackground [

	| start end steps |
	currentToken isBackgroundToken ifFalse: [ ^ nil ].
	start := currentToken start.
	end := currentToken end.
	self nextToken.
	(currentToken isEndOfFileToken or: [ currentToken isEndOfLineToken ]) ifFalse: [
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
HeraParser >> parseDataTableStepArgument [

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
HeraParser >> parseDescription [

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
HeraParser >> parseDocStringStepArgument [

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
HeraParser >> parseError [

	^ parseError
]

{ #category : 'parsing' }
HeraParser >> parseError: aString from: sourceStartIndex to: sourceEndIndex [

	parseError := HeraParsingError new
		start: sourceStartIndex;
		end: sourceEndIndex.
	parseError signal: aString
]

{ #category : 'parsing' }
HeraParser >> parseFeature [

	| title featureNode tags description scenarios titleToken background featureToken rules |
	[
		self skipEmptyLines.
		tags := self parseTags.
		currentToken isFeatureToken ifFalse: [
			self parseError: 'Feature keyword expected' from: currentToken start to: currentToken end ].
		featureToken := currentToken.
		titleToken := self tryScanTextToken.
		titleToken isTextToken ifFalse: [
			self parseError: 'Feature name expected after feature keyword' from: featureToken start to: featureToken end ].
		title := HeraTitleAstNode new
			text: titleToken text;
			start: titleToken start;
			end: titleToken end.
		self nextToken.
		description := nil.
		rules := OrderedCollection new.
		scenarios := OrderedCollection new.
		currentToken isEndOfFileToken ifFalse: [ description := self parseDescription ].
		currentToken isEndOfFileToken ifFalse: [ background := self parseBackground ].
		currentToken isEndOfFileToken ifFalse: [ scenarios := self parseScenarios ].
		currentToken isEndOfFileToken ifFalse: [ rules := self parseRules ].
		currentToken isEndOfFileToken ifFalse: [
			self parseError: 'Scenario keyword expected' from: currentToken start to: currentToken end ].
		featureNode := HeraFeatureAstNode new.
		featureNode
			title: title;
			tags: tags;
			description: description;
			background: background;
			scenarios: scenarios;
			rules: rules;
			start: featureToken start;
			end: scanner position.
	] on: HeraParsingError do: [ ^ nil ].
	^ featureNode
]

{ #category : 'parsing' }
HeraParser >> parseRule [

	| ruleNode description scenarios titleToken ruleToken title background |
	"ruleToken has already been read."
	ruleToken := currentToken.
	titleToken := self tryScanTextToken.
	titleToken isTextToken ifFalse: [
		self parseError: 'Rule title expected after rule keyword' from: ruleToken start to: ruleToken end ].
	title := HeraTitleAstNode new
		text: titleToken text;
		start: titleToken start;
		end: titleToken end.
	self skipEndOfLineToken.
	description := nil.
	scenarios := OrderedCollection new.
	currentToken isEndOfFileToken ifFalse: [ description := self parseDescription ].
	currentToken isEndOfFileToken ifFalse: [ background := self parseBackground ].
	currentToken isEndOfFileToken ifFalse: [ scenarios := self parseScenarios ].
	ruleNode := HeraRuleAstNode new.
	ruleNode
		title: title;
		description: description;
		background: background;
		scenarios: scenarios;
		start: ruleToken start;
		end: scanner position.
	^ ruleNode
]

{ #category : 'parsing' }
HeraParser >> parseRules [

	| ruleNodes |
	ruleNodes := OrderedCollection new.
	[ currentToken isRuleToken ] whileTrue: [ ruleNodes add: self parseRule ].
	^ ruleNodes
]

{ #category : 'parsing' }
HeraParser >> parseScenario [

	| scenarioNode tags description steps titleToken scenarioToken title |
	"scenarioToken or tagToken has already been read."
	tags := self parseTags.
	currentToken isScenarioToken 
		ifFalse: [ self parseError: 'Scenario keyword expected' from: currentToken start to: currentToken end ].
	scenarioToken := currentToken.
	titleToken := self tryScanTextToken.
	titleToken isTextToken ifFalse: [
		self parseError: 'Scenario title expected after scenario keyword' from: scenarioToken start to: scenarioToken end ].
	title := HeraTitleAstNode new
		text: titleToken text;
		start: titleToken start;
		end: titleToken end.
	self skipEndOfLineToken.
	description := nil.
	steps := OrderedCollection new.
	currentToken isEndOfFileToken ifFalse: [ description := self parseDescription ].
	currentToken isEndOfFileToken ifFalse: [
		steps := self parseStepsRestricted: [ :ignore | ] ].
	scenarioNode := HeraScenarioAstNode new.
	scenarioNode
		tags: tags;
		title: title;
		description: description;
		steps: steps;
		start: scenarioToken start;
		end: scanner position.
	^ scenarioNode
]

{ #category : 'parsing' }
HeraParser >> parseScenarios [

	| scenarioNodes |
	scenarioNodes := OrderedCollection new.
	[ currentToken isScenarioToken or: [ currentToken isTagToken ] ] whileTrue: [
		scenarioNodes add: self parseScenario ].
	^ scenarioNodes
]

{ #category : 'parsing' }
HeraParser >> parseStep [

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
HeraParser >> parseStepArgument [

	"The first token has already been read."
	currentToken isDataTableToken ifTrue: [ ^ self parseDataTableStepArgument ].
	currentToken isDocStringToken ifTrue: [ ^ self parseDocStringStepArgument ].
	^ nil
]

{ #category : 'parsing' }
HeraParser >> parseStepsRestricted: aBlock [

	| stepNodes |
	stepNodes := OrderedCollection new.
	[ currentToken isStepToken ] whileTrue: [ | stepNode |
		aBlock value: currentToken.
		stepNode := self parseStep.
		stepNodes add: stepNode.
		currentToken isEndOfLineToken ifTrue: [ self skipEmptyLines ] ].
	(currentToken isEndOfFileToken or: [ currentToken isRuleToken or: [ currentToken isTagToken or: [ currentToken isScenarioToken ] ] ])
		ifFalse: [ self parseError: 'Step, step argument, or scenario expected' from: currentToken start to: currentToken end ].
	^ stepNodes
]

{ #category : 'parsing' }
HeraParser >> parseTags [

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
HeraParser >> removeIndentation: docStringToken [

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
HeraParser >> skipEmptyLines [

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
HeraParser >> skipEndOfLineToken [

	self nextToken.
	currentToken isEndOfFileToken ifTrue: [ ^ self ].
	currentToken isEndOfLineToken ifTrue: [ ^ self ].
	self flag: 'This is an internal errror. It should not bubble up to the user of the receiver.'.
	self parseError: 'End of line expected' from: currentToken start to: currentToken end
]

{ #category : 'parsing' }
HeraParser >> tryScanTextToken [

	previousToken := currentToken.
	currentToken := scanner tryScanTextToken.
	^ currentToken
]
