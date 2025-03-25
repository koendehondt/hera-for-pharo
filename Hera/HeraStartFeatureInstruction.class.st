Class {
	#name : 'HeraStartFeatureInstruction',
	#superclass : 'HeraRunInstruction',
	#instVars : [
		'feature'
	],
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'instance creation' }
HeraStartFeatureInstruction class >> for: aFeature [

	^ self new feature: aFeature
]

{ #category : 'comparing' }
HeraStartFeatureInstruction >> = other [

	^ super = other and: [ self feature = other feature ]
]

{ #category : 'accessing' }
HeraStartFeatureInstruction >> feature [

	^ feature
]

{ #category : 'accessing' }
HeraStartFeatureInstruction >> feature: aFeature [

	feature := aFeature
]

{ #category : 'performing' }
HeraStartFeatureInstruction >> performFor: aScriptRunner [

	aScriptRunner startFeature: self feature
]
