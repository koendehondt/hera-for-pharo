Extension { #name : 'StFinderSearchOptions' }

{ #category : '*Hera-Pharo-AcceptanceTests' }
StFinderSearchOptions >> heraPresenterAt: aPresenterName ifAbsent: absentBlock [

	| mapping |
	mapping := Dictionary new
		add: 'Substring' -> substringBox;
		add: 'Regexp' -> regexpCheckBox;
		add: 'Exact' -> exactCheckBox;
		add: 'Case' -> caseCheckBox;
		yourself.
	^ mapping at: aPresenterName ifAbsent: absentBlock
]
