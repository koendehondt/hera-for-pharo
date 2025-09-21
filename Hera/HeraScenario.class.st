Class {
	#name : 'HeraScenario',
	#superclass : 'HeraScriptElement',
	#instVars : [
		'title',
		'steps',
		'tags',
		'description'
	],
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'comparing' }
HeraScenario >> = other [

	^ self title = other title
		and: [ self steps = other steps
		and: [ self tags = other tags
		and: [ self description = other description ] ] ]
]

{ #category : 'visiting' }
HeraScenario >> accept: visitor [

	visitor visitScenario: self
]

{ #category : 'dsl' }
HeraScenario >> and: aString [

	steps add: (HeraAndStep new description: aString)
]

{ #category : 'dsl' }
HeraScenario >> and: aString with: aStepArgument [

	| step |
	step := HeraAndStep new
		description: aString;
		argument: aStepArgument.
	steps add: step
]

{ #category : 'dsl' }
HeraScenario >> but: aString [

	steps add: (HeraButStep new description: aString)
]

{ #category : 'dsl' }
HeraScenario >> but: aString with: aStepArgument [

	| step |
	step := HeraButStep new
		description: aString;
		argument: aStepArgument.
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

{ #category : 'dsl' }
HeraScenario >> given: aString [

	steps add: (HeraGivenStep new description: aString)
]

{ #category : 'dsl' }
HeraScenario >> given: aString with: aStepArgument [

	| step |
	step := HeraGivenStep new
		description: aString;
		argument: aStepArgument.
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

	steps add: (HeraStarStep new description: aString)
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

	steps add: (HeraThenStep new description: aString)
]

{ #category : 'dsl' }
HeraScenario >> then: aString with: aStepArgument [

	| step |
	step := HeraThenStep new
		description: aString;
		argument: aStepArgument.
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

	steps add: (HeraWhenStep new description: aString)
]

{ #category : 'dsl' }
HeraScenario >> when: aString with: aStepArgument [

	| step |
	step := HeraWhenStep new
		description: aString;
		argument: aStepArgument.
	steps add: step
]
