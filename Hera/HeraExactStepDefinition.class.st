Class {
	#name : 'HeraExactStepDefinition',
	#superclass : 'HeraStepDefinition',
	#category : 'Hera-Step definitions',
	#package : 'Hera',
	#tag : 'Step definitions'
}

{ #category : 'comparing' }
HeraExactStepDefinition >> = other [

	^ self pattern = other pattern
]

{ #category : 'comparing' }
HeraExactStepDefinition >> hash [

	^ self pattern hash
]

{ #category : 'matching' }
HeraExactStepDefinition >> match: aStepDescription [

	^ #()
]
