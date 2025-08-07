Class {
	#name : 'HeraAllStepsFilterTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Step Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Step Browser'
}

{ #category : 'running' }
HeraAllStepsFilterTestCase >> describedClass [

	^ HeraAllStepsFilter
]

{ #category : 'tests' }
HeraAllStepsFilterTestCase >> testFilterAllowsAll [

	| arbitraryStepMethodItem |
	arbitraryStepMethodItem := HeraStepMethodItem new.
	self assert: (subject select: arbitraryStepMethodItem)
]
