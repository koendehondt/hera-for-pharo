Class {
	#name : 'HeraStepMethodItem',
	#superclass : 'HeraStepBrowserItem',
	#instVars : [
		'stepMethod'
	],
	#category : 'Hera-UI-Step Browser',
	#package : 'Hera-UI',
	#tag : 'Step Browser'
}

{ #category : 'comparing' }
HeraStepMethodItem >> < other [

	^ self stepDescription < other stepDescription
]

{ #category : 'accessing' }
HeraStepMethodItem >> acceptanceTestClass [

	^ stepMethod methodClass
]

{ #category : 'private' }
HeraStepMethodItem >> pragma [

	^ stepMethod pragmaAt: #heraStepDefinition:
]

{ #category : 'private' }
HeraStepMethodItem >> pragmaArgument [

	^ self pragma argumentAt: 1
]

{ #category : 'actions' }
HeraStepMethodItem >> saveSource: stepMethodSource [

	self acceptanceTestClass compile: stepMethodSource
]

{ #category : 'accessing' }
HeraStepMethodItem >> sourceCode [

	^ stepMethod sourceCode
]

{ #category : 'accessing' }
HeraStepMethodItem >> stepDescription [

	^ self pragmaArgument last
]

{ #category : 'accessing' }
HeraStepMethodItem >> stepMethod [

	^ stepMethod
]

{ #category : 'accessing' }
HeraStepMethodItem >> stepMethod: aCompiledMethod [

	stepMethod := aCompiledMethod
]

{ #category : 'accessing' }
HeraStepMethodItem >> stepType [

	^ self pragmaArgument first
]
