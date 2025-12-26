Class {
	#name : 'HeraDataTableArgument',
	#superclass : 'HeraStepArgument',
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraDataTableArgument >> accept: visitor [

	visitor visitDataTableArgument: self
]

{ #category : 'converting' }
HeraDataTableArgument >> asArgumentWithResolvedParameters: parametersAndValues [

	^ self copy
		dataTable: (argumentValue asDataTableWithResolvedParameters: parametersAndValues)
]

{ #category : 'accessing' }
HeraDataTableArgument >> dataTable: aDataTable [

	argumentValue := aDataTable
]
