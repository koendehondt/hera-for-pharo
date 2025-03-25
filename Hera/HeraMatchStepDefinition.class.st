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

	^ Dictionary
		with: 'string' -> [ :argument | argument ]
		with: 'word' -> [ :argument | argument ]
		with: 'int' -> [ :argument | argument asInteger ]
		with: 'float' -> [ :argument | Float readFrom: argument readStream ]
		with: '' -> [ :argument | argument ]
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

	| matcher matches regex |
	types := self argumentTypesIn: pattern.
	regex := pattern format: self supportedArguments.
	matcher := RxMatcher forString: regex.
	(matcher matches: aStepDescription) ifFalse: [ ^ nil ].
	matches := (2 to: matcher subexpressionCount) collect: [ :index | matcher subexpression: index ].
	^ self typeConvert: matches
]

{ #category : 'accessing' }
HeraMatchStepDefinition >> preferSingleQuotedStringArguments [

	preferDoubleQuotedStringArguments := false
	
]

{ #category : 'private' }
HeraMatchStepDefinition >> supportedArguments [
	"Hera support a subset of the parameter types defined by Cucumber.
	 See https://github.com/cucumber/cucumber-expressions"

	| quotedStringRegex |
	self flag: 'The regex for float may be too strict. RxMatcher does not support non-capturing groups, like (-?\d+(?:\.\d+))'.
	quotedStringRegex := preferDoubleQuotedStringArguments ifTrue: [ '"([^"]*)"' ] ifFalse: [ '''([^'']*)''' ].
	^ Dictionary
		with: 'string' -> quotedStringRegex
		with: 'word' -> '(\w+)'
		with: 'int' -> '(-?\d+)'
		with: 'float' -> '(-?\d+\.\d+)'
		with: '' -> '(.*)'
]

{ #category : 'private' }
HeraMatchStepDefinition >> typeConvert: aMatchedStringCollection [

	^ aMatchedStringCollection withIndexCollect: [ :each :index | | converter |
		converter := self argumentConversion at: (types at: index).
		converter value: each ]
]
