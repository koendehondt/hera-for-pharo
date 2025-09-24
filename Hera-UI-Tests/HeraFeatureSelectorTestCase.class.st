Class {
	#name : 'HeraFeatureSelectorTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Feature Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Feature Browser'
}

{ #category : 'running' }
HeraFeatureSelectorTestCase >> describedClass [

	^ HeraFeatureSelector
]

{ #category : 'running' }
HeraFeatureSelectorTestCase >> setUp [

	super setUp.
	subject open
]

{ #category : 'running' }
HeraFeatureSelectorTestCase >> tearDown [

	subject ifNotNil: [ subject window close].
	super tearDown
]

{ #category : 'tests' }
HeraFeatureSelectorTestCase >> testButtonEnablementForModel [

	| featureMethodItem |
	subject setupAfterOpening.
	featureMethodItem := HeraFeatureMethodItem new
		acceptanceTestClass: HeraAcceptanceTestWithPassForTesting;
		featureMethodSelector: #signingInFeature.
	subject selectPaths: #(#(1)).
	self assert: subject isRunSelectedFeaturesButtonEnabled.
	self assert: subject isStepSelectedFeaturesButtonEnabled.
	self assert: subject isDebugSelectedFeaturesButtonEnabled.
	self assert: subject isRunAllFeaturesButtonEnabled
]

{ #category : 'tests' }
HeraFeatureSelectorTestCase >> testInitialButtonEnablement [

	subject setupAfterOpening.
	self deny: subject isRunSelectedFeaturesButtonEnabled.
	self deny: subject isStepSelectedFeaturesButtonEnabled.
	self deny: subject isDebugSelectedFeaturesButtonEnabled.
	self assert: subject isRunAllFeaturesButtonEnabled
]
