Class {
	#name : 'HeraScriptElement',
	#superclass : 'Object',
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraScriptElement >> accept: visitor [

	self subclassResponsibility
]

{ #category : 'printing' }
HeraScriptElement >> printOn: aStream [

	self subclassResponsibility
]
