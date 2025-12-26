Extension { #name : 'Collection' }

{ #category : '*Hera' }
Collection >> asCommaSeparatedDoubleQuotedStrings [

	^ ', ' join: (self collect: [ :each | '"{1}"' format: { each } ])
]

{ #category : '*Hera' }
Collection >> heraSorted [
	"Assume that the receiver is a collection of String instances.
	 Answer a SequenceableCollection with the sorted strings, compared in a case-insentive way."

	^ self sorted: [ :some :other | some asLowercase <= other asLowercase ]
]
