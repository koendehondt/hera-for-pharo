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

{ #category : 'comparing' }
HeraStepMethodItem >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ stepMethod = anObject stepMethod
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

{ #category : 'accessing' }
HeraStepMethodItem >> fullStepDescription [

	^ '{1} {2}' format: { self stepType . self stepDescription }
]

{ #category : 'comparing' }
HeraStepMethodItem >> hash [

	^ stepMethod hash
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

	| targetSelector targetClass protocol |
	targetClass := self acceptanceTestClass.
	targetSelector := targetClass compile: stepMethodSource.
	protocol := targetClass ensureProtocol: 'steps'.
	targetClass classify: targetSelector under: protocol.
	^ targetClass >> targetSelector
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
HeraStepMethodItem >> stepSelector [

	^ self stepMethod selector
]

{ #category : 'accessing' }
HeraStepMethodItem >> stepType [

	^ self pragmaArgument first
]
