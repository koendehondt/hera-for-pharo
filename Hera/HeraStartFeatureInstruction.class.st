Class {
	#name : 'HeraStartFeatureInstruction',
	#superclass : 'HeraRunInstruction',
	#instVars : [
		'feature',
		'acceptanceTest'
	],
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'instance creation' }
HeraStartFeatureInstruction class >> for: anAcceptanceTest [

	^ self new acceptanceTest: anAcceptanceTest
]

{ #category : 'comparing' }
HeraStartFeatureInstruction >> = other [

	^ super = other and: [ self acceptanceTest = other acceptanceTest ]
]

{ #category : 'accessing' }
HeraStartFeatureInstruction >> acceptanceTest [

	^ acceptanceTest
]

{ #category : 'accessing' }
HeraStartFeatureInstruction >> acceptanceTest: anAcceptanceTest [

	acceptanceTest := anAcceptanceTest
]

{ #category : 'accessing' }
HeraStartFeatureInstruction >> feature [

	^ feature ifNil: [ feature := self acceptanceTest feature ]
]

{ #category : 'performing' }
HeraStartFeatureInstruction >> performFor: aScriptRunner [

	aScriptRunner startFeature: self feature in: self acceptanceTest
]
