Class {
	#name : 'HeraScenarioFilterTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Running',
	#package : 'Hera-Tests',
	#tag : 'Running'
}

{ #category : 'running' }
HeraScenarioFilterTestCase >> describedClass [

	^ HeraScenarioFilter
]

{ #category : 'tests' }
HeraScenarioFilterTestCase >> testRejectsScenarioWithDifferentTitle [

	| scenario |
	subject title: 'Unsuccessful signin'.
	scenario := HeraScenario new title: 'Unsuccessful sign-in'.
	self deny: (subject selects: scenario)
]

{ #category : 'tests' }
HeraScenarioFilterTestCase >> testSelectsAllFeatures [

	self assert: (subject selects: HeraFeature new)
]

{ #category : 'tests' }
HeraScenarioFilterTestCase >> testSelectsScenarioWithExactTitle [

	| scenario |
	subject title: 'Unsuccessful sign-in'.
	scenario := HeraScenario new title: 'Unsuccessful sign-in'.
	self assert: (subject selects: scenario)
]
