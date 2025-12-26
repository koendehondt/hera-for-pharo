Class {
	#name : 'HeraMatchStepDefinition',
	#superclass : 'HeraStepDefinition',
	#instVars : [
		'types',
		'preferDoubleQuotedStringArguments'
	],
	#category : 'Hera-Step definitions',
	#package : 'Hera',
	#tag : 'Step definitions'
}

{ #category : 'private' }
HeraMatchStepDefinition >> argumentConversion [
	"The conversion blocks may signal errors. They will be handled and reported by the Hera runner."

	^ Dictionary new
		add: 'string' -> [ :argument | argument ];
		add: 'word' -> [ :argument | argument ];
		add: 'int' -> [ :argument | argument asInteger ];
		add: 'float' -> [ :argument | Float readFrom: argument readStream ];
		add: '' -> [ :argument | argument ];
		add: 'date' -> [ :argument | Date readFrom: argument pattern: 'yyyy-mm-dd' ];
		add: 'date:iso' -> [ :argument | Date readFrom: argument pattern: 'yyyy-mm-dd' ];
		add: 'date:dmy' -> [ :argument | Date readFrom: argument pattern: 'dd/mm/yyyy' ];
		add: 'date:mdy' -> [ :argument | Date readFrom: argument pattern: 'mm/dd/yyyy' ];
		add: 'date:ymd' -> [ :argument | Date readFrom: argument pattern: 'yyyy/mm/dd' ];
		add: 'time' -> [ :argument | Time fromString: argument ];
		add: 'time:24h' -> [ :argument | Time fromString: argument ];
		add: 'time:12h' -> [ :argument | Time fromString: argument ];
		add: 'timestamp' -> [ :argument | DateAndTime readFrom: argument readStream ];
		yourself
]

{ #category : 'private' }
HeraMatchStepDefinition >> argumentTypesIn: aPatternString [

	| matcher |
	matcher := RxMatcher forString: '{[^{]*}'.
	^ (matcher matchesIn: aPatternString) collect: [ :each | each copyFrom: 2 to: each size - 1 ]
]

{ #category : 'initialization' }
HeraMatchStepDefinition >> initialize [

	super initialize.
	preferDoubleQuotedStringArguments := true
]

{ #category : 'matching' }
HeraMatchStepDefinition >> match: aStepDescription [

	| matcher matches regex lastMatchEnd |
	types := self argumentTypesIn: pattern.
	regex := pattern format: self supportedArguments.
	regex := (RxMatcher forString: '<[^>]+>') copy: regex replacingMatchesWith: '.+'.
	regex := regex copyReplaceAll: ':' with: '\:'.
	matcher := RxMatcher forString: regex.
	(matcher matches: aStepDescription) ifFalse: [ ^ nil ].
	matcher subexpressionCount < 2 ifTrue: [ ^ nil ].
	matches := OrderedCollection with: (matcher subexpression: 2).
	lastMatchEnd := (matcher subEnd: 2) first.
	3 to: matcher subexpressionCount do: [ :index | | begin |
		begin := matcher subBeginning: index.
		(begin isNotEmpty and: [ begin first > lastMatchEnd ]) ifTrue: [
			lastMatchEnd := (matcher subEnd: index) first.
			matches add: (matcher subexpression: index) ] ].
	^ self typeConvert: matches asArray
]

{ #category : 'accessing' }
HeraMatchStepDefinition >> preferSingleQuotedStringArguments [

	preferDoubleQuotedStringArguments := false
	
]

{ #category : 'private' }
HeraMatchStepDefinition >> supportedArguments [
	"Hera supports a subset of the parameter types defined by Cucumber. See https://github.com/cucumber/cucumber-expressions.
	 Some Cucumber expressions are not useful in Pharo. Therefore Hera does not support them.
	 Hera adds date, time and timestamp parameter types."

	| quotedStringRegex |
	self flag: 'The regex for float may be too strict. RxMatcher does not support non-capturing groups, like (-?\d+(?:\.\d+))'.
	quotedStringRegex := preferDoubleQuotedStringArguments ifTrue: [ '"([^"]*)"' ] ifFalse: [ '''([^'']*)''' ].
	^ Dictionary new
		add: 'string' -> quotedStringRegex;
		add: 'word' -> '(\w+)';
		add: 'int' -> '(-?\d+)';
		add: 'float' -> '(-?\d+\.\d+)';
		add: '' -> '(.*)';
		add: 'date' -> '(\d\d\d\d\-\d\d\-\d\d)';
		add: 'date:iso' -> '(\d\d\d\d\-\d\d\-\d\d)';
		add: 'date:dmy' -> '(\d\d/\d\d/\d\d\d\d)';
		add: 'date:mdy' -> '(\d\d/\d\d/\d\d\d\d)';
		add: 'date:ymd' -> '(\d\d\d\d/\d\d/\d\d)';
		"The regexes below are not valid. The colons will be escaped by #match:."
		add: 'time' -> '(\d\d:\d\d(:\d\d)?)';
		add: 'time:24h' -> '(\d\d:\d\d(:\d\d)?)';
		add: 'time:12h' -> '(\d?\d:\d\d(:\d\d)?\s?(AM|PM|am|pm))';
		add: 'timestamp' -> '(\d\d\d\d\-\d\d\-\d\dT\d\d:\d\d:\d\d(([+-]\d\d:\d\d)|Z))';
		yourself
]

{ #category : 'private' }
HeraMatchStepDefinition >> typeConvert: aMatchedStringCollection [

	^ aMatchedStringCollection withIndexCollect: [ :each :index | | converter |
		converter := self argumentConversion at: (types at: index).
		converter value: each ]
]
