Class {
	#name : 'HeraNoFilterTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Running',
	#package : 'Hera-Tests',
	#tag : 'Running'
}

{ #category : 'running' }
HeraNoFilterTestCase >> describedClass [

	^ HeraNoFilter
]

{ #category : 'tests' }
HeraNoFilterTestCase >> testSelectsAllFeatures [

	self assert: (subject selects: HeraFeature new)
]

{ #category : 'tests' }
HeraNoFilterTestCase >> testSelectsAllScenarios [

	self assert: (subject selects: HeraScenario new)
]
