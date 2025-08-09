Class {
	#name : 'PharoFinderAcceptanceTest',
	#superclass : 'HeraSpecAcceptanceTest',
	#category : 'Hera-Pharo-AcceptanceTests',
	#package : 'Hera-Pharo-AcceptanceTests'
}

{ #category : 'testing' }
PharoFinderAcceptanceTest class >> isForTestingPharo [

	^ true
]

{ #category : 'features' }
PharoFinderAcceptanceTest >> featureFinding [

	<heraFeature: 'Finding'>

	^ (self feature: 'Finding')
		scenarios: {
			(self scenario: 'Find in selectors')
				given: 'the Finder is open';
				when: 'I search in Selectors for "stepDebug"';
				then: 'I see the following matching methods:' with: (self dataTable: {
					{ 'testStepDebug' } .
					{ 'stepDebug' } }) }
]

{ #category : 'features' }
PharoFinderAcceptanceTest >> featureFindingInSelectors [

	<heraFeature: 'Finding in selectors'>

	^ (self feature: 'Finding in selectors')
		background: (self background
			given: 'the Finder is open';
			and: 'the search mode is "Selectors"');
		scenarios: {
			(self scenario: 'Substring search')
				when: 'I search for "indexOf:startingAt:ifAbsent:"';
				then: 'I see the following matching methods:' with: (self dataTable: {
					{ 'indexOf:startingAt:ifAbsent:' } .
					{ 'indexOf:startingAt:ifAbsent:using:' } .
					{ 'lastIndexOf:startingAt:ifAbsent:' } }) .
			(self scenario: 'Exact search')
				when: 'I uncheck "Substring"';
				and: 'I check "Exact"';
				and: 'I search for "indexOf:startingAt:ifAbsent:"';
				then: 'I see the following matching methods:' with: (self dataTable: {
					{ 'indexOf:startingAt:ifAbsent:' } }) .
			(self scenario: 'Case-sensitive search')
				when: 'I uncheck "Substring"';
				and: 'I check "Case"';
				and: 'I search for "indexOf:startingAt:ifAbsent:"';
				then: 'I see the following matching methods:' with: (self dataTable: {
					{ 'indexOf:startingAt:ifAbsent:' } .
					{ 'indexOf:startingAt:ifAbsent:using:' } }) }
]

{ #category : 'private' }
PharoFinderAcceptanceTest >> indexOf: scope in: searchModeDropList [

	| index |
	index := searchModeDropList getList detectIndex: [ :each | each model name = scope ] ifNone: [ 0 ].
	self assert: index > 0 description: 'Search mode not found: ' , scope.
	^ index
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepICheckCase [

	<heraStepDefinition: #(Given 'I check "Case"')>

	self check: { #finder . #searchOptions . #caseCheckBox }
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepICheckExact [

	<heraStepDefinition: #(Given 'I check "Exact"')>

	self check: { #finder . #searchOptions . #exactCheckBox }
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepISearchFor: aSearchString [

	<heraStepDefinition: #(When match 'I search for {string}')>

	self
		presenterAtPath: { #finder . #searchBar }
		do: [ :searchBar |
			searchBar searchInput text: aSearchString.
			searchBar searchButton click ]
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepISearchIn: scope for: aSearchString [

	<heraStepDefinition: #(When match 'I search in {word} for {string}')>

	| searchBar index |
	searchBar := (self presenterAt: #finder) searchBar.
	index := self indexOf: scope in: searchBar searchModeDropList.
	searchBar searchModeDropList selectIndex: index.
	searchBar searchInput text: aSearchString.
	searchBar searchButton click
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepISeeTheMatchingMethods: aDataTable [

	<heraStepDefinition: #(Then 'I see the following matching methods:')>

	| expectedSelectors resultTree roots |
	expectedSelectors := aDataTable asArray.
	resultTree := self presenterAtPath: { #finder . #resultTree }.
	roots := resultTree roots.
	self assert: roots size equals: expectedSelectors size.
	expectedSelectors withIndexDo: [ :each :index |
		self assert: (roots at: index) displayString equals: each ]
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepIUncheckSubstring [

	<heraStepDefinition: #(When 'I uncheck "Substring"')>

	self uncheck: { #finder . #searchOptions . #substringBox }	
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepTheFinderIsOpen [

	<heraStepDefinition: #(Given 'the Finder is open')>

	self openPresenterAs: #finder with: [ StFinderPresenter open ]
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepTheSearchModeIs: aSearchModeName [	

	<heraStepDefinition: #(Given match 'the search mode is {string}')>

	self
		presenterAtPath: { #finder . #searchBar . #searchModeDropList }
		do: [ :searchModeDropList | | index |
			index := self indexOf: aSearchModeName in: searchModeDropList.
			searchModeDropList selectIndex: index ]
]
