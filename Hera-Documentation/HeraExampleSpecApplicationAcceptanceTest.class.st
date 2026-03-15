Class {
	#name : 'HeraExampleSpecApplicationAcceptanceTest',
	#superclass : 'HeraSpecAcceptanceTest',
	#traits : 'FamilyTreeStepsTrait',
	#classTraits : 'FamilyTreeStepsTrait classTrait',
	#category : 'Hera-Documentation-Family Tree - Features',
	#package : 'Hera-Documentation',
	#tag : 'Family Tree - Features'
}

{ #category : 'accessing' }
HeraExampleSpecApplicationAcceptanceTest class >> nameInBrowser [

	^ 'Spec Application Example: Family Tree'
]

{ #category : 'features' }
HeraExampleSpecApplicationAcceptanceTest >> featureManagingAFamilyTree [

	<heraFeature: 'Managing a family tree'>

	^ (self feature: 'Managing a family tree')
		scenarios: {
			(self scenario: 'Building a family tree from scratch')
				when: 'I start a new family tree';
				then: 'the "Family tree" window opens';
				when: 'I press the "Add" button';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'Unknown' -> { } });
				when: 'I fill in "John" in the "Name" field';
				and: 'I select the "Male" radio button';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> { } });
				when: 'I press the "Add" button';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> {
						'Unknown' -> { } } });
				when: 'I fill in "Jane" in the "Name" field';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> {
						'Jane' -> { } } });
				when: 'I select the "Female" radio button';
				and: 'I select "John" in the "Family" tree';
				then: 'I see "John" in the "Name" field';
				and: 'the "Male" radio button is on';
				and: 'I see exactly the following items in the "Children" list:' with: (self dataTable: {
					{ 'Jane' } }) .
			(self scenario: 'Removing a person')
				given: 'a family tree:' with: (self dataTree: {
					'John' -> {
						'Jane' -> {
							'William' -> { } } .
						'Mary' -> { } } });
				when: 'I start the Family Tree application on "John"';
				then: 'the "Family tree of John" window opens';
				when: 'I expand "John" in the "Family" tree';
				when: 'I select "John >> Jane" in the "Family" tree';
				when: 'I press the "Remove" button';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> {
						'Mary' -> { } } }) }
]
