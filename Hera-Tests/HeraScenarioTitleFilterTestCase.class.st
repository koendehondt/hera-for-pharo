Class {
	#name : 'HeraScenarioTitleFilterTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Running',
	#package : 'Hera-Tests',
	#tag : 'Running'
}

{ #category : 'running' }
HeraScenarioTitleFilterTestCase >> describedClass [

	^ HeraScenarioTitleFilter
]

{ #category : 'tests' }
HeraScenarioTitleFilterTestCase >> testRejectsScenarioWithDifferentTitle [

	| scenario |
	subject title: 'Unsuccessful signin'.
	scenario := HeraScenario new title: 'Unsuccessful sign-in'.
	self deny: (subject selects: scenario)
]

{ #category : 'tests' }
HeraScenarioTitleFilterTestCase >> testSelectsAllFeatures [

	self assert: (subject selects: HeraFeature new)
]

{ #category : 'tests' }
HeraScenarioTitleFilterTestCase >> testSelectsScenarioWithExactTitle [

	| scenario |
	subject title: 'Unsuccessful sign-in'.
	scenario := HeraScenario new title: 'Unsuccessful sign-in'.
	self assert: (subject selects: scenario)
]
