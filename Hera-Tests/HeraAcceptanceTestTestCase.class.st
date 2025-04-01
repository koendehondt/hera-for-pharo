Class {
	#name : 'HeraAcceptanceTestTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraAcceptanceTestTestCase >> describedClass [

	^ HeraAcceptanceTest
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testCopyForRunning [

	| copy |
	subject := HeraRunnerAcceptanceTest selector: #featureRunningScenariosInIsolation.
	subject instanceVariable: 1234.
	copy := subject copyForRunning.
	self assert: copy class equals: subject class.
	self assert: copy instanceVariable isNil
]

{ #category : 'tests - dsl' }
HeraAcceptanceTestTestCase >> testDslBackground [

	| background |
	background := subject background.
	self assert: (background isMemberOf: HeraBackground).
	self assert: background steps equals: OrderedCollection new
]

{ #category : 'tests - dsl' }
HeraAcceptanceTestTestCase >> testDslDataTable [

	| dataTableArgument |
	dataTableArgument := subject dataTable: { { 'x' . 'y' } . { '10' . '20' } }.
	self assert: (dataTableArgument isMemberOf: HeraDataTableArgument).
	self assert: dataTableArgument argumentValue equals: (HeraDataTable new data: { { 'x' . 'y' } . { '10' . '20' } })
]

{ #category : 'tests - dsl' }
HeraAcceptanceTestTestCase >> testDslDocString [

	| dataTableArgument |
	dataTableArgument := subject docString: { 'Line 1' . 'Line 2' }.
	self assert: (dataTableArgument isMemberOf: HeraDocStringArgument).
	self assert: dataTableArgument argumentValue equals: (HeraDocString new lines: { 'Line 1' . 'Line 2' })
]

{ #category : 'tests - dsl' }
HeraAcceptanceTestTestCase >> testDslFeature [

	| feature |
	feature := subject feature: 'Employee management'.
	self assert: (feature isMemberOf: HeraFeature).
	self assert: feature name equals: 'Employee management'.
	self assert: feature tags equals: #().
	self assert: feature description equals: #().
	self assert: feature background isNil.
	self assert: feature scenarios equals: #()
]

{ #category : 'tests - dsl' }
HeraAcceptanceTestTestCase >> testDslScenario [

	| scenario |
	scenario := subject scenario: 'Increasing salaries'.
	self assert: (scenario isMemberOf: HeraScenario).
	self assert: scenario title equals: 'Increasing salaries'.
	self assert: scenario tags equals: #().
	self assert: scenario description equals: #().
	self assert: scenario steps equals: OrderedCollection new
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testFeatureMethods [
	
	self assert: subject featureMethods equals: #()
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testStepMethods [
	
	self assert: self describedClass stepMethods equals: { HeraAcceptanceTest >> #stepDebug }
]
