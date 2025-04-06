Class {
	#name : 'HeraScopeTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraScopeTestCase >> describedClass [

	^ HeraScope
]

{ #category : 'tests' }
HeraScopeTestCase >> testAllForBrowsingDefaultsToEmptyArray [

	subject := self describedClass default.
	self assert: subject allForBrowsing equals: #()
]

{ #category : 'tests' }
HeraScopeTestCase >> testAllForBrowsingWithAcceptanceTestsForTesting [

	subject := self describedClass default.
	subject includeHierarchy: HeraAcceptanceTestForTesting.
	self assert: subject allForBrowsing equals: {
		HeraAcceptanceTestExamplesForTesting .
		HeraAcceptanceTestWithErrorForTesting .
		HeraAcceptanceTestWithFailureForTesting .
		HeraAcceptanceTestWithHelperForTesting .
		HeraAcceptanceTestWithHooksForTesting .
		HeraAcceptanceTestWithLintIssuesForTesting .
		HeraAcceptanceTestWithPassForTesting .
		HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting .
		HeraAcceptanceTestWithStepArgumentsForTesting .
		HeraAcceptanceTestWithTraitForTesting
	 }
]

{ #category : 'tests' }
HeraScopeTestCase >> testHighestFeatureNumber [

	"Based on the existing acceptance test classes in the Hera distribution."
	self assert: subject highestFeatureNumber equals: 0
]

{ #category : 'tests' }
HeraScopeTestCase >> testNextAvailableFeatureNumber [

	"Based on the existing acceptance test classes in the Hera distribution."
	self assert: subject nextAvailableFeatureNumber equals: 1
]
