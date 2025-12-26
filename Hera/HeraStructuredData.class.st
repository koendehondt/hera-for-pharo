Class {
	#name : 'HeraStructuredData',
	#superclass : 'Object',
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'converting' }
HeraStructuredData >> asStepArgument [

	self subclassResponsibility
]

{ #category : 'testing' }
HeraStructuredData >> hasParameters [

	^ self parameters isNotEmpty
]

{ #category : 'accessing' }
HeraStructuredData >> parameters [

	self subclassResponsibility
]

{ #category : 'printing' }
HeraStructuredData >> printFormattedOn: aStream indentation: aNumberOfTabs [

	self subclassResponsibility
]
