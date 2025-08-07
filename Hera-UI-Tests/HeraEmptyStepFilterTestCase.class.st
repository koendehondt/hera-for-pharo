Class {
	#name : 'HeraEmptyStepFilterTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Step Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Step Browser'
}

{ #category : 'running' }
HeraEmptyStepFilterTestCase >> describedClass [

	^ HeraEmptyStepFilter
]

{ #category : 'tests' }
HeraEmptyStepFilterTestCase >> testFilterAllowsEmptyStepsOnly [

	| emptyStepMethod nonEmptyStepMethod |
	emptyStepMethod := HeraStepMethodItem new stepMethod: HeraAcceptanceTestExamplesForTesting>>#stepIAmAnAdministrator.
	self assert: (subject select: emptyStepMethod).
	nonEmptyStepMethod := HeraStepMethodItem new stepMethod: HeraAcceptanceTestExamplesForTesting>>#stepIRemoveTheFollowingUsers:.
	self deny: (subject select: nonEmptyStepMethod).
]
