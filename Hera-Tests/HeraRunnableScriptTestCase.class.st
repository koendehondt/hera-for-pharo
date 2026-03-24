Class {
	#name : 'HeraRunnableScriptTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Instructions',
	#package : 'Hera-Tests',
	#tag : 'Instructions'
}

{ #category : 'assertions' }
HeraRunnableScriptTestCase >> assertInstructionsFor: scenario in: acceptanceTest [

	| scenarioSteps |
	scenarioSteps := scenario steps.
	self assert: scenarioSteps size equals: 2.
	self assert: subject instructions equals: {
		(HeraStartFeaturesInstruction for: 1) .
		(HeraStartFeatureInstruction for: acceptanceTest) .
		(HeraStartScenarioInstruction for: scenario) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: scenarioSteps first) .
		(HeraRunStepInstruction for: scenarioSteps second) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndFeatureInstruction new .
		HeraEndFeaturesInstruction new .
		HeraResultSummaryInstruction new } asOrderedCollection
]

{ #category : 'assertions' }
HeraRunnableScriptTestCase >> assertInstructionsForAll: scenarios in: acceptanceTest [

	| expectedInstructions |
	expectedInstructions := OrderedCollection new.
	expectedInstructions
		add: (HeraStartFeaturesInstruction for: 1);
		add: (HeraStartFeatureInstruction for: acceptanceTest).
	scenarios do: [ :each | | steps |
		steps := each steps.
		expectedInstructions
			add: (HeraStartScenarioInstruction for: each);
			add: HeraBeforeScenarioHookInstruction new;
			add: (HeraRunStepInstruction for: steps first);
			add: (HeraRunStepInstruction for: steps second);
			add: HeraAfterScenarioHookInstruction new;
			add: HeraEndScenarioInstruction new ].
	expectedInstructions
		add: HeraEndFeatureInstruction new;
		add: HeraEndFeaturesInstruction new;
		add: HeraResultSummaryInstruction new.
	self assert: subject instructions equals: expectedInstructions
]

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
HeraRunnableScriptTestCase >> testInstructionsForScenarioOutline [

	| acceptanceTest scenarios firstScenario secondScenario feature firstScenarioSteps secondScenarioSteps |
	acceptanceTest := HeraAcceptanceTestExamplesForTesting selector: #featureWithScenarioOutline.
	feature := acceptanceTest feature.
	subject acceptanceTests: { acceptanceTest }.
	scenarios := feature scenariosWithResolvedParameters.
	firstScenario := scenarios first.
	self assert: firstScenario title equals: 'Counting apples'.
	firstScenarioSteps := firstScenario steps.
	self assert: firstScenarioSteps first description equals: 'I own 5 "apples"'.
	self assert: firstScenarioSteps second description equals: 'I buy 2 "apples"'.
	self assert: firstScenarioSteps third description equals: 'I have:'.
	self assert: firstScenarioSteps third argumentValue equals: (HeraDataTable new data: {
		{ '7' . 'apples' } } ).
	self assert: firstScenarioSteps fourth argumentValue equals: (HeraDocString new lines: {
		'Your purchase at the Fruit Shop.' .
		'' .
		'2 apples: 1.5 €' .
		'--------------------------------' .
		'Total: 1.5 €' .
		'' .
		'Thank you for your visit!' } ).
	self assert: firstScenarioSteps fifth argumentValue equals: (HeraDataTree new data: {
		HeraDataTreeItem new level: 1; text: 'Today' .
		HeraDataTreeItem new level: 2; text: 'Fruit Shop: 1.5 €' }).
	secondScenario := scenarios second.
	self assert: secondScenario title equals: 'Counting oranges'.
	secondScenarioSteps := secondScenario steps.
	self assert: secondScenarioSteps first description equals: 'I own 8 "oranges"'.
	self assert: secondScenarioSteps second description equals: 'I buy 1 "oranges"'.
	self assert: secondScenarioSteps third description equals: 'I have:'.
	self assert: secondScenarioSteps third argumentValue equals: (HeraDataTable new data: {
		{ '9' . 'oranges' } } ).
	self assert: secondScenarioSteps fourth argumentValue equals: (HeraDocString new lines: {
		'Your purchase at the Fruit Shop.' .
		'' .
		'1 oranges: 0.8 €' .
		'--------------------------------' .
		'Total: 0.8 €' .
		'' .
		'Thank you for your visit!' } ).
	self assert: secondScenarioSteps fifth argumentValue equals: (HeraDataTree new data: {
		HeraDataTreeItem new level: 1; text: 'Today' .
		HeraDataTreeItem new level: 2; text: 'Fruit Shop: 0.8 €' }).
	self assert: subject instructions equals: {
		(HeraStartFeaturesInstruction for: 1) .
		(HeraStartFeatureInstruction for: acceptanceTest) .
		(HeraStartScenarioInstruction for: firstScenario) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: firstScenarioSteps first) .
		(HeraRunStepInstruction for: firstScenarioSteps second) .
		(HeraRunStepInstruction for: firstScenarioSteps third) .
		(HeraRunStepInstruction for: firstScenarioSteps fourth) .
		(HeraRunStepInstruction for: firstScenarioSteps fifth) .
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

{ #category : 'tests - filtering' }
HeraRunnableScriptTestCase >> testInstructionsWithFilterForOneScenarioInOneFeature [

	| acceptanceTest scenarios feature |
	acceptanceTest := HeraAcceptanceTestWithTwoFeaturesForTesting selector: #featureOne.
	feature := acceptanceTest feature.
	scenarios := feature scenarios.
	self assert: scenarios size equals: 2.
	subject acceptanceTests: { acceptanceTest }.
	subject filter: (HeraScenarioTitleFilter new title: '1B').
	self assertInstructionsFor: scenarios second in: acceptanceTest
]

{ #category : 'tests - filtering' }
HeraRunnableScriptTestCase >> testInstructionsWithFilterForOneScenarioInTwoFeatures [

	| acceptanceTest1 acceptanceTest2 scenarios feature |
	acceptanceTest1 := HeraAcceptanceTestWithTwoFeaturesForTesting selector: #featureOne.
	acceptanceTest2 := HeraAcceptanceTestWithTwoFeaturesForTesting selector: #featureTwo.
	feature := acceptanceTest1 feature.
	scenarios := feature scenarios.
	self assert: scenarios size equals: 2.
	subject acceptanceTests: { acceptanceTest1 . acceptanceTest2 }.
	subject filter: (HeraScenarioTitleFilter new title: '1B').
	self assertInstructionsFor: scenarios second in: acceptanceTest1
]

{ #category : 'tests' }
HeraRunnableScriptTestCase >> testInstructionsWithRules [

	"Avoid many temporaries and nested expressions in a dynamic array. There is a maximum of 15 temporaries. That is why a dictionary is used in this method.
	 See https://github.com/pharo-project/pharo/issues/19058"

	| feature scenario stepsInFirstScenarioInFirstRule secondScenarioInFirstRule scenarioInSecondRule vars |
	vars := Dictionary new.
	vars at: #acceptanceTest put: (HeraAcceptanceTestExamplesForTesting selector: #featureWithRules).
	feature := (vars at: #acceptanceTest) feature.
	subject acceptanceTests: { vars at: #acceptanceTest }.
	scenario := feature scenarios first.
	vars at: #scenarioSteps put: scenario steps.
	vars at: #firstRule put: feature rules first.
	vars at: #secondRule put: feature rules second.
	stepsInFirstScenarioInFirstRule := (vars at: #firstRule) scenarios first steps.
	secondScenarioInFirstRule := (vars at: #firstRule) scenarios second.
	scenarioInSecondRule := (vars at: #secondRule) scenarios first.
	self assert: subject instructions equals: {
		(HeraStartFeaturesInstruction for: 1) .
		(HeraStartFeatureInstruction for: (vars at: #acceptanceTest)) .
		(HeraBackgroundInstruction new background: feature background) .
		(HeraStartScenarioInstruction for: scenario) .
		HeraBeforeScenarioHookInstruction new .
		(HeraBackgroundStepInstruction new stepInstruction: (HeraRunStepInstruction for: feature background steps first)).
		(HeraRunStepInstruction for: (vars at: #scenarioSteps) first) .
		(HeraRunStepInstruction for: (vars at: #scenarioSteps) second) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .

		(HeraStartRuleInstruction for: (vars at: #firstRule)) .
		(HeraBackgroundInstruction new background: (vars at: #firstRule) background) .
		(HeraStartScenarioInstruction for: (vars at: #firstRule) scenarios first) .
		HeraBeforeScenarioHookInstruction new .
		(HeraBackgroundStepInstruction new stepInstruction: (HeraRunStepInstruction for: (vars at: #firstRule) background steps first)).
		(HeraRunStepInstruction for: stepsInFirstScenarioInFirstRule first) .
		(HeraRunStepInstruction for: stepsInFirstScenarioInFirstRule second) .
		(HeraRunStepInstruction for: stepsInFirstScenarioInFirstRule third) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		(HeraStartScenarioInstruction for: secondScenarioInFirstRule) .
		HeraBeforeScenarioHookInstruction new .
		(HeraBackgroundStepInstruction new stepInstruction: (HeraRunStepInstruction for: (vars at: #firstRule) background steps first)).
		(HeraRunStepInstruction for: secondScenarioInFirstRule steps first) .
		(HeraRunStepInstruction for: secondScenarioInFirstRule steps second) .
		(HeraRunStepInstruction for: secondScenarioInFirstRule steps third) .
		HeraAfterScenarioHookInstruction new .
		HeraEndScenarioInstruction new .
		HeraEndRuleInstruction new .

		(HeraStartRuleInstruction for: (vars at: #secondRule)) .
		(HeraStartScenarioInstruction for: scenarioInSecondRule) .
		HeraBeforeScenarioHookInstruction new .
		(HeraRunStepInstruction for: scenarioInSecondRule steps first) .
		(HeraRunStepInstruction for: scenarioInSecondRule steps second) .
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

{ #category : 'tests - filtering' }
HeraRunnableScriptTestCase >> testInstructionsWithTagFilterForFeature [

	| acceptanceTest scenarios feature |
	acceptanceTest := HeraAcceptanceTestWithTwoFeaturesForTesting selector: #featureOne.
	feature := acceptanceTest feature.
	scenarios := feature scenarios.
	self assert: scenarios size equals: 2.
	subject acceptanceTests: { acceptanceTest }.
	subject filter: (HeraTagFilter for: '@tag_feature_one').
	self assertInstructionsForAll: scenarios in: acceptanceTest
]

{ #category : 'tests - filtering' }
HeraRunnableScriptTestCase >> testInstructionsWithTagFilterForFeatureWithRule [

	| acceptanceTest scenarios feature ruleScenarios firstScenario secondScenario expectedInstructions rules |
	acceptanceTest := HeraAcceptanceTestWithTwoFeaturesForTesting selector: #featureTwo.
	feature := acceptanceTest feature.
	scenarios := feature scenarios.
	rules := feature rules.
	ruleScenarios := rules first scenarios.
	self assert: scenarios size equals: 2.
	self assert: ruleScenarios size equals: 2.
	subject acceptanceTests: { acceptanceTest }.
	subject filter: (HeraTagFilter for: '@tag_feature_two').
	firstScenario := scenarios first.
	secondScenario := scenarios second.
	expectedInstructions := OrderedCollection new.
	expectedInstructions
		add: (HeraStartFeaturesInstruction for: 1);
		add: (HeraStartFeatureInstruction for: acceptanceTest);
		add: (HeraStartScenarioInstruction for: firstScenario);
		add: HeraBeforeScenarioHookInstruction new;
		add: (HeraRunStepInstruction for: firstScenario steps first);
		add: (HeraRunStepInstruction for: firstScenario steps second);
		add: HeraAfterScenarioHookInstruction new;
		add: HeraEndScenarioInstruction new;
		add: (HeraStartScenarioInstruction for: secondScenario);
		add: HeraBeforeScenarioHookInstruction new;
		add: (HeraRunStepInstruction for: secondScenario steps first);
		add: (HeraRunStepInstruction for: secondScenario steps second);
		add: HeraAfterScenarioHookInstruction new;
		add: HeraEndScenarioInstruction new.
	firstScenario := rules first scenarios first.
	secondScenario := rules first scenarios second.
	expectedInstructions
		add: (HeraStartRuleInstruction for: rules first);	
		add: (HeraStartScenarioInstruction for: firstScenario);
		add: HeraBeforeScenarioHookInstruction new;
		add: (HeraRunStepInstruction for: firstScenario steps first);
		add: (HeraRunStepInstruction for: firstScenario steps second);
		add: HeraAfterScenarioHookInstruction new;
		add: HeraEndScenarioInstruction new;
		add: (HeraStartScenarioInstruction for: secondScenario);
		add: HeraBeforeScenarioHookInstruction new;
		add: (HeraRunStepInstruction for: secondScenario steps first);
		add: (HeraRunStepInstruction for: secondScenario steps second);
		add: HeraAfterScenarioHookInstruction new;
		add: HeraEndScenarioInstruction new;
		add: HeraEndRuleInstruction new;
		add: HeraEndFeatureInstruction new;
		add: HeraEndFeaturesInstruction new;
		add: HeraResultSummaryInstruction new.
	self assert: subject instructions equals: expectedInstructions
]

{ #category : 'tests - filtering' }
HeraRunnableScriptTestCase >> testInstructionsWithTagFilterForOneScenarioInOneFeature [

	| acceptanceTest scenarios feature |
	acceptanceTest := HeraAcceptanceTestWithTwoFeaturesForTesting selector: #featureOne.
	feature := acceptanceTest feature.
	scenarios := feature scenarios.
	self assert: scenarios size equals: 2.
	subject acceptanceTests: { acceptanceTest }.
	subject filter: (HeraTagFilter for: '@tag_scenario_1B').
	self assertInstructionsFor: scenarios second in: acceptanceTest
]

{ #category : 'tests - filtering' }
HeraRunnableScriptTestCase >> testInstructionsWithTagFilterForOneScenarioInTwoFeatures [

	| acceptanceTest1 acceptanceTest2 scenarios feature |
	acceptanceTest1 := HeraAcceptanceTestWithTwoFeaturesForTesting selector: #featureOne.
	acceptanceTest2 := HeraAcceptanceTestWithTwoFeaturesForTesting selector: #featureTwo.
	feature := acceptanceTest1 feature.
	scenarios := feature scenarios.
	self assert: scenarios size equals: 2.
	subject acceptanceTests: { acceptanceTest1 . acceptanceTest2 }.
	subject filter: (HeraTagFilter for: '@tag_scenario_1B').
	self assertInstructionsFor: scenarios second in: acceptanceTest1
]
