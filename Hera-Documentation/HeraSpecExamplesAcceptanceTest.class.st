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
HeraSpecExamplesAcceptanceTest >> featureCheckboxes [

	<heraFeature: 'Checkboxes'>

	^ (self feature: 'Checkboxes')
		background: (self background
			given: 'a family tree:' with: (self dataTree: {
				'John' -> { } }));
		scenarios: {
			(self scenario: 'Checked state, unchecked state, checking and unchecking')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				and: 'I select "John" in the "Family" tree';
				then: 'the "Disabled" checkbox is unchecked';
				when: 'I check the "Disabled" checkbox';
				then: 'the "Disabled" checkbox is checked';
				when: 'I uncheck the "Disabled" checkbox';
				then: 'the "Disabled" checkbox is unchecked' }
]

{ #category : 'features' }
HeraSpecExamplesAcceptanceTest >> featureFields [

	<heraFeature: 'Fields'>

	^ (self feature: 'Fields')
		background: (self background
			given: 'a family tree:' with: (self dataTree: {
				'John' -> {
					'Jane' -> {
						'William' -> { } } .
					'Mary' -> { } .
					'Charles' -> { } } }));
		scenarios: {
			(self scenario: 'Reading')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				and: 'I select "John" in the "Family" tree';
				then: 'I see "John" in the "Name" field' .
			(self scenario: 'Filling in')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				and: 'I select "John" in the "Family" tree';
				and: 'I fill in "John" in the "Name" field';
				then: 'I see "John" in the "Name" field' }
]

{ #category : 'features' }
HeraSpecExamplesAcceptanceTest >> featureLists [

	<heraFeature: 'Lists'>

	^ (self feature: 'Lists')
		background: (self background
			given: 'a family tree:' with: (self dataTree: {
				'John' -> {
					'Jane' -> {
						'William' -> { } } .
					'Mary' -> { } .
					'Charles' -> { } } }));
		scenarios: {
			(self scenario: 'Empty list')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				then: 'I see an empty "Children" list' .
			(self scenario: 'Non-empty list')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				when: 'I select "John" in the "Family" tree';
				then: 'I see exactly the following items in the "Children" list:' with: (self dataTable: {
					{ 'Jane' } .
					{ 'Mary' } .
					{ 'Charles' } }) .
			(self scenario: 'Single selection based on an index')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				when: 'I select "John" in the "Family" tree';
				then: 'I see exactly the following items in the "Children" list:' with: (self dataTable: {
					{ 'Jane' } .
					{ 'Mary' } .
					{ 'Charles' } });
				when: 'I select item 2 in the "Children" list';
				then: 'I see the following selected items in the "Children" list:' with: (self dataTable: {
					{ 'Mary' } });
				when: 'I select item 1 in the "Children" list';
				then: 'I see the following selected items in the "Children" list:' with: (self dataTable: {
					{ 'Jane' } });
				when: 'I select item 3 in the "Children" list';
				then: 'I see the following selected items in the "Children" list:' with: (self dataTable: {
					{ 'Charles' } }) .
			(self scenario: 'Multiple selection based on an index range')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				when: 'I select "John" in the "Family" tree';
				then: 'I see exactly the following items in the "Children" list:' with: (self dataTable: {
					{ 'Jane' } .
					{ 'Mary' } .
					{ 'Charles' } });
				when: 'I select items 1 to 2 in the "Children" list';
				then: 'I see the following selected items in the "Children" list:' with: (self dataTable: {
					{ 'Jane' } .
					{ 'Mary' } });
				when: 'I select items 2 to 2 in the "Children" list';
				then: 'I see the following selected items in the "Children" list:' with: (self dataTable: {
					{ 'Mary' } }) .
			(self scenario: 'Multiple selection based on indexes')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				when: 'I select "John" in the "Family" tree';
				then: 'I see exactly the following items in the "Children" list:' with: (self dataTable: {
					{ 'Jane' } .
					{ 'Mary' } .
					{ 'Charles' } });
				when: 'I select items 1 and 3 in the "Children" list';
				then: 'I see the following selected items in the "Children" list:' with: (self dataTable: {
					{ 'Jane' } .
					{ 'Charles' } });
				when: 'I select items 1, 2 and 3 in the "Children" list';
				then: 'I see the following selected items in the "Children" list:' with: (self dataTable: {
					{ 'Jane' } .
					{ 'Mary' } .
					{ 'Charles' } }) }
]

{ #category : 'features' }
HeraSpecExamplesAcceptanceTest >> featureRadioButtons [

	<heraFeature: 'Radio buttons'>

	^ (self feature: 'Radio buttons')
		background: (self background
			given: 'a family tree:' with: (self dataTree: {
				'John' -> { } }));
		scenarios: {
			(self scenario: 'On state, off state, turning on and off')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				and: 'I select "John" in the "Family" tree';
				then: 'the "Male" radio button is off';
				then: 'the "Female" radio button is off';
				then: 'the "Other" radio button is off';
				when: 'I select the "Male" radio button';
				then: 'the "Male" radio button is on';
				then: 'the "Female" radio button is off';
				then: 'the "Other" radio button is off';
				when: 'I select the "Female" radio button';
				then: 'the "Male" radio button is off';
				then: 'the "Female" radio button is on';
				then: 'the "Other" radio button is off';
				when: 'I select the "Other" radio button';
				then: 'the "Male" radio button is off';
				then: 'the "Female" radio button is off';
				then: 'the "Other" radio button is on' }
]

{ #category : 'features' }
HeraSpecExamplesAcceptanceTest >> featureTrees [

	<heraFeature: 'Trees'>

	^ (self feature: 'Trees')
		background: (self background
			given: 'a family tree:' with: (self dataTree: {
				'John' -> {
					'Jane' -> {
						'William' -> { } } .
					'Mary' -> { } } }));
		scenarios: {
			(self scenario: 'Tree with one root')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> { } }) .
			(self scenario: 'Expanding tree items')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
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
				then: 'I see the "Family tree of John" window';
				and: 'I expand "John" in the "Family" tree';
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
				then: 'I see the "Family tree of John" window';
				when: 'I expand "John" in the "Family" tree';
				and: 'I expand "John >> Jane" in the "Family" tree';
				then: '"John" is expanded in the "Family" tree';
				and: '"John >> Jane" is expanded in the "Family" tree';
				and: '"John >> Jane >> William" is collapsed in the "Family" tree';
				and: '"John >> Mary" is collapsed in the "Family" tree';
				when: 'I collapse "John >> Jane" in the "Family" tree';
				then: '"John >> Jane" is collapsed in the "Family" tree';
				when: 'I collapse "John" in the "Family" tree';
				then: '"John" is collapsed in the "Family" tree' .
			(self scenario: 'Selecting tree items')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				and: 'I expand "John" in the "Family" tree';
				and: 'I expand "John >> Jane" in the "Family" tree';
				and: 'I select "John >> Jane >> William" in the "Family" tree';
				then: '"John >> Jane >> William" is selected in the "Family" tree' .
			(self scenario: 'Selection state')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				then: '"John" is not selected in the "Family" tree';
				when: 'I expand "John" in the "Family" tree';
				then: '"John" is selected in the "Family" tree';
				when: 'I expand "John >> Jane" in the "Family" tree';
				then: '"John >> Jane" is selected in the "Family" tree' .
			(self scenario: 'Double clicking')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				then: 'I see the "Family tree of John" window';
				when: 'I expand "John" in the "Family" tree';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> {
						'Jane' -> { } .
						'Mary' -> { } } });
				and: 'I double click "John >> Jane" in the "Family" tree';
				then: 'I see the "Family tree of Jane" window';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'Jane' -> { } }) }
]

