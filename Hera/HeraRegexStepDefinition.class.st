Class {
	#name : 'HeraRegexStepDefinition',
	#superclass : 'HeraStepDefinition',
	#category : 'Hera-Step definitions',
	#package : 'Hera',
	#tag : 'Step definitions'
}

{ #category : 'matching' }
HeraRegexStepDefinition >> match: aStepDescription [

	| matcher |
	matcher := RxMatcher forString: pattern.
	(matcher matches: aStepDescription) ifFalse: [ ^ nil ].
	matcher subexpressionCount = 1 ifTrue: [ ^ aStepDescription ].
	^ matcher subexpressions: 2
]
