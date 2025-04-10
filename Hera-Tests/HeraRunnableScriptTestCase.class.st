Class {
	#name : 'HeraRunnableScriptTestCase',
	#superclass : 'HeraTestCase',
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
	subject feature: feature.
	scenarios := feature scenarios.
	firstScenario := scenarios first.
	secondScenario := scenarios second.
	firstScenarioSteps := firstScenario steps.
	secondScenarioSteps := secondScenario steps.
	self assert: subject instructions equals: {
		(HeraStartFeatureInstruction for: feature) .
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
		HeraResultSummaryInstruction new } asOrderedCollection
]

{ #category : 'tests' }
HeraRunnableScriptTestCase >> testInstructionsWithBackground [

	| acceptanceTest firstScenario secondScenario feature firstScenarioSteps secondScenarioSteps instructions backgroundStep backgroundInstruction |
	acceptanceTest := HeraAcceptanceTestExamplesForTesting selector: #featureWithBackground.
	feature := acceptanceTest feature.
	subject feature: feature.
	firstScenario := feature scenarios first.
	secondScenario := feature scenarios second.
	firstScenarioSteps := firstScenario steps.
	secondScenarioSteps := secondScenario steps.
	instructions := subject instructions.
	self assert: instructions equals: {
		(HeraStartFeatureInstruction for: feature) .
		(HeraBackgroundInstruction new background: feature background) .
		(HeraStartScenarioInstruction for: firstScenario) .
		HeraBeforeScenarioHookInstruction new .
		HeraBackgroundStepInstruction new .
		(HeraRunStepInstruction for: firstScenarioSteps first) .
		(HeraRunStepInstruction for: firstScenarioSteps second) .
		(HeraRunStepInstruction for: firstScenarioSteps third) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		(HeraStartScenarioInstruction for: secondScenario) .
		HeraBeforeScenarioHookInstruction new .
		HeraBackgroundStepInstruction new .
		(HeraRunStepInstruction for: secondScenarioSteps first) .
		(HeraRunStepInstruction for: secondScenarioSteps second) .
		(HeraRunStepInstruction for: secondScenarioSteps third) .
		(HeraRunStepInstruction for: secondScenarioSteps fourth) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndFeatureInstruction new .
		HeraResultSummaryInstruction new } asOrderedCollection.
	backgroundStep := feature background steps first.
	backgroundInstruction := (instructions at: 5) stepInstruction.
	self assert: backgroundInstruction equals: (HeraRunStepInstruction for: backgroundStep).
	backgroundInstruction := (instructions at: 13) stepInstruction.
	self assert: backgroundInstruction equals: (HeraRunStepInstruction for: backgroundStep)
]

{ #category : 'tests' }
HeraRunnableScriptTestCase >> testInstructionsWithDataTable [

	| acceptanceTest scenario feature steps |
	acceptanceTest := HeraAcceptanceTestExamplesForTesting selector: #featureWithDataTable.
	feature := acceptanceTest feature.
	subject feature: feature.
	scenario := feature scenarios first.
	steps := scenario steps.
	self assert: subject instructions equals: {
		(HeraStartFeatureInstruction for: feature) .
		(HeraStartScenarioInstruction for: scenario) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: steps first) .
		(HeraRunStepInstruction for: steps second) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndFeatureInstruction new .
		HeraResultSummaryInstruction new } asOrderedCollection
]

{ #category : 'tests' }
HeraRunnableScriptTestCase >> testInstructionsWithFilter [

	| acceptanceTest scenarios secondScenario feature secondScenarioSteps |
	acceptanceTest := HeraAcceptanceTestExamplesForTesting selector: #featureWithTwoScenarios.
	feature := acceptanceTest feature.
	scenarios := feature scenarios.
	self assert: scenarios size equals: 2.
	subject feature: feature.
	subject filter: (HeraScenarioFilter new title: 'Unsuccessful sign-in').
	secondScenario := scenarios second.
	secondScenarioSteps := secondScenario steps.
	self assert: subject instructions equals: {
		(HeraStartFeatureInstruction for: feature) .
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
		HeraResultSummaryInstruction new } asOrderedCollection
]
