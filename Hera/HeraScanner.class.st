Class {
	#name : 'HeraScanner',
	#superclass : 'Object',
	#instVars : [
		'stream',
		'nextToken',
		'indexOfCurrentLine'
	],
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'instance creation' }
HeraScanner class >> on: aStream [

	^ self new on: aStream
]

{ #category : 'scanning' }
HeraScanner >> lineDoesNotStartWithThreeDoubleQuotes: aLineString [

	^ (aLineString trimLeft copy indexOfSubCollection: '"""' startingAt: 1 ifAbsent: [ 0 ]) = 0
]

{ #category : 'initialization' }
HeraScanner >> on: aStream [

	stream := aStream.
	indexOfCurrentLine := 1
]

{ #category : 'accessing' }
HeraScanner >> position [

	^ stream position
]

{ #category : 'scanning' }
HeraScanner >> scanDocStringLinesFor: aDocStringToken [
	"Scan the whole doc string after the opening triple quotes upto the last character on the line with the closing triple quotes, and store the string as separate lines in the given token."

	| lines line end |
	lines := OrderedCollection new.
	[
		line := stream nextLine.
		line isNotNil and: [ self lineDoesNotStartWithThreeDoubleQuotes: line ] ] whileTrue: [ lines add: line ].
	line ifNotNil: [ lines add: line ].
	aDocStringToken lines: lines.
	end := stream atEnd ifTrue: [ self position ] ifFalse: [ self position - 1 ].
	aDocStringToken end: end
]

{ #category : 'scanning' }
HeraScanner >> scanToken [

	| alreadyReadToken start |
	alreadyReadToken := nextToken.
	nextToken := nil.
	alreadyReadToken ifNotNil: [
		alreadyReadToken isEndOfLineToken ifTrue: [ self startLine ].
		^ alreadyReadToken ].
	stream atEnd ifTrue: [
		^ HeraEndOfFileToken new start: stream position ].
	self skipWhiteSpace.
	start := stream position + 1.
	(self tryScanToken: '@') ifTrue: [ | line tagText |
		line := stream nextLine.
		line
			ifNil: [ tagText := '' ]
			ifNotNil: [ nextToken := HeraEndOfLineToken new start: stream position ].
		tagText := line ifNil: [ '' ] ifNotNil: [ line trimRight ].
		^ HeraTagToken new text: tagText trimRight; start: start; end: start + tagText size ].
	self tryScanToken: HeraFeatureToken ifFound: [ :token | ^ token ].
	self tryScanToken: HeraRuleToken ifFound: [ :token | ^ token ].
	self tryScanToken: HeraBackgroundToken ifFound: [ :token | ^ token ].
	self tryScanToken: HeraScenarioToken ifFound: [ :token | ^ token ].
	self tryScanStepToken: HeraGivenToken ifFound: [ :token | ^ token ].
	self tryScanStepToken: HeraWhenToken ifFound: [ :token | ^ token ].
	self tryScanStepToken: HeraThenToken ifFound: [ :token | ^ token ].
	self tryScanStepToken: HeraAndToken ifFound: [ :token | ^ token ].
	self tryScanStepToken: HeraButToken ifFound: [ :token | ^ token ].
	self tryScanStepToken: HeraStarToken ifFound: [ :token | ^ token ].
	self tryScanToken: HeraDataTableToken ifFound: [ :token |
		start := stream position.
		^ stream nextLine
			ifNil: [ token ]
			ifNotNil: [ :line | | trimmedLine |
				trimmedLine := line trimRight.
				trimmedLine isEmpty ifTrue: [
					self startLine.
					^ HeraEndOfLineToken new start: stream position ].
				nextToken := stream atEnd
					ifTrue: [ HeraEndOfFileToken new start: stream position + 1 ]
					ifFalse: [ HeraEndOfLineToken new start: stream position ].
				token text: trimmedLine; start: start; end: start + trimmedLine size ] ].
	self tryScanToken: HeraDocStringToken ifFound: [ :token |
		token indentation: token start - indexOfCurrentLine.
		self scanDocStringLinesFor: token.
		^ token ].
	^ self tryScanTextToken
]

{ #category : 'scanning' }
HeraScanner >> skipWhiteSpace [

	[ (stream peekFor: Character space) or: [ stream peekFor: Character tab ] ] whileTrue
]

{ #category : 'scanning' }
HeraScanner >> startLine [

	indexOfCurrentLine := stream position + 1
]

{ #category : 'scanning' }
HeraScanner >> tryScanStepToken: aTokenClass ifFound: aBlock [

	| start tokenString end |
	tokenString := aTokenClass keyword.
	start := stream position + 1.
	(tokenString allSatisfy: [ :each | stream peekFor: each ]) ifTrue: [
		| nextChar |
		end := start + tokenString size - 1.
		nextChar := stream peek.
		(nextChar isNil or: [ nextChar isLetter not and: [ nextChar isDigit not ] ]) ifTrue: [
			aBlock value: (aTokenClass new start: start; end: end).
			^ self ] ].
	stream position: start - 1
]

{ #category : 'scanning' }
HeraScanner >> tryScanTextToken [

	| start |
	self skipWhiteSpace.
	start := stream position + 1.
	stream nextLine ifNotNil: [ :line | | trimmedLine |
		trimmedLine := line trimRight.
		trimmedLine isEmpty ifTrue: [
			self startLine.
			^ HeraEndOfLineToken new start: stream position ].
		nextToken := stream atEnd
			ifTrue: [ HeraEndOfFileToken new start: stream position + 1 ]
			ifFalse: [ HeraEndOfLineToken new start: stream position ].
		^ HeraTextToken new text: trimmedLine; start: start; end: start + trimmedLine size - 1 ].
	^ HeraEndOfFileToken new start: stream position + 1
]

{ #category : 'scanning' }
HeraScanner >> tryScanToken: aString [

	| oldPosition |
	oldPosition := stream position.
	(aString allSatisfy: [ :each | stream peekFor: each ]) ifTrue: [ ^ true].
	stream position: oldPosition.
	^ false
]

{ #category : 'scanning' }
HeraScanner >> tryScanToken: aTokenClass ifFound: aBlock [

	| start tokenString end |
	tokenString := aTokenClass keyword.
	start := stream position + 1.
	(tokenString allSatisfy: [ :each | stream peekFor: each ]) ifTrue: [
		end := start + tokenString size - 1.
		aBlock value: (aTokenClass new start: start; end: end).
		^ self ].
	stream position: start - 1
]
