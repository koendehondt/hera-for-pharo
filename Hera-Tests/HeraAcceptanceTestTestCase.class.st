Class {
	#name : 'HeraAcceptanceTestTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraAcceptanceTestTestCase >> describedClass [

	^ HeraAcceptanceTest
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testClassFeatureMethods [

	| featureMethods |
	featureMethods := HeraAcceptanceTestWithPassForTesting featureMethods sorted: [ :some :other | some selector < other selector ].
	self assert: featureMethods equals: { 
		HeraAcceptanceTestWithPassForTesting >> #signingInFeature . 
		HeraAcceptanceTestWithPassForTesting >> #signingOutFeature }
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testClassFeatures [

	| features |
	features := HeraAcceptanceTestWithPassForTesting features sorted: [ :some :other | some featureSelector < other featureSelector ].
	self assert: features size equals: 2.
	self assert: features first class equals: HeraAcceptanceTestWithPassForTesting.
	self assert: features first featureSelector equals: #signingInFeature.
	self assert: features second class equals: HeraAcceptanceTestWithPassForTesting.
	self assert: features second featureSelector equals: #signingOutFeature
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testCopyForRunning [

	| copy |
	subject := HeraRunnerAcceptanceTest selector: #featureScenariosRunInIsolation.
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
	self assert: feature title equals: 'Employee management'.
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
	
	| featureMethods |
	self assert: subject featureMethods equals: #().

	featureMethods := HeraAcceptanceTestWithPassForTesting new featureMethods sorted: [ :some :other | some selector < other selector ].
	self assert: featureMethods equals: { 
		HeraAcceptanceTestWithPassForTesting >> #signingInFeature . 
		HeraAcceptanceTestWithPassForTesting >> #signingOutFeature }
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testIsForTestingHera [

	self deny: self describedClass isForTestingHera
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testNameInBrowser [

	self assert: self describedClass nameInBrowser equals: 'HeraAcceptanceTest'
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testRegexStringForMatchStepDefinition [

	self assert: (subject regexStringForMatchStepDefinition: 'I fill in the {string} field') equals: 'I fill in the "([^"]+)" field'.
	self assert: (subject regexStringForMatchStepDefinition: 'I fill in the name field') equals: 'I fill in the name field'
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testStepDebug [

	| stepMethodPragmas pragma |
	stepMethodPragmas := (self describedClass >> #stepDebug) pragmas.
	self assert: stepMethodPragmas size equals: 1.
	pragma := stepMethodPragmas first.
	self assert: pragma selector equals: #heraStepDefinition:.
	self assert: (pragma argumentAt: 1) equals: #(When 'I debug').
	self should: [ subject stepDebug ] raise: Halt
]

{ #category : 'tests' }
HeraAcceptanceTestTestCase >> testStepMethods [

	| stepMethodSelectors |
	stepMethodSelectors := self describedClass stepMethods collect: [ :each | each selector ].
	self assert: stepMethodSelectors equals: { #stepDebug }
]
