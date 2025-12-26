Class {
	#name : 'HeraBackground',
	#superclass : 'HeraScriptElement',
	#instVars : [
		'steps',
		'description'
	],
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'comparing' }
HeraBackground >> = other [

	^ self steps = other steps and: [ self description = other description ]
]

{ #category : 'visiting' }
HeraBackground >> accept: visitor [

	visitor visitBackground: self
]

{ #category : 'dsl' }
HeraBackground >> and: aString [

	steps add: (HeraAndStep new description: aString)
]

{ #category : 'dsl' }
HeraBackground >> and: aString with: aStructuredArgument [

	| step |
	step := HeraAndStep new
		description: aString;
		argument: aStructuredArgument asStepArgument.
	steps add: step
]

{ #category : 'dsl' }
HeraBackground >> but: aString [

	steps add: (HeraButStep new description: aString)
]

{ #category : 'dsl' }
HeraBackground >> but: aString with: aStructuredArgument [

	| step |
	step := HeraButStep new
		description: aString;
		argument: aStructuredArgument asStepArgument.
	steps add: step
]

{ #category : 'accessing' }
HeraBackground >> description [

	^ description
]

{ #category : 'accessing' }
HeraBackground >> description: anArrayOfStrings [

	description := anArrayOfStrings
]

{ #category : 'dsl' }
HeraBackground >> given: aString [

	steps add: (HeraGivenStep new description: aString)
]

{ #category : 'dsl' }
HeraBackground >> given: aString with: aStructuredArgument [

	| step |
	step := HeraGivenStep new
		description: aString;
		argument: aStructuredArgument asStepArgument.
	steps add: step
]

{ #category : 'initialization' }
HeraBackground >> initialize [

	super initialize.
	description := #().
	steps := OrderedCollection new
]

{ #category : 'printing' }
HeraBackground >> printOn: aStream [

	aStream nextPutAll: 'Background:'
]

{ #category : 'accessing' }
HeraBackground >> steps [

	^ steps
]
