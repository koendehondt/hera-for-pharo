Class {
	#name : 'HeraScenario',
	#superclass : 'HeraScriptElement',
	#instVars : [
		'title',
		'steps',
		'tags',
		'description',
		'feature'
	],
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraScenario >> accept: visitor [

	visitor visitScenario: self
]

{ #category : 'dsl' }
HeraScenario >> and: aString [

	| step |
	step := HeraAndStep new
		description: aString;
		scenario: self.
	steps add: step
]

{ #category : 'dsl' }
HeraScenario >> and: aString with: aStepArgument [

	| step |
	step := HeraAndStep new
		description: aString;
		argument: aStepArgument;
		scenario: self.
	steps add: step
]

{ #category : 'dsl' }
HeraScenario >> but: aString [

	| step |
	step := step := HeraButStep new
		description: aString;
		scenario: self.
	steps add: step
]

{ #category : 'dsl' }
HeraScenario >> but: aString with: aStepArgument [

	| step |
	step := HeraButStep new
		description: aString;
		argument: aStepArgument;
		scenario: self.
	steps add: step
]

{ #category : 'accessing' }
HeraScenario >> description [

	^ description
]

{ #category : 'accessing' }
HeraScenario >> description: anArrayOfStrings [

	description := anArrayOfStrings
]

{ #category : 'accessing' }
HeraScenario >> feature [

	^ feature
]

{ #category : 'accessing' }
HeraScenario >> feature: aFeature [

	feature := aFeature
]

{ #category : 'dsl' }
HeraScenario >> given: aString [

	| step |
	step := HeraGivenStep new
		description: aString;
		scenario: self.
	steps add: step
]

{ #category : 'dsl' }
HeraScenario >> given: aString with: aStepArgument [

	| step |
	step := HeraGivenStep new
		description: aString;
		argument: aStepArgument;
		scenario: self.
	steps add: step
]

{ #category : 'initialization' }
HeraScenario >> initialize [

	super initialize.
	tags := #().
	description := #().
	steps := OrderedCollection new
]

{ #category : 'printing' }
HeraScenario >> printOn: aStream [

	aStream
		nextPutAll: 'Scenario: ';
		nextPutAll: title
]

{ #category : 'dsl' }
HeraScenario >> star: aString [

	| step |
	step := HeraStarStep new
		description: aString;
		scenario: self.
	steps add: step
]

{ #category : 'accessing' }
HeraScenario >> steps [

	^ steps
]

{ #category : 'accessing' }
HeraScenario >> tags [

	^ tags
]

{ #category : 'accessing' }
HeraScenario >> tags: anArrayOfSymbols [

	tags := anArrayOfSymbols
]

{ #category : 'dsl' }
HeraScenario >> then: aString [

	| step |
	step := HeraThenStep new
		description: aString;
		scenario: self.
	steps add: step
]

{ #category : 'dsl' }
HeraScenario >> then: aString with: aStepArgument [

	| step |
	step := HeraThenStep new
		description: aString;
		argument: aStepArgument;
		scenario: self.
	steps add: step
]

{ #category : 'accessing' }
HeraScenario >> title [

	^ title
]

{ #category : 'accessing' }
HeraScenario >> title: aString [

	title := aString
]

{ #category : 'dsl' }
HeraScenario >> when: aString [

	| step |
	step := HeraWhenStep new
		description: aString;
		scenario: self.
	steps add: step
]

{ #category : 'dsl' }
HeraScenario >> when: aString with: aStepArgument [

	| step |
	step := HeraWhenStep new
		description: aString;
		argument: aStepArgument;
		scenario: self.
	steps add: step
]
