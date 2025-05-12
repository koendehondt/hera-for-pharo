Class {
	#name : 'HeraStep',
	#superclass : 'HeraScriptElement',
	#instVars : [
		'description',
		'argument',
		'scenario'
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

{ #category : 'accessing' }
HeraStep >> scenario [

	^ scenario
]

{ #category : 'accessing' }
HeraStep >> scenario: aScenario [

	scenario := aScenario
]
