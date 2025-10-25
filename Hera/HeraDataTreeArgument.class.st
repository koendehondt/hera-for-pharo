Class {
	#name : 'HeraDataTreeArgument',
	#superclass : 'HeraStepArgument',
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraDataTreeArgument >> accept: visitor [

	visitor visitDataTreeArgument: self
]

{ #category : 'accessing' }
HeraDataTreeArgument >> dataTree: aDataTree [

	argumentValue := aDataTree
]
