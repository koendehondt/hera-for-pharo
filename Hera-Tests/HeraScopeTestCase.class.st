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
		HeraSelfAcceptanceTest . 
		HeraSpecAcceptanceTest .
		HeraWebAcceptanceTest .
		HeraWebAcceptanceTestExample .
		PharoFinderAcceptanceTest
	 }
]

{ #category : 'tests' }
HeraScopeTestCase >> testAllStepMethodsWhenOneClassInScope [

	| stepMethods stepMethodsOfClass stepMethodsOfHeraSpecAcceptanceTest stepMethodsOfHeraAcceptanceTest |
	subject := self describedClass new.
	subject addClass: HeraAcceptanceTestWithStepArgumentsForTesting.
	stepMethods := subject allStepMethods.
	stepMethodsOfClass := HeraAcceptanceTestWithStepArgumentsForTesting stepMethods.
	stepMethodsOfHeraSpecAcceptanceTest := HeraSpecAcceptanceTest stepMethods.
	stepMethodsOfHeraAcceptanceTest := HeraAcceptanceTest stepMethods.
	self assert: (stepMethods includesAll: stepMethodsOfClass).
	self assert: (stepMethods includesAll: stepMethodsOfHeraSpecAcceptanceTest).
	self assert: (stepMethods includesAll: stepMethodsOfHeraAcceptanceTest).
	self assert: stepMethods size equals: stepMethodsOfClass size + stepMethodsOfHeraSpecAcceptanceTest size + stepMethodsOfHeraAcceptanceTest size
]

{ #category : 'tests' }
HeraScopeTestCase >> testAllStepMethodsWhenScopeIsEmpty [

	self assert: subject allStepMethods isEmpty
]

{ #category : 'tests' }
HeraScopeTestCase >> testAllStepMethodsWhenTwoClassInScope [
	"Verify that superclasses are not considered twice."

	| stepMethods stepMethodsOfClassOne stepMethodsOfHeraSpecAcceptanceTest stepMethodsOfHeraAcceptanceTest stepMethodsOfClassTwo |
	subject := self describedClass new.
	subject
		addClass: HeraAcceptanceTestWithStepArgumentsForTesting;
		addClass: HeraAcceptanceTestWithPassForTesting.
	stepMethods := subject allStepMethods.
	stepMethodsOfClassOne := HeraAcceptanceTestWithStepArgumentsForTesting stepMethods.
	stepMethodsOfClassTwo := HeraAcceptanceTestWithPassForTesting stepMethods.
	stepMethodsOfHeraSpecAcceptanceTest := HeraSpecAcceptanceTest stepMethods.
	stepMethodsOfHeraAcceptanceTest := HeraAcceptanceTest stepMethods.
	self assert: (stepMethods includesAll: stepMethodsOfClassOne).
	self assert: (stepMethods includesAll: stepMethodsOfClassTwo).
	self assert: (stepMethods includesAll: stepMethodsOfHeraSpecAcceptanceTest).
	self assert: (stepMethods includesAll: stepMethodsOfHeraAcceptanceTest).
	self assert: stepMethods size equals: stepMethodsOfClassOne size + stepMethodsOfClassTwo size + stepMethodsOfHeraSpecAcceptanceTest size + stepMethodsOfHeraAcceptanceTest size
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
