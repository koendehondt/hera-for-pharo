Class {
	#name : 'HeraStepArgument',
	#superclass : 'HeraScriptElement',
	#instVars : [
		'argumentValue'
	],
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'comparing' }
HeraStepArgument >> = other [

	^ self class = other class and: [ self argumentValue = other argumentValue ]
]

{ #category : 'accessing' }
HeraStepArgument >> argumentValue [

	^ argumentValue
]

{ #category : 'converting' }
HeraStepArgument >> asArgumentWithResolvedParameters: parametersAndValues [

	self subclassResponsibility
]

{ #category : 'printing' }
HeraStepArgument >> printFormattedOn: aStream indentation: aNumberOfTabs [

	argumentValue printFormattedOn: aStream indentation: aNumberOfTabs
]

{ #category : 'printing' }
HeraStepArgument >> printOn: aStream [

	argumentValue printOn: aStream
]
