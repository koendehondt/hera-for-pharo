Class {
	#name : 'HeraApplicationTestCase',
	#superclass : 'HeraUnitTestCase',
	#instVars : [
		'initialOpenFeatureBrowsers'
	],
	#category : 'Hera-UI-Tests-Core',
	#package : 'Hera-UI-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraApplicationTestCase >> describedClass [

	^ HeraApplication
]

{ #category : 'helpers' }
HeraApplicationTestCase >> openFeatureBrowsers [

	^ (self currentWorld windowsSatisfying: [ :window | window model presenter isKindOf: HeraFeatureBrowser ])
		collect: [ :each | each model presenter ] as: Set
]

{ #category : 'helpers' }
HeraApplicationTestCase >> openedFeatureBrowsers [

	^ self openFeatureBrowsers difference: initialOpenFeatureBrowsers
]

{ #category : 'running' }
HeraApplicationTestCase >> setUp [

	super setUp.
	initialOpenFeatureBrowsers := self openFeatureBrowsers
]

{ #category : 'running' }
HeraApplicationTestCase >> tearDown [

	self openedFeatureBrowsers do: [ :each | each window close ].
	super tearDown
]

{ #category : 'tests' }
HeraApplicationTestCase >> testOpenFeatureBrowser [

	| browser |
	self assert: self openedFeatureBrowsers isEmpty.
	browser := subject openFeatureBrowser.
	self assert: self openedFeatureBrowsers size equals: 1.
	self assert: browser displayedTreeItems isEmpty
]

{ #category : 'tests' }
HeraApplicationTestCase >> testOpenFeatureBrowserOnAll [

	| browser |
	self assert: self openedFeatureBrowsers isEmpty.
	browser := subject openFeatureBrowserOnAll.
	self assert: self openedFeatureBrowsers size equals: 1.
	self assert: browser displayedTreeItems isNotEmpty
]

{ #category : 'tests' }
HeraApplicationTestCase >> testOpenFeatureBrowserOnScope [

	| browser |
	self assert: self openedFeatureBrowsers isEmpty.
	browser := subject openFeatureBrowserOnScope: (HeraScope new addClass: HeraAcceptanceTestWithErrorForTesting).
	self assert: self openedFeatureBrowsers size equals: 1.
	self assert: browser displayedTreeItems size equals: 1
]

{ #category : 'tests' }
HeraApplicationTestCase >> testRun [

	| openBrowsers |
	self assert: self openedFeatureBrowsers isEmpty.
	subject run.
	openBrowsers := self openedFeatureBrowsers.
	self assert: openBrowsers size equals: 1.
]
