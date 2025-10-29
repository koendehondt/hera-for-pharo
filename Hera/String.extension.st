Extension { #name : 'String' }

{ #category : '*Hera' }
String >> heraPluralizeFor: aNumber [

	^'{1} {2}' format: { aNumber . self asPluralBasedOn: aNumber }
]
