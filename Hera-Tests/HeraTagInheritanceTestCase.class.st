Class {
	#name : 'HeraTagInheritanceTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraTagInheritanceTestCase >> describedClass [

	^ nil
]

{ #category : 'running' }
HeraTagInheritanceTestCase >> initializeSubject [

	subject := HeraAcceptanceTestWithTwoFeaturesForTesting new featureTwo
]

{ #category : 'tests' }
HeraTagInheritanceTestCase >> testFeatureAndRuleTagInheritance [

	| feature scenarios firstScenario secondScenario scenarioInRule rule |
	feature := HeraAcceptanceTestWithTwoFeaturesForTesting new featureTwo.
	scenarios := feature scenarios.
	firstScenario := scenarios first.
	self assert: firstScenario tags equals: { #tag_scenario_2A }.
	self assert: firstScenario inheritedTags equals: { #tag_feature_two }.
	secondScenario := scenarios second.
	self assert: secondScenario tags equals: { #tag_scenario_2B }.
	self assert: secondScenario inheritedTags equals: { #tag_feature_two }.
	rule := feature rules first.
	self assert: rule tags equals: { #tag_rule_R }.
	self assert: rule inheritedTags equals: { #tag_feature_two }.
	scenarioInRule := rule scenarios first.
	self assert: scenarioInRule tags equals: { #tag_scenario_RA }.
	self assert: scenarioInRule inheritedTags equals: { #tag_feature_two . #tag_rule_R }.
]
