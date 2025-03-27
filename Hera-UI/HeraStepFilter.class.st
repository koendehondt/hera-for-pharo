Class {
	#name : 'HeraStepFilter',
	#superclass : 'Object',
	#category : 'Hera-UI-Step Browser',
	#package : 'Hera-UI',
	#tag : 'Step Browser'
}

{ #category : 'filtering' }
HeraStepFilter >> select: aStepMethodItem [
	"Answer whether the given step method item passes the filter."

	self subclassResponsibility
]
