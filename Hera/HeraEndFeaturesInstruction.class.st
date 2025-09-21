Class {
	#name : 'HeraEndFeaturesInstruction',
	#superclass : 'HeraRunInstruction',
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'testing' }
HeraEndFeaturesInstruction >> canBeStepped [

	^ false
]

{ #category : 'performing' }
HeraEndFeaturesInstruction >> performFor: aScriptRunner [

	aScriptRunner endFeatures
]
