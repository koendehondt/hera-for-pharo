Class {
	#name : 'HeraStepDefinition',
	#superclass : 'Object',
	#instVars : [
		'pattern'
	],
	#category : 'Hera-Step definitions',
	#package : 'Hera',
	#tag : 'Step definitions'
}

{ #category : 'instance creation' }
HeraStepDefinition class >> for: aPatternString [

	^ self new pattern: aPatternString
]

{ #category : 'matching' }
HeraStepDefinition >> match: aStepDescription [

	self subclassResponsibility
]

{ #category : 'matching' }
HeraStepDefinition >> matches: aStepDescription [

	^ (self match: aStepDescription) isNotNil
]

{ #category : 'accessing' }
HeraStepDefinition >> pattern [

	^ pattern
]

{ #category : 'accessing' }
HeraStepDefinition >> pattern: aPatternString [

	pattern := aPatternString
]
