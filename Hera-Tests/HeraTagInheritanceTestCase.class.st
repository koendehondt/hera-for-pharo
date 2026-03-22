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

	subject := (HeraAcceptanceTestWithTwoFeaturesForTesting selector: #featureTwo) feature
]

{ #category : 'tests' }
HeraTagInheritanceTestCase >> testTagInheritanceFromFeatureToScenario [

	| scenarioInFeature |
	scenarioInFeature := subject scenarios first.
	self assert: scenarioInFeature tags equals: { #tag_scenario_2A }.
	self assert: scenarioInFeature inheritedTags equals: { #tag_feature_two }
]

{ #category : 'tests' }
HeraTagInheritanceTestCase >> testTagInheritanceFromFeatureToScenarioInRule [	

	| scenarioInRule |
	scenarioInRule := subject rules first scenarios first.
	self assert: scenarioInRule tags equals: { #tag_scenario_RA }.
	self assert: scenarioInRule inheritedTags equals: { #tag_feature_two }
]
