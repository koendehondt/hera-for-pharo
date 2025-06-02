Class {
	#name : 'HeraEndFeatureInstruction',
	#superclass : 'HeraRunInstruction',
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'testing' }
HeraEndFeatureInstruction >> canBeStepped [

	^ false
]

{ #category : 'performing' }
HeraEndFeatureInstruction >> performFor: aScriptRunner [

	aScriptRunner endFeature
]
