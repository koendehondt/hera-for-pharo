Class {
	#name : 'HeraFilteredStepsTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Step Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Step Browser'
}

{ #category : 'running' }
HeraFilteredStepsTestCase >> describedClass [

	^ HeraFilteredSteps
]

{ #category : 'tests' }
HeraFilteredStepsTestCase >> testFilteredStepsAreSortedCaseInsensitively [

	subject
		scope: (HeraScope new addClass: PharoFinderAcceptanceTest);
		stepFilterCriteria: HeraStepFilterCriteria new;
		filterSteps.
	self
		assert: (subject filteredSteps collect: [ :each | each fullStepDescription ])
		equals: {
			'Given the Finder is open' .
			'Given the search mode is {string}' .
			'Then I do not see the {string} window' .
			'Then I see an empty {string} list' .
			'Then I see exactly the following items in the {string} list:' .
			'Then I see the following matching methods:' .
			'Then I see the following selected items in the {string} list:' .
			'Then I see the following {string} tree:' .
			'Then I see the {string} window' .
			'Then I see {string} in the {string} field' .
			'Then the {string} checkbox is checked' .
			'Then the {string} checkbox is unchecked' .
			'Then the {string} radio button is off' .
			'Then the {string} radio button is on' .
			'Then {string} is collapsed in the {string} tree' .
			'Then {string} is expanded in the {string} tree' .
			'Then {string} is not selected in the {string} tree' .
			'Then {string} is selected in the {string} tree' .
			'When I activate the {string} window' .
			'When I check "Case"' .
			'When I check "Exact"' .
			'When I check the {string} checkbox' .
			'When I close the {string} window' .
			'When I collapse {string} in the {string} tree' .
			'When I debug' .
			'When I double click {string} in the {string} tree' .
			'When I expand {string} in the {string} tree' .
			'When I fill in {string} in the {string} field' .
			'When I search for {string}' .
			'When I search in {word} for {string}' .
			'When I select item {int} in the {string} list' .
			'When I select items {} in the {string} list' .
			'When I select the {string} radio button' .
			'When I select {string} in the {string} tree' .
			'When I uncheck "Substring"' .
			'When I uncheck the {string} checkbox' } asOrderedCollection
]
