Extension { #name : 'StFinderSearchBar' }

{ #category : '*Hera-Pharo-AcceptanceTests' }
StFinderSearchBar >> heraPresenterAt: aPresenterName ifAbsent: absentBlock [

	| mapping |
	mapping := Dictionary new
		add: 'Query' -> searchInput;
		add: 'Search mode' -> searchModeDropList;
		add: 'Search' -> searchButton;
		yourself.
	^ mapping at: aPresenterName ifAbsent: absentBlock
]
