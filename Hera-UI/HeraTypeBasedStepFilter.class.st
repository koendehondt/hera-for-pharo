Class {
	#name : 'HeraTypeBasedStepFilter',
	#superclass : 'HeraStepFilter',
	#instVars : [
		'stepType'
	],
	#category : 'Hera-UI-Step Browser',
	#package : 'Hera-UI',
	#tag : 'Step Browser'
}

{ #category : 'filtering' }
HeraTypeBasedStepFilter >> select: aStepMethodItem [

	^ stepType = aStepMethodItem stepType
]

{ #category : 'initialization' }
HeraTypeBasedStepFilter >> stepType: aSymbol [

	stepType := aSymbol
]
