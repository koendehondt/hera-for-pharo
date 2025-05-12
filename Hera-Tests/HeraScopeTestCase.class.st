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
