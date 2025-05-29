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

{ #category : 'actions' }
HeraStepMethodItem >> compileSourceWithoutPragma: stepMethodSource notifying: requestor [

	^ self acceptanceTestClass compiler
		source: stepMethodSource;
		requestor: requestor;
		failBlock: [ ^ nil ];
		permitUndeclared: false;
		compile
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

	| selector |
	selector := self acceptanceTestClass compile: stepMethodSource.
	^ self acceptanceTestClass >> selector
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
HeraStepMethodItem >> stepPattern [

	| argument |
	argument := self pragmaArgument.
	^ argument size > 2 ifTrue: [ argument second ]
]

{ #category : 'accessing' }
HeraStepMethodItem >> stepType [

	^ self pragmaArgument first
]
