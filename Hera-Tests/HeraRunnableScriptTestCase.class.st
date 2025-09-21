Class {
	#name : 'HeraRunnableScriptTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Instructions',
	#package : 'Hera-Tests',
	#tag : 'Instructions'
}

{ #category : 'running' }
HeraRunnableScriptTestCase >> describedClass [

	^ HeraRunnableScript
]

{ #category : 'tests' }
HeraRunnableScriptTestCase >> testInstructions [

	| acceptanceTest scenarios firstScenario secondScenario feature firstScenarioSteps secondScenarioSteps |
	acceptanceTest := HeraAcceptanceTestExamplesForTesting selector: #featureWithTwoScenarios.
	feature := acceptanceTest feature.
	subject acceptanceTests: { acceptanceTest }.
	scenarios := feature scenarios.
	firstScenario := scenarios first.
	secondScenario := scenarios second.
	firstScenarioSteps := firstScenario steps.
	secondScenarioSteps := secondScenario steps.
	self assert: subject instructions equals: {
		(HeraStartFeaturesInstruction for: 1) .
		(HeraStartFeatureInstruction for: acceptanceTest) .
		(HeraStartScenarioInstruction for: firstScenario) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: firstScenarioSteps first) .
		(HeraRunStepInstruction for: firstScenarioSteps second) .
		(HeraRunStepInstruction for: firstScenarioSteps third) .
		(HeraRunStepInstruction for: firstScenarioSteps fourth) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		(HeraStartScenarioInstruction for: secondScenario) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: secondScenarioSteps first) .
		(HeraRunStepInstruction for: secondScenarioSteps second) .
		(HeraRunStepInstruction for: secondScenarioSteps third) .
		(HeraRunStepInstruction for: secondScenarioSteps fourth) .
		(HeraRunStepInstruction for: secondScenarioSteps fifth) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndFeatureInstruction new .
		HeraEndFeaturesInstruction new .
		HeraResultSummaryInstruction new } asOrderedCollection
]

{ #category : 'tests' }
HeraRunnableScriptTestCase >> testInstructionsForMultipleFeatures [

	| acceptanceTest1 acceptanceTest2 scenarios2 firstScenario2 secondScenario2 firstScenarioSteps secondScenarioSteps feature1 feature2 scenarios1 firstScenario1 firstScenarioSteps1 |
	acceptanceTest1 := HeraAcceptanceTestExamplesForTesting selector: #featureWithError.
	acceptanceTest2 := HeraAcceptanceTestExamplesForTesting selector: #featureWithTwoScenarios.
	feature1 := acceptanceTest1 feature.
	feature2 := acceptanceTest2 feature.
	subject acceptanceTests: { acceptanceTest1 . acceptanceTest2 }.
	scenarios1 := feature1 scenarios.
	scenarios2 := feature2 scenarios.
	firstScenario1 := scenarios1 first.
	firstScenarioSteps1 := firstScenario1 steps.
	firstScenario2 := scenarios2 first.
	secondScenario2 := scenarios2 second.
	firstScenarioSteps := firstScenario2 steps.
	secondScenarioSteps := secondScenario2 steps.
	self assert: subject instructions equals: {
		(HeraStartFeaturesInstruction for: 2) .
		(HeraStartFeatureInstruction for: acceptanceTest1) .
		(HeraStartScenarioInstruction for: firstScenario1) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: firstScenarioSteps1 first) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndFeatureInstruction new .		
		(HeraStartFeatureInstruction for: acceptanceTest2) .
		(HeraStartScenarioInstruction for: firstScenario2) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: firstScenarioSteps first) .
		(HeraRunStepInstruction for: firstScenarioSteps second) .
		(HeraRunStepInstruction for: firstScenarioSteps third) .
		(HeraRunStepInstruction for: firstScenarioSteps fourth) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		(HeraStartScenarioInstruction for: secondScenario2) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: secondScenarioSteps first) .
		(HeraRunStepInstruction for: secondScenarioSteps second) .
		(HeraRunStepInstruction for: secondScenarioSteps third) .
		(HeraRunStepInstruction for: secondScenarioSteps fourth) .
		(HeraRunStepInstruction for: secondScenarioSteps fifth) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndFeatureInstruction new .
		HeraEndFeaturesInstruction new .
		HeraResultSummaryInstruction new } asOrderedCollection
]

