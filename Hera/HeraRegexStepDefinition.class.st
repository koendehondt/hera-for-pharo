Class {
	#name : 'HeraRegexStepDefinition',
	#superclass : 'HeraStepDefinition',
	#category : 'Hera-Step definitions',
	#package : 'Hera',
	#tag : 'Step definitions'
}

{ #category : 'matching' }
HeraRegexStepDefinition >> match: aStepDescription [

	| matcher patternWithoutParameters |
	patternWithoutParameters := (RxMatcher forString: '<[^>]+>') copy: pattern replacingMatchesWith: '.+'.
	matcher := RxMatcher forString: patternWithoutParameters.
	(matcher matches: aStepDescription) ifFalse: [ ^ nil ].
	matcher subexpressionCount = 1 ifTrue: [ ^ #() ].
	^ (2 to: matcher subexpressionCount) collect: [ :subexpressionIndex | matcher subexpression: subexpressionIndex ]
]
