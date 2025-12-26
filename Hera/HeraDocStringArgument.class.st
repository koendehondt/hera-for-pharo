Class {
	#name : 'HeraDocStringArgument',
	#superclass : 'HeraStepArgument',
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraDocStringArgument >> accept: visitor [

	visitor visitDocStringArgument: self
]

{ #category : 'converting' }
HeraDocStringArgument >> asArgumentWithResolvedParameters: parametersAndValues [

	^ self copy
		docString: (argumentValue asDocStringWithResolvedParameters: parametersAndValues)
]

{ #category : 'accessing' }
HeraDocStringArgument >> docString: aDocString [

	argumentValue := aDocString
]
