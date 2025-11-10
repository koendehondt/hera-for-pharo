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
HeraFilteredStepsTestCase >> testTableItemsAreSortedCaseInsensitively [

	subject
		scope: (HeraScope new addClass: PharoFinderAcceptanceTest);
		filter: HeraAllStepsFilter new.
	self
		assert: (subject tableItems collect: [ :each | each stepDescription ])
		equals: {
			'I activate the {string} window' .
			'I check "Case"' .
			'I check "Exact"' .
			'I check the {string} checkbox' .
			'I close the {string} window' .
			'I collapse {string} in the {string} tree' .
			'I debug' .
			'I do not see the {string} window' .
			'I double click {string} in the {string} tree' .
			'I expand {string} in the {string} tree' .
			'I fill in {string} in the {string} field' .
			'I search for {string}' .
			'I search in {word} for {string}' .
			'I see an empty {string} list' .
			'I see exactly the following items in the {string} list:' .
			'I see the following matching methods:' .
			'I see the following selected items in the {string} list:' .
			'I see the following {string} tree:' .
			'I see the {string} window' .
			'I see {string} in the {string} field' .
			'I select item {int} in the {string} list' .
			'I select items {} in the {string} list' .
			'I select the {string} radio button' .
			'I select {string} in the {string} tree' .
			'I uncheck "Substring"' .
			'I uncheck the {string} checkbox' .
			'the Finder is open' .
			'the search mode is {string}' .
			'the {string} checkbox is checked' .
			'the {string} checkbox is unchecked' .
			'the {string} radio button is off' .
			'the {string} radio button is on' .
			'{string} is collapsed in the {string} tree'  .
			'{string} is expanded in the {string} tree' .
			'{string} is not selected in the {string} tree' .
			'{string} is selected in the {string} tree' } asOrderedCollection
]
