Extension { #name : 'StFinderPresenter' }

{ #category : '*Hera-Pharo-AcceptanceTests' }
StFinderPresenter >> heraPresenterAt: aPresenterName ifAbsent: absentBlock [

	| mapping |
	mapping := Dictionary new
		add: 'Results' -> resultTree;
		yourself.
	mapping at: aPresenterName ifPresent: [ :presenter | ^ presenter ].
	searchBar heraPresenterAt: aPresenterName ifPresent: [ :presenter | ^ presenter ].
	^ searchOptions heraPresenterAt: aPresenterName ifAbsent: absentBlock
]
