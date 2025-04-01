Class {
	#name : 'HeraAnalyticsTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraAnalyticsTestCase >> describedClass [

	^ HeraAnalytics
]

{ #category : 'tests' }
HeraAnalyticsTestCase >> testAllForBrowsingDefaultsToEmptyArray [

	subject := self describedClass default.
	self assert: subject allForBrowsing equals: #()
]

{ #category : 'tests' }
HeraAnalyticsTestCase >> testAllForBrowsingWithAcceptanceTestsForTesting [

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
HeraAnalyticsTestCase >> testHighestFeatureNumber [

	"Based on the existing acceptance test classes in the Hera distribution."
	self assert: subject highestFeatureNumber equals: 0
]

{ #category : 'tests' }
HeraAnalyticsTestCase >> testNextAvailableFeatureNumber [

	"Based on the existing acceptance test classes in the Hera distribution."
	self assert: subject nextAvailableFeatureNumber equals: 1
]
