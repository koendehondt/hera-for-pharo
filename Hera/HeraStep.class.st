Class {
	#name : 'HeraStep',
	#superclass : 'HeraScriptElement',
	#instVars : [
		'description',
		'argument'
	],
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'comparing' }
HeraStep >> = other [

	^ self class = other class
		and: [ self description = other description
		and: [ self argument = other argument ] ]
]

{ #category : 'accessing' }
HeraStep >> argument [

	^ argument
]

{ #category : 'accessing' }
HeraStep >> argument: aStepArgument [

	argument := aStepArgument
]

{ #category : 'accessing' }
HeraStep >> argumentValue [

	^ argument ifNotNil: [ argument argumentValue ]
]

{ #category : 'converting' }
HeraStep >> asStepWithResolvedParameters: parametersAndValues [

	^ self copy
		description: (self description heraParameterFormat: parametersAndValues);
		argument: (self argument ifNotNil: [ :argumentWithParameters | argumentWithParameters asArgumentWithResolvedParameters: parametersAndValues ])
]

{ #category : 'accessing' }
HeraStep >> description [

	^ description
]

{ #category : 'accessing' }
HeraStep >> description: aString [

	description := aString
]

{ #category : 'accessing' }
HeraStep >> keyword [

	self subclassResponsibility
]

{ #category : 'printing' }
HeraStep >> printOn: aStream [

	aStream
		nextPutAll: self keyword;
		space;
		nextPutAll: description
]

{ #category : 'running' }
HeraStep >> runIn: context [

	context runStep: self
]
