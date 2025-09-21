Class {
	#name : 'HeraStartFeaturesInstruction',
	#superclass : 'HeraRunInstruction',
	#instVars : [
		'featureCount'
	],
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'instance creation' }
HeraStartFeaturesInstruction class >> for: featureCount [

	^ self new featureCount: featureCount
]

{ #category : 'comparing' }
HeraStartFeaturesInstruction >> = other [

	^ super = other and: [ self featureCount = other featureCount ]
]

{ #category : 'testing' }
HeraStartFeaturesInstruction >> canBeStepped [

	^ false
]

{ #category : 'accessing' }
HeraStartFeaturesInstruction >> featureCount [

	^ featureCount
]

{ #category : 'accessing' }
HeraStartFeaturesInstruction >> featureCount: anInteger [

	featureCount := anInteger
]

{ #category : 'performing' }
HeraStartFeaturesInstruction >> performFor: aScriptRunner [

	aScriptRunner startFeatures: self featureCount
]
