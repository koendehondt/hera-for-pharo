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
HeraFeatureBrowserTestCase >> tearDown [

	subject ifNotNil: [ subject window close].
	super tearDown
]

{ #category : 'tests' }
HeraFeatureBrowserTestCase >> testInitialButtonEnablement [

	subject open.
	self assert: subject isAddAcceptanceTestClassButtonEnabled.
	self deny: subject isAddFeatureButtonEnabled.
	self assert: subject isBrowseStepsButtonEnabled
]

{ #category : 'tests' }
HeraFeatureBrowserTestCase >> testWindowTitleDependsOnSelection [

	subject scope: (HeraScope new addClass: HeraAcceptanceTestExamplesForTesting).
	subject open.
	self assert: subject currentWindowTitle equals: 'Hera Feature Browser'.

	subject selectFeature: 'With data table' in: 'Examples for testing'.
	self assert: subject currentWindowTitle equals: 'With data table'.

	subject selectAcceptanceTestClassNamed: 'Examples for testing'.
	self assert: subject currentWindowTitle equals: 'Examples for testing'.

	subject selectPaths: { { 1 } . { 1 . 1 } }.
	self assert: subject currentWindowTitle equals: 'Hera Feature Browser'
]
