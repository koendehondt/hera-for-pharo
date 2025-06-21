Class {
	#name : 'HeraFeatureBrowserTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Feature Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Feature Browser'
}

{ #category : 'running' }
HeraFeatureBrowserTestCase >> describedClass [

	^ HeraFeatureBrowser
]

{ #category : 'running' }
HeraFeatureBrowserTestCase >> setUp [

	super setUp.
	subject open
]

{ #category : 'running' }
HeraFeatureBrowserTestCase >> tearDown [

	subject window close.
	super tearDown
]

{ #category : 'tests' }
HeraFeatureBrowserTestCase >> testInitialButtonEnablement [

	self assert: subject isAddAcceptanceTestClassButtonEnabled.
	self deny: subject isAddFeatureButtonEnabled.
	self deny: subject isRunButtonEnabled.
	self deny: subject isStepByStepButtonEnabled.
	self deny: subject isDebugButtonEnabled.
	self assert: subject isBrowseStepsButtonEnabled
]