{ #category : 'features' }
HeraSpecExamplesAcceptanceTest >> featureWindows [

	<heraFeature: 'Windows'>

	^ (self feature: 'Windows')
		background: (self background
			given: 'a family tree:' with: (self dataTree: {
				'John' -> {
					'Jane' -> {
						'William' -> { } } .
					'Mary' -> { } .
					'Charles' -> { } } }));
		scenarios: {
			(self scenario: 'Title')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window' .
			(self scenario: 'Seeing')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				when: 'I expand "John" in the "Family" tree';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> {
						'Jane' -> { } .
						'Mary' -> { } .
						'Charles' -> { } } });
				and: 'I double click "John >> Jane" in the "Family" tree';
				then: 'I see the "Family tree of Jane" window';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'Jane' -> { } }) .
			(self scenario: 'Not seeing')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				then: 'I do not see the "Family tree of Jane" window' .
			(self scenario: 'Activating')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				when: 'I expand "John" in the "Family" tree';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> {
						'Jane' -> { } .
						'Mary' -> { } .
						'Charles' -> { } } });
				and: 'I double click "John >> Jane" in the "Family" tree';
				then: 'I see the "Family tree of Jane" window';
				when: 'I activate the "Family tree of John" window';
				then: 'I see the following "Family" tree:' with: (self dataTree: {
					'John' -> {
						'Jane' -> { } .
						'Mary' -> { } .
						'Charles' -> { } } }) .
			(self scenario: 'Closing')
				when: 'I open the Family Tree application';
				then: 'I see the "Family tree of John" window';
				when: 'I close the "Family tree of John" window';
				then: 'I do not see the "Family tree of John" window' }
]

{ #category : 'steps' }
HeraSpecExamplesAcceptanceTest >> stepAFamilyTree: aDataTree [
	"Assumption: single root."

	<heraStepDefinition: #(Given 'a family tree:')>

	| currentLevel family root |
	currentLevel := 0.
	family := Stack new.
	aDataTree data do: [ :dataTreeItem | | person |
		person := HeraExamplePerson new name: dataTreeItem text.
		currentLevel = 0
			ifTrue: [ root := family push: person ]
			ifFalse: [
				[currentLevel >= dataTreeItem level ]
					whileTrue: [
						family pop.
						currentLevel := currentLevel - 1 ].
				family top addChild: person.
				family push: person ].
		currentLevel := dataTreeItem level ].
	self stateAt: #focusPerson put: root
]

{ #category : 'steps' }
HeraSpecExamplesAcceptanceTest >> stepIOpenTheFamilyTreeApplication [

	<heraStepDefinition: #(When 'I open the Family Tree application')>

	HeraExampleFamilyTreePresenter new
		focusPerson: (self stateAt: #focusPerson);
		open
]
