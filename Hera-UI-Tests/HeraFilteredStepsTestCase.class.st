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
			'I search for {string}' .
			'I search in {word} for {string}' .
			'I search {string}' .
			'I see the following matching methods:' .
			'I uncheck "Substring"' .
			'the Finder is open' .
			'the search mode is {string}' }
]
