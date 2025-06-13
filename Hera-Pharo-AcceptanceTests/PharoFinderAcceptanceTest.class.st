Class {
	#name : 'PharoFinderAcceptanceTest',
	#superclass : 'HeraAcceptanceTest',
	#category : 'Hera-Pharo-AcceptanceTests',
	#package : 'Hera-Pharo-AcceptanceTests'
}

{ #category : 'testing' }
PharoFinderAcceptanceTest class >> isForTestingPharo [

	^ true
]

{ #category : 'features' }
PharoFinderAcceptanceTest >> featureBasicFinding [

	<heraFeature: 'Basic finding'>

	^ (self feature: 'Basic finding')
		scenarios: {
			(self scenario: 'Find in selectors')
				given: 'the Finder is open';
				when: 'I search in selectors for "stepDebug"';
				then: 'I see 3 matching methods' }
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepISearchInSelectorsForStepDebug [

	<heraStepDefinition: #(When 'I search in selectors for "stepDebug"')>

	| searchBar |
	searchBar := (self presenterAt: #finder) searchBar.
	searchBar searchInput text: 'stepDebug'.
	searchBar searchButton click
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepISeeMatchingMethods: expectedCount [

	<heraStepDefinition: #(Then match 'I see {int} matching methods')>

	| resultTree |
	resultTree := (self presenterAt: #finder) resultTree.
	self assert: resultTree roots size equals: expectedCount
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepTheFinderIsOpen [

	<heraStepDefinition: #(Given 'the Finder is open')>

	self openPresenterAs: #finder with: [ StFinderPresenter open ]
]
