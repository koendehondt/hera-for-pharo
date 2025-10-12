Class {
	#name : 'HeraStepFinderTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Analytics',
	#package : 'Hera-Tests',
	#tag : 'Analytics'
}

{ #category : 'running' }
HeraStepFinderTestCase >> describedClass [

	^ HeraStepFinder
]

{ #category : 'tests' }
HeraStepFinderTestCase >> testFindReferencesToStepInBackground [

	| expectedReferences |
	subject
		scope: (HeraScope new addClass: HeraAcceptanceTestExamplesForTesting);
		stepMethodItem: (HeraStepMethodItem new stepMethod: HeraAcceptanceTestExamplesForTesting>>#stepAPassword).
	expectedReferences := Bag
		with: (HeraFeatureMethodItem new acceptanceTestClass: HeraAcceptanceTestExamplesForTesting ; featureMethodSelector: #featureWithDescriptionInBackground)
		with: (HeraFeatureMethodItem new acceptanceTestClass: HeraAcceptanceTestExamplesForTesting ; featureMethodSelector: #featureWithBackground).
	self assert: subject findReferences equals: expectedReferences
]

{ #category : 'tests' }
HeraStepFinderTestCase >> testFindReferencesToStepInRuleBackground [

	| expectedReferences |
	subject
		scope: (HeraScope new addClass: HeraAcceptanceTestExamplesForTesting);
		stepMethodItem: (HeraStepMethodItem new stepMethod: HeraAcceptanceTestExamplesForTesting>>#stepIAmAnAdministrator).
	expectedReferences := Bag new
		add: (HeraFeatureMethodItem new acceptanceTestClass: HeraAcceptanceTestExamplesForTesting ; featureMethodSelector: #featureWithRules) withOccurrences: 2;
		yourself.
	self assert: subject findReferences equals: expectedReferences
]

{ #category : 'tests' }
HeraStepFinderTestCase >> testFindReferencesToStepInRuleScenario [

	| expectedReferences |
	subject
		scope: (HeraScope new addClass: HeraAcceptanceTestExamplesForTesting);
		stepMethodItem: (HeraStepMethodItem new stepMethod: HeraAcceptanceTestExamplesForTesting>>#stepIAddANewUser).
	expectedReferences := Bag with: (HeraFeatureMethodItem new acceptanceTestClass: HeraAcceptanceTestExamplesForTesting; featureMethodSelector: #featureWithRules).
	self assert: subject findReferences equals: expectedReferences
]

{ #category : 'tests' }
HeraStepFinderTestCase >> testFindReferencesToStepInScenario [

	| expectedReferences |
	subject
		scope: (HeraScope new addClass: HeraAcceptanceTestExamplesForTesting);
		stepMethodItem: (HeraStepMethodItem new stepMethod: HeraAcceptanceTestExamplesForTesting>>#stepIEnterMyCredentials).
	expectedReferences := Bag
		with: (HeraFeatureMethodItem new acceptanceTestClass: HeraAcceptanceTestExamplesForTesting ; featureMethodSelector:  #featureWithDescriptionInBackground)
		with: (HeraFeatureMethodItem new acceptanceTestClass: HeraAcceptanceTestExamplesForTesting ; featureMethodSelector:  #featureWithBackground)
		with: (HeraFeatureMethodItem new acceptanceTestClass: HeraAcceptanceTestExamplesForTesting ; featureMethodSelector:  #featureWithPauseStep)
		with: (HeraFeatureMethodItem new acceptanceTestClass: HeraAcceptanceTestExamplesForTesting ; featureMethodSelector:  #featureWithDebugStep)
		with: (HeraFeatureMethodItem new acceptanceTestClass: HeraAcceptanceTestExamplesForTesting ; featureMethodSelector:  #featureWithTwoScenarios).
	self assert: subject findReferences equals: expectedReferences
]
