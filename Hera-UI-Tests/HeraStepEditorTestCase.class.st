Class {
	#name : 'HeraStepEditorTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Feature Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Feature Browser'
}

{ #category : 'running' }
HeraStepEditorTestCase >> describedClass [

	^ HeraStepEditor
]

{ #category : 'tests' }
HeraStepEditorTestCase >> testDefaultMethodInfo [

	self assert: subject methodInfoText equals: ''
]

{ #category : 'tests' }
HeraStepEditorTestCase >> testMethodInfoForMethodOnAcceptanceClass [

	subject model: (HeraStepMethodItem new stepMethod: HeraAcceptanceTestExamplesForTesting>>#stepIHaveAUserName).
	self assert: subject methodInfoText equals: 'Defined in HeraAcceptanceTestExamplesForTesting (steps)'
]

{ #category : 'tests' }
HeraStepEditorTestCase >> testMethodInfoForMethodOnHelperClass [

	subject model: (HeraStepMethodItem new stepMethod: HeraHelperForTesting>>#stepISeeTheHomePage).
	self assert: subject methodInfoText equals: 'Defined in HeraHelperForTesting (steps)'
]

{ #category : 'tests' }
HeraStepEditorTestCase >> testMethodInfoForMethodOnHeraAcceptanceClass [

	subject model: (HeraStepMethodItem new stepMethod: HeraAcceptanceTest>>#stepDebug).
	self assert: subject methodInfoText equals: 'Defined in HeraAcceptanceTest (steps)'
]

{ #category : 'tests' }
HeraStepEditorTestCase >> testMethodInfoForMethodOnTrait [

	subject model: (HeraStepMethodItem new stepMethod: HeraWidgetHelperTraitForTesting>>#stepISeeTheHomePage).
	self assert: subject methodInfoText equals: 'Defined in HeraWidgetHelperTraitForTesting (steps)'
]
