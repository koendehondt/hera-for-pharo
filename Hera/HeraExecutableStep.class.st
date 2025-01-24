Class {
	#name : 'HeraExecutableStep',
	#superclass : 'Object',
	#instVars : [
		'stepMethod',
		'acceptanceTest',
		'arguments'
	],
	#category : 'Hera-Step definitions',
	#package : 'Hera',
	#tag : 'Step definitions'
}

{ #category : 'accessing' }
HeraExecutableStep >> acceptanceTest: anAcceptanceTest [

	acceptanceTest := anAcceptanceTest
]

{ #category : 'accessing' }
HeraExecutableStep >> arguments: anArray [

	arguments := anArray
]

{ #category : 'running' }
HeraExecutableStep >> run [

	self subclassResponsibility
]

{ #category : 'accessing' }
HeraExecutableStep >> stepMethod [

	^ stepMethod
]

{ #category : 'accessing' }
HeraExecutableStep >> stepMethod: aCompiledMethod [

	stepMethod := aCompiledMethod
]
