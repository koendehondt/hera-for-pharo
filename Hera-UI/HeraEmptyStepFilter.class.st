Class {
	#name : 'HeraEmptyStepFilter',
	#superclass : 'HeraStepFilter',
	#category : 'Hera-UI-Step Browser',
	#package : 'Hera-UI',
	#tag : 'Step Browser'
}

{ #category : 'filtering' }
HeraEmptyStepFilter >> select: aStepMethodItem [

	^ aStepMethodItem stepMethod isReturnSelf
]
