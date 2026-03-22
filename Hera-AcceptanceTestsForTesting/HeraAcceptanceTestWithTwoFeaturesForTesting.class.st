Class {
	#name : 'HeraAcceptanceTestWithTwoFeaturesForTesting',
	#superclass : 'HeraAcceptanceTestForTesting',
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'features' }
HeraAcceptanceTestWithTwoFeaturesForTesting >> featureOne [

	<heraFeature: 'One'>

	^ (self feature: 'One')
		tags: {
			#tag_feature_one };
		scenarios: {
			(self scenario: '1A')
				tags: {
					#tag_scenario_1A };
				when: 'I do something';
				then: 'I see something' .
			(self scenario: '1B')
				tags: {
					#tag_scenario_1B };
				when: 'I do something';
				then: 'I see something' }
]

{ #category : 'features' }
HeraAcceptanceTestWithTwoFeaturesForTesting >> featureTwo [

	<heraFeature: 'Two'>

	^ (self feature: 'Two')
		tags: {
			#tag_feature_two };
		scenarios: {
			(self scenario: '2A')
				tags: {
					#tag_scenario_2A };
				when: 'I do something';
				then: 'I see something' .
			(self scenario: '2B')
				tags: {
					#tag_scenario_2B };
				when: 'I do something';
				then: 'I see something' };
		rules: {
			(self rule: 'R')
				scenarios: {
					(self scenario: 'RA')
						tags: {
							#tag_scenario_RA };
						when: 'I do something';
						then: 'I see something' .
					(self scenario: 'RB')
						when: 'I do something';
						then: 'I see something' } }
]

{ #category : 'steps' }
HeraAcceptanceTestWithTwoFeaturesForTesting >> stepIDoSomething [

	<heraStepDefinition: #(When 'I do something')>
]

{ #category : 'steps' }
HeraAcceptanceTestWithTwoFeaturesForTesting >> stepISeeSomething [

	<heraStepDefinition: #(Then 'I see something')>
]
