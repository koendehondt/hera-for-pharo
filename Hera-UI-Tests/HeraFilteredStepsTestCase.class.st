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
			'I check "Case"' .
			'I check "Exact"' .
			'I collapse {string} in the {string} tree' .
			'I debug' .
			'I expand {string} in the {string} tree' .
			'I search for {string}' .
			'I search in {word} for {string}' .
			'I see the following matching methods:' .
			'I see the following {string} tree:' .
			'I select {string} in the {string} tree' .
			'I uncheck "Substring"' .
			'the Finder is open' .
			'the search mode is {string}' .
			'{string} is collapsed in the {string} tree'  .
			'{string} is expanded in the {string} tree' .
			'{string} is not selected in the {string} tree' .
			'{string} is selected in the {string} tree' } asOrderedCollection
]
