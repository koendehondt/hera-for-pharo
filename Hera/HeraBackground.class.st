Class {
	#name : 'HeraBackground',
	#superclass : 'HeraScriptElement',
	#instVars : [
		'steps'
	],
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraBackground >> accept: visitor [

	visitor visitBackground: self
]

{ #category : 'dsl' }
HeraBackground >> given: aString [

	steps add: (HeraGivenStep new description: aString)
]

{ #category : 'dsl' }
HeraBackground >> given: aString with: aStepArgument [

	| step |
	step := HeraGivenStep new
		description: aString;
		argument: aStepArgument.
	steps add: step
]

{ #category : 'initialization' }
HeraBackground >> initialize [

	super initialize.
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
