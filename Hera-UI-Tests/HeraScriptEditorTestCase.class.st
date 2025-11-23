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
HeraScriptEditorTestCase >> testButtonEnablementAfterTextChange [

	| featureMethodItem |
	subject setupAfterOpening.
	featureMethodItem := HeraFeatureMethodItem new
		acceptanceTestClass: HeraAcceptanceTestWithPassForTesting;
		featureMethodSelector: #signingInFeature.
	subject model: featureMethodItem.
	subject text: 'Changed text'.
	self assert: subject isSaveButtonEnabled.
	self assert: subject isCancelButtonEnabled
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
	self deny: subject isSaveButtonEnabled.
	self deny: subject isCancelButtonEnabled
]

{ #category : 'tests' }
HeraScriptEditorTestCase >> testInitialButtonEnablement [

	subject setupAfterOpening.
	self deny: subject isSaveButtonEnabled.
	self deny: subject isCancelButtonEnabled
]