{ #category : 'tests' }
HeraRunnableScriptTestCase >> testInstructionsWithBackground [

	| acceptanceTest firstScenario secondScenario feature firstScenarioSteps secondScenarioSteps instructions backgroundStep backgroundInstruction |
	acceptanceTest := HeraAcceptanceTestExamplesForTesting selector: #featureWithBackground.
	feature := acceptanceTest feature.
	subject acceptanceTests: { acceptanceTest }.
	firstScenario := feature scenarios first.
	secondScenario := feature scenarios second.
	firstScenarioSteps := firstScenario steps.
	secondScenarioSteps := secondScenario steps.
	instructions := subject instructions.
	self assert: instructions equals: {
		(HeraStartFeaturesInstruction for: 1) .
		(HeraStartFeatureInstruction for: acceptanceTest) .
		(HeraBackgroundInstruction new background: feature background) .
		(HeraStartScenarioInstruction for: firstScenario) .
		HeraBeforeScenarioHookInstruction new .
		(HeraBackgroundStepInstruction new stepInstruction: (HeraRunStepInstruction for: feature background steps first)).
		(HeraBackgroundStepInstruction new stepInstruction: (HeraRunStepInstruction for: feature background steps second)).
		(HeraBackgroundStepInstruction new stepInstruction: (HeraRunStepInstruction for: feature background steps third)).
		(HeraRunStepInstruction for: firstScenarioSteps first) .
		(HeraRunStepInstruction for: firstScenarioSteps second) .
		(HeraRunStepInstruction for: firstScenarioSteps third) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		(HeraStartScenarioInstruction for: secondScenario) .
		HeraBeforeScenarioHookInstruction new .
		(HeraBackgroundStepInstruction new stepInstruction: (HeraRunStepInstruction for: feature background steps first)).
		(HeraBackgroundStepInstruction new stepInstruction: (HeraRunStepInstruction for: feature background steps second)).
		(HeraBackgroundStepInstruction new stepInstruction: (HeraRunStepInstruction for: feature background steps third)).
		(HeraRunStepInstruction for: secondScenarioSteps first) .
		(HeraRunStepInstruction for: secondScenarioSteps second) .
		(HeraRunStepInstruction for: secondScenarioSteps third) .
		(HeraRunStepInstruction for: secondScenarioSteps fourth) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndFeatureInstruction new .
		HeraEndFeaturesInstruction new .
		HeraResultSummaryInstruction new } asOrderedCollection.
	backgroundStep := feature background steps first.
	backgroundInstruction := (instructions at: 6) stepInstruction.
	self assert: backgroundInstruction equals: (HeraRunStepInstruction for: backgroundStep).
	backgroundInstruction := (instructions at: 16) stepInstruction.
	self assert: backgroundInstruction equals: (HeraRunStepInstruction for: backgroundStep)
]

{ #category : 'tests' }
HeraRunnableScriptTestCase >> testInstructionsWithDataTable [

	| acceptanceTest scenario feature steps |
	acceptanceTest := HeraAcceptanceTestExamplesForTesting selector: #featureWithDataTable.
	feature := acceptanceTest feature.
	subject acceptanceTests: { acceptanceTest }.
	scenario := feature scenarios first.
	steps := scenario steps.
	self assert: subject instructions equals: {
		(HeraStartFeaturesInstruction for: 1) .
		(HeraStartFeatureInstruction for: acceptanceTest) .
		(HeraStartScenarioInstruction for: scenario) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: steps first) .
		(HeraRunStepInstruction for: steps second) .
		(HeraRunStepInstruction for: steps third) .
		(HeraRunStepInstruction for: steps fourth) .
		(HeraRunStepInstruction for: steps fifth) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndFeatureInstruction new .
		HeraEndFeaturesInstruction new .
		HeraResultSummaryInstruction new } asOrderedCollection
]

{ #category : 'tests' }
HeraRunnableScriptTestCase >> testInstructionsWithFilter [

	| acceptanceTest scenarios secondScenario feature secondScenarioSteps |
	acceptanceTest := HeraAcceptanceTestExamplesForTesting selector: #featureWithTwoScenarios.
	feature := acceptanceTest feature.
	scenarios := feature scenarios.
	self assert: scenarios size equals: 2.
	subject acceptanceTests: { acceptanceTest }.
	subject filter: (HeraScenarioFilter new title: 'Unsuccessful sign-in').
	secondScenario := scenarios second.
	secondScenarioSteps := secondScenario steps.
	self assert: subject instructions equals: {
		(HeraStartFeaturesInstruction for: 1) .
		(HeraStartFeatureInstruction for: acceptanceTest) .
		(HeraStartScenarioInstruction for: secondScenario) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: secondScenarioSteps first) .
		(HeraRunStepInstruction for: secondScenarioSteps second) .
		(HeraRunStepInstruction for: secondScenarioSteps third) .
		(HeraRunStepInstruction for: secondScenarioSteps fourth) .
		(HeraRunStepInstruction for: secondScenarioSteps fifth) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndFeatureInstruction new .
		HeraEndFeaturesInstruction new .
		HeraResultSummaryInstruction new } asOrderedCollection
]

{ #category : 'tests' }
HeraRunnableScriptTestCase >> testInstructionsWithRules [

	| acceptanceTest scenarios feature scenario scenarioSteps rules firstRule secondRule firstScenarioInFirstRule stepsInFirstScenarioInFirstRule secondScenarioInFirstRule stepsInSecondScenarioInFirstRule scenarioInSecondRule stepsInScenarioInSecondRule |
	acceptanceTest := HeraAcceptanceTestExamplesForTesting selector: #featureWithRules.
	feature := acceptanceTest feature.
	subject acceptanceTests: { acceptanceTest }.
	scenarios := feature scenarios.
	scenario := scenarios first.
	scenarioSteps := scenario steps.
	rules := feature rules.
	firstRule := rules first.
	secondRule := rules second.
	firstScenarioInFirstRule := firstRule scenarios first.
	stepsInFirstScenarioInFirstRule := firstScenarioInFirstRule steps.
	secondScenarioInFirstRule := firstRule scenarios second.
	stepsInSecondScenarioInFirstRule := secondScenarioInFirstRule steps.
	scenarioInSecondRule := secondRule scenarios first.
	stepsInScenarioInSecondRule := scenarioInSecondRule steps.
	self assert: subject instructions equals: {
		(HeraStartFeaturesInstruction for: 1) .
		(HeraStartFeatureInstruction for: acceptanceTest) .
		(HeraBackgroundInstruction new background: feature background) .
		(HeraStartScenarioInstruction for: scenario) .
		HeraBeforeScenarioHookInstruction new .
		(HeraBackgroundStepInstruction new stepInstruction: (HeraRunStepInstruction for: feature background steps first)).
		(HeraRunStepInstruction for: scenarioSteps first) .
		(HeraRunStepInstruction for: scenarioSteps second) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .

		(HeraStartRuleInstruction for: firstRule) .
		(HeraBackgroundInstruction new background: firstRule background) .
		(HeraStartScenarioInstruction for: firstScenarioInFirstRule) .
		HeraBeforeScenarioHookInstruction new .
		(HeraBackgroundStepInstruction new stepInstruction: (HeraRunStepInstruction for: firstRule background steps first)).
		(HeraRunStepInstruction for: stepsInFirstScenarioInFirstRule first) .
		(HeraRunStepInstruction for: stepsInFirstScenarioInFirstRule second) .
		(HeraRunStepInstruction for: stepsInFirstScenarioInFirstRule third) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		(HeraStartScenarioInstruction for: secondScenarioInFirstRule) .
		HeraBeforeScenarioHookInstruction new .
		(HeraBackgroundStepInstruction new stepInstruction: (HeraRunStepInstruction for: firstRule background steps first)).
		(HeraRunStepInstruction for: stepsInSecondScenarioInFirstRule first) .
		(HeraRunStepInstruction for: stepsInSecondScenarioInFirstRule second) .
		(HeraRunStepInstruction for: stepsInSecondScenarioInFirstRule third) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndRuleInstruction new .

		(HeraStartRuleInstruction for: secondRule) .
		(HeraStartScenarioInstruction for: scenarioInSecondRule) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: stepsInScenarioInSecondRule first) .
		(HeraRunStepInstruction for: stepsInScenarioInSecondRule second) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndRuleInstruction new .

		HeraEndFeatureInstruction new .
		HeraEndFeaturesInstruction new .
		HeraResultSummaryInstruction new } asOrderedCollection
]

{ #category : 'tests' }
HeraRunnableScriptTestCase >> testInstructionsWithStarSteps [

	| acceptanceTest scenarios feature scenario scenarioSteps |
	acceptanceTest := HeraAcceptanceTestExamplesForTesting selector: #featureWithStarSteps.
	feature := acceptanceTest feature.
	subject acceptanceTests: { acceptanceTest }.
	scenarios := feature scenarios.
	scenario := scenarios first.
	scenarioSteps := scenario steps.
	self assert: subject instructions equals: {
		(HeraStartFeaturesInstruction for: 1) .
		(HeraStartFeatureInstruction for: acceptanceTest) .
		(HeraStartScenarioInstruction for: scenario) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: scenarioSteps first) .
		(HeraRunStepInstruction for: scenarioSteps second) .
		(HeraRunStepInstruction for: scenarioSteps third) .
		(HeraRunStepInstruction for: scenarioSteps fourth) .
		(HeraRunStepInstruction for: scenarioSteps fifth) .
		(HeraRunStepInstruction for: scenarioSteps sixth) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndFeatureInstruction new .
		HeraEndFeaturesInstruction new .
		HeraResultSummaryInstruction new } asOrderedCollection
]
