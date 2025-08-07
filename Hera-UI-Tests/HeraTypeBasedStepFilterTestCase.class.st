Class {
	#name : 'HeraTypeBasedStepFilterTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Step Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Step Browser'
}

{ #category : 'running' }
HeraTypeBasedStepFilterTestCase >> describedClass [

	^ HeraTypeBasedStepFilter
]

{ #category : 'tests' }
HeraTypeBasedStepFilterTestCase >> testFilterWithStepTypeGivenAllowsGivenStepsOnly [

	| givenStepMethod thenStepMethod whenStepMethod |
	subject stepType: #Given.
	givenStepMethod := HeraStepMethodItem new stepMethod: HeraAcceptanceTestExamplesForTesting>>#stepIAmAnAdministrator.
	self assert: (subject select: givenStepMethod).
	whenStepMethod := HeraStepMethodItem new stepMethod: HeraAcceptanceTestExamplesForTesting>>#stepIEnterMyCredentials.
	self deny: (subject select: whenStepMethod).
	thenStepMethod := HeraStepMethodItem new stepMethod: HeraAcceptanceTestExamplesForTesting>>#stepICannotOpenTheUserManagementPage.
	self deny: (subject select: thenStepMethod)
]
