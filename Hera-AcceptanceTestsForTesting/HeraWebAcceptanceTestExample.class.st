Class {
	#name : 'HeraWebAcceptanceTestExample',
	#superclass : 'HeraWebAcceptanceTest',
	#category : 'Hera-AcceptanceTestsForTesting',
	#package : 'Hera-AcceptanceTestsForTesting'
}

{ #category : 'testing' }
HeraWebAcceptanceTestExample class >> isHeraExample [

	^ true
]

{ #category : 'features' }
HeraWebAcceptanceTestExample >> featureDescribingWebPageBehavior [

	<heraFeature: 'Describing web page behavior'>

	^ (self feature: 'Describing web page behavior')
		scenarios: {
			(self scenario: 'Search Pharo on Wikipedia')
				description: {
					'Inspired by https://github.com/SeasideSt/Parasol?tab=readme-ov-file#example' };
				when: 'I open https://en.wikipedia.org/';
				and: 'I enter "Pharo" in the "Search Wikipedia" field';
				then: 'the current URL is https://en.wikipedia.org/wiki/Pharo';
				and: 'I see a page with main header "Pharo"' }
]
