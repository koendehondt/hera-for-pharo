Class {
	#name : 'HeraStepFilterCriteria',
	#superclass : 'Model',
	#instVars : [
		'includeGivenSteps',
		'includeWhenSteps',
		'includeThenSteps',
		'query',
		'onlyDeprecatedSteps',
		'onlyEmptySteps'
	],
	#category : 'Hera-UI-Step Browser',
	#package : 'Hera-UI',
	#tag : 'Step Browser'
}

{ #category : 'accessing' }
HeraStepFilterCriteria >> includeGivenSteps [

	^ includeGivenSteps
]

{ #category : 'accessing' }
HeraStepFilterCriteria >> includeGivenSteps: aBoolean [

	includeGivenSteps := aBoolean.
	self changed: #includeGivenSteps
]

{ #category : 'accessing' }
HeraStepFilterCriteria >> includeThenSteps [

	^ includeThenSteps
]

{ #category : 'accessing' }
HeraStepFilterCriteria >> includeThenSteps: aBoolean [

	includeThenSteps := aBoolean.
	self changed: #includeThenSteps
]

{ #category : 'accessing' }
HeraStepFilterCriteria >> includeWhenSteps [

	^ includeWhenSteps
]

{ #category : 'accessing' }
HeraStepFilterCriteria >> includeWhenSteps: aBoolean [

	includeWhenSteps := aBoolean.
	self changed: #includeWhenSteps
]

{ #category : 'initialization' }
HeraStepFilterCriteria >> initialize [

	super initialize.
	includeGivenSteps := includeWhenSteps := includeThenSteps := true.
	query := ''.
	onlyDeprecatedSteps := false.
	onlyEmptySteps := false
]

{ #category : 'accessing' }
HeraStepFilterCriteria >> onlyDeprecatedSteps [

	^ onlyDeprecatedSteps
]

{ #category : 'accessing' }
HeraStepFilterCriteria >> onlyDeprecatedSteps: aBoolean [

	onlyDeprecatedSteps := aBoolean.
	self changed: #onlyDeprecatedSteps
]

{ #category : 'accessing' }
HeraStepFilterCriteria >> onlyEmptySteps [

	^ onlyEmptySteps
]

{ #category : 'accessing' }
HeraStepFilterCriteria >> onlyEmptySteps: aBoolean [

	onlyEmptySteps := aBoolean.
	self changed: #onlyEmptySteps
]

{ #category : 'accessing' }
HeraStepFilterCriteria >> query [

	^ query
]

{ #category : 'accessing' }
HeraStepFilterCriteria >> query: aString [

	query := aString.
	self changed: #query
]

{ #category : 'private - filtering' }
HeraStepFilterCriteria >> satifiesQuery: aStepMethodItem [

	self query ifEmpty: [ ^ true ].
	^ ('*{1}*' format: { self query }) match: aStepMethodItem stepDescription
]

{ #category : 'filtering' }
HeraStepFilterCriteria >> satisfiedBy: aStepMethodItem [

	^ (self satisfiesStepType: aStepMethodItem) and: [ (self satifiesQuery: aStepMethodItem) and: [ self satisfiesExtraConditions: aStepMethodItem ] ]
]

{ #category : 'private - filtering' }
HeraStepFilterCriteria >> satisfiesExtraConditions: aStepMethodItem [

	| satisfied |
	satisfied := true.
	self onlyDeprecatedSteps ifTrue: [ satisfied := aStepMethodItem isDeprecated ].
	self onlyEmptySteps ifTrue: [ satisfied := satisfied and: [ aStepMethodItem isEmpty] ].
	^ satisfied
]

{ #category : 'private - filtering' }
HeraStepFilterCriteria >> satisfiesStepType: aStepMethodItem [

	^ (self includeGivenSteps and: [ aStepMethodItem stepType = #Given ])
		or: [ (self includeWhenSteps and: [ aStepMethodItem stepType = #When ])
		or: [ self includeThenSteps and: [ aStepMethodItem stepType = #Then ] ] ]
]
