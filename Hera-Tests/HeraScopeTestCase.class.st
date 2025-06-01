Class {
	#name : 'HeraScopeTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraScopeTestCase >> describedClass [

	^ HeraScope
]

{ #category : 'tests' }
HeraScopeTestCase >> testAll [

	subject := self describedClass all.
	self assert: subject allForBrowsing asSet equals: HeraAcceptanceTest allSubclasses asSet
]

{ #category : 'tests' }
HeraScopeTestCase >> testAllForBrowsingWithAcceptanceTestsForTesting [

	subject := self describedClass default.
	subject addHierarchy: HeraAcceptanceTestForTesting.
	self assert: subject allForBrowsing equals: {
		HeraAcceptanceTestExamplesForTesting .
		HeraAcceptanceTestWithErrorForTesting .
		HeraAcceptanceTestWithErrorInAfterScenarioHookForTesting .
		HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting .
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
HeraScopeTestCase >> testAllForBrowsingWithAllAcceptanceTests [

	subject := self describedClass all.
	self assert: subject allForBrowsing equals: {
		HeraAcceptanceTestExamplesForTesting .
		HeraAcceptanceTestForTesting .
		HeraAcceptanceTestWithErrorForTesting .
		HeraAcceptanceTestWithErrorInAfterScenarioHookForTesting .
		HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting .
		HeraAcceptanceTestWithFailureForTesting .
		HeraAcceptanceTestWithHelperForTesting .
		HeraAcceptanceTestWithHooksForTesting .
		HeraAcceptanceTestWithLintIssuesForTesting .
		HeraAcceptanceTestWithPassForTesting .
		HeraAcceptanceTestWithSingleQuotedStepArgumentsForTesting .
		HeraAcceptanceTestWithStepArgumentsForTesting .
		HeraAcceptanceTestWithTraitForTesting .
		HeraFeatureBrowserAcceptanceTest .
		HeraRunnerAcceptanceTest .
		HeraSelfAcceptanceTest
	 }
]

{ #category : 'tests' }
HeraScopeTestCase >> testAllStepMethods [

	subject := self describedClass new.
	subject addClass: HeraAcceptanceTestWithStepArgumentsForTesting.
	self assert: (subject allStepMethods collect: [ :each | each selector ]) sorted equals: {
		#stepIAmOnTheSignInPage .
		#stepIFillInTheFieldLabeled: .
		#stepIPressTheButtonLabeled: .
		#stepISeeTheHomePage
	 }
]

{ #category : 'tests' }
HeraScopeTestCase >> testDefault [

	subject := self describedClass default.
	self assert: subject allForBrowsing equals: #()
]

{ #category : 'tests' }
HeraScopeTestCase >> testExcludeClass [

	subject := self describedClass all.
	subject removeClass: HeraAcceptanceTestWithStepArgumentsForTesting.
	self deny: (subject allForBrowsing includes: HeraAcceptanceTestWithStepArgumentsForTesting)
]

{ #category : 'tests' }
HeraScopeTestCase >> testExcludeClasses [

	subject := self describedClass all.
	subject removeClasses: HeraAcceptanceTest allSubclasses.
	self assert: subject allForBrowsing isEmpty
]

{ #category : 'tests' }
HeraScopeTestCase >> testExcludeHierarchy [

	subject := self describedClass new.
	subject addHierarchy: HeraAcceptanceTestForTesting.
	self assert: subject allForBrowsing size equals: HeraAcceptanceTestForTesting allSubclasses size.
	subject removeHierarchy: HeraAcceptanceTestForTesting.
	self assert: subject allForBrowsing isEmpty
]

{ #category : 'tests' }
HeraScopeTestCase >> testIncludeClass [

	subject := self describedClass new.
	subject addClass: HeraAcceptanceTestWithStepArgumentsForTesting.
	self assert: subject allForBrowsing equals: { HeraAcceptanceTestWithStepArgumentsForTesting }
]

{ #category : 'tests' }
HeraScopeTestCase >> testIncludeHierarchy [

	subject := self describedClass new.
	subject addHierarchy: HeraAcceptanceTestForTesting.
	self assert: subject allForBrowsing size equals: HeraAcceptanceTestForTesting allSubclasses size
]

{ #category : 'tests' }
HeraScopeTestCase >> testNew [

	subject := self describedClass new.
	self assert: subject allForBrowsing isEmpty
]
