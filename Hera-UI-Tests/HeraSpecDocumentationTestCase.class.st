Class {
	#name : 'HeraSpecDocumentationTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Feature Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Feature Browser'
}

{ #category : 'running' }
HeraSpecDocumentationTestCase >> describedClass [

	^ HeraFeatureBrowser
]

{ #category : 'running' }
HeraSpecDocumentationTestCase >> tearDown [

	subject ifNotNil: [ subject window close].
	super tearDown
]

{ #category : 'tests' }
HeraSpecDocumentationTestCase >> testRunAllSelfAcceptanceTests [

	| runner |
	subject scope: (HeraScope new addClass: HeraSpecExamplesAcceptanceTest).
	subject open.
	runner := subject runAllFeatures.
	runner window close.
	self assert: runner hasRunAllScenarios
]
