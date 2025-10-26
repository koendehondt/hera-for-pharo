Class {
	#name : 'HeraSpecExamplesAcceptanceTest',
	#superclass : 'HeraSpecAcceptanceTest',
	#category : 'Hera-Documentation-Example features',
	#package : 'Hera-Documentation',
	#tag : 'Example features'
}

{ #category : 'accessing' }
HeraSpecExamplesAcceptanceTest class >> nameInBrowser [

	^ 'Spec documentation and examples'
]

{ #category : 'features' }
HeraSpecExamplesAcceptanceTest >> featureTrees [

	<heraFeature: 'Trees'>

	^ (self feature: 'Trees')
		scenarios: {
			(self scenario: 'Describing a tree')
				when: 'I open the Family Tree application';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> { } }) .
			(self scenario: 'Expanding tree items')
				when: 'I open the Family Tree application';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> { } });
				when: 'I expand "John" in the "Family" tree';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> {
						'Jane' -> { } .
						'Mary' -> { } } });
				when: 'I expand "John >> Jane" in the "Family" tree';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> {
						'Jane' -> {
							'William' -> { } } .
						'Mary' -> { } } }) .
			(self scenario: 'Collapsing tree items')
				when: 'I open the Family Tree application';
				when: 'I expand "John" in the "Family" tree';
				and: 'I expand "John >> Jane" in the "Family" tree';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> {
						'Jane' -> {
							'William' -> { } } .
						'Mary' -> { } } });
				and: 'I collapse "John >> Jane" in the "Family" tree';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> {
						'Jane' -> { } .
						'Mary' -> { } } });
				and: 'I collapse "John" in the "Family" tree';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> { } }) .
			(self scenario: 'Expanded/collapsed state')
				when: 'I open the Family Tree application';
				when: 'I expand "John" in the "Family" tree';
				and: 'I expand "John >> Jane" in the "Family" tree';
				then: '"John" is expanded in the "Family" tree';
				then: '"John >> Jane" is expanded in the "Family" tree';
				then: '"John >> Jane >> William" is collapsed in the "Family" tree';
				then: '"John >> Mary" is collapsed in the "Family" tree';
				when: 'I collapse "John >> Jane" in the "Family" tree';
				then: '"John >> Jane" is collapsed in the "Family" tree';
				when: 'I collapse "John" in the "Family" tree';
				then: '"John" is collapsed in the "Family" tree' .
			(self scenario: 'Selecting tree items')
				when: 'I open the Family Tree application';
				when: 'I expand "John" in the "Family" tree';
				and: 'I expand "John >> Jane" in the "Family" tree';
				when: 'I select "John >> Jane >> William" in the "Family" tree';
				then: '"John >> Jane >> William" is selected in the "Family" tree' .
			(self scenario: 'Selection state')
				when: 'I open the Family Tree application';
				then: '"John" is not selected in the "Family" tree';
				when: 'I expand "John" in the "Family" tree';
				then: '"John" is selected in the "Family" tree';
				when: 'I expand "John >> Jane" in the "Family" tree';
				then: '"John >> Jane" is selected in the "Family" tree' }
]

{ #category : 'steps' }
HeraSpecExamplesAcceptanceTest >> stepIOpenTheFamilyTreeApplication [

	<heraStepDefinition: #(When 'I open the Family Tree application')>

	self openPresenter: HeraExampleSpecApplication new as: #familyTree
]
