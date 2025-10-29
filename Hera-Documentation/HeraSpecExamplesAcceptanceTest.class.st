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
HeraSpecExamplesAcceptanceTest >> featureLists [

	<heraFeature: 'Lists'>

	^ (self feature: 'Lists')
		scenarios: {
			(self scenario: 'Empty list')
				when: 'I open the Family Tree application';
				then: 'I see an empty "Children" list' .
			(self scenario: 'Non-empty list')
				when: 'I open the Family Tree application';
				when: 'I select "John" in the "Family" tree';
				then: 'I see exactly the following items in the "Children" list:' with: (self dataTable: {
					{ 'Jane' } .
					{ 'Mary' } }) }
]

{ #category : 'features' }
HeraSpecExamplesAcceptanceTest >> featureTrees [

	<heraFeature: 'Trees'>

	^ (self feature: 'Trees')
		scenarios: {
			(self scenario: 'Tree with one root')
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

{ #category : 'steps' }
HeraSpecExamplesAcceptanceTest >> stepISeeAnEmptyListNamed: aListPresenterName [

	<heraStepDefinition: #(Then match 'I see an empty {string} list')>

	| list |
	list := self activePresenter
		heraWidgetAt: aListPresenterName
		ifAbsent: [ self error: 'The list cannot be found.' ].
	self assert: list items isEmpty description: [ 'The list has {1}.' format: { 'item' heraPluralizeFor: list listSize } ]
]

{ #category : 'steps' }
HeraSpecExamplesAcceptanceTest >> stepISeeTheListNamed: aListPresenterName withTheFollowingItems: aDataTable [

	<heraStepDefinition: #(Then match 'I see exactly the following items in the {string} list:')>

	| list actualItems expectedItems |
	list := self activePresenter
		heraWidgetAt: aListPresenterName
		ifAbsent: [ self error: 'The list cannot be found.' ].
	actualItems := list items.
	expectedItems := aDataTable asArray.
	self
		assert: actualItems size = expectedItems size
		description: [ 'The list has {1}, but the data table has {2}.' format: { 'item' heraPluralizeFor: actualItems size . 'item' heraPluralizeFor: expectedItems size } ].
	expectedItems withIndexDo: [ :expectedItem :index | | actualItem |
		actualItem := list display value: (actualItems at: index).
		self
			assert: expectedItem = actualItem
			description: [ 'Row {1}: Expected {2}, but found {3}.' format: { index . expectedItem . actualItem } ] ]
]
