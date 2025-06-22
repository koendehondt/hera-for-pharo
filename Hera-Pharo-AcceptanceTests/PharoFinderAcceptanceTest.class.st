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
				when: 'I search in Selectors for "stepDebug"';
				then: 'I see 2 matching methods' }
]

{ #category : 'private' }
PharoFinderAcceptanceTest >> indexOf: scope in: searchModeDropList [

	| index |
	index := searchModeDropList getList detectIndex: [ :each | each model name = scope ] ifNone: [ 0 ].
	self assert: index > 0 description: 'Search mode not found: ' , scope.
	^ index
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepISearchIn: scope for: searchString [

	<heraStepDefinition: #(When match 'I search in {word} for {string}')>

	| searchBar index |
	searchBar := (self presenterAt: #finder) searchBar.
	index := self indexOf: scope in: searchBar searchModeDropList.
	searchBar searchModeDropList selectIndex: index.
	searchBar searchInput text: searchString.
	searchBar searchButton click
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepISeeMatchingMethods: quantity [

	<heraStepDefinition: #(Then match 'I see {int} matching methods')>

	| resultTree |
	resultTree := (self presenterAt: #finder) resultTree.
	self assert: resultTree roots size equals: quantity
]

{ #category : 'steps' }
PharoFinderAcceptanceTest >> stepTheFinderIsOpen [

	<heraStepDefinition: #(Given 'the Finder is open')>

	self openPresenterAs: #finder with: [ StFinderPresenter open ]
]
