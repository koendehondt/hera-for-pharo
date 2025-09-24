Class {
	#name : 'HeraScriptEditorTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Feature Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Feature Browser'
}

{ #category : 'running' }
HeraScriptEditorTestCase >> describedClass [

	^ HeraScriptEditor
]

{ #category : 'tests' }
HeraScriptEditorTestCase >> testButtonEnablementForModel [

	| featureMethodItem |
	subject setupAfterOpening.
	subject model: nil.
	featureMethodItem := HeraFeatureMethodItem new
		acceptanceTestClass: HeraAcceptanceTestWithPassForTesting;
		featureMethodSelector: #signingInFeature.
	subject model: featureMethodItem.
	self assert: subject isBrowseButtonEnabled
]

{ #category : 'tests' }
HeraScriptEditorTestCase >> testInitialButtonEnablement [

	subject setupAfterOpening.
	self deny: subject isBrowseButtonEnabled
]
