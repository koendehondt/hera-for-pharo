Class {
	#name : 'HeraScenarioResultItemTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Runner',
	#package : 'Hera-UI-Tests',
	#tag : 'Runner'
}

{ #category : 'running' }
HeraScenarioResultItemTestCase >> describedClass [

	^ HeraScenarioResultItem
]

{ #category : 'tests' }
HeraScenarioResultItemTestCase >> testDescription [

	subject scenario: (HeraScenario new title: 'Buying fruit').
	self assert: subject description equals: 'Buying fruit'
]

{ #category : 'tests' }
HeraScenarioResultItemTestCase >> testDescriptionlabel [

	subject scenario: (HeraScenario new title: 'Buying fruit').
	self assert: subject descriptionLabel equals: 'Buying fruit'
]

{ #category : 'tests' }
HeraScenarioResultItemTestCase >> testLevel [

	self assert: subject level equals: 3
]

{ #category : 'tests' }
HeraScenarioResultItemTestCase >> testStatus [

	self assert: subject status equals: HeraResultStatus runningStatus.
	subject status: HeraResultStatus passedStatus.
	self assert: subject status equals: HeraResultStatus passedStatus
]
