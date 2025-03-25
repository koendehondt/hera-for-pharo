Class {
	#name : 'HeraHelper',
	#superclass : 'Object',
	#instVars : [
		'acceptanceTest'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'accessing' }
HeraHelper class >> stepMethods [
	"Answer all compiled methods that represent step definitions,
	 including methods from traits."

	^ self methods select: [ :each | (each pragmaAt: #heraStepDefinition:) isNotNil ]
]

{ #category : 'accessing' }
HeraHelper >> acceptanceTest: anAcceptanceTest [

	acceptanceTest := anAcceptanceTest
]
