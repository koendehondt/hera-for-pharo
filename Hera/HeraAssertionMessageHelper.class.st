Class {
	#name : 'HeraAssertionMessageHelper',
	#superclass : 'Object',
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'accessing' }
HeraAssertionMessageHelper >> comparingAdditional: additionalElements missing: missingElements [

	^ String streamContents: [ :stream |
		 stream
			 nextPutAll: 'Given Collections do not match!';
			 crtab;
			 nextPutAll: 'additions: ';
			 print: additionalElements asArray;
			 crtab;
			 nextPutAll: 'missing: ';
			 print: missingElements asArray ]
]

{ #category : 'accessing' }
HeraAssertionMessageHelper >> comparingCollectionBetween: actualCollection and: expectedCollections [
	"Returns a string that shows the size if they are different and the additional items for each collection."

	| additionalLeft additionalRight sortBlock |
	"use a very slow sort block"
	sortBlock := [ :a :b | a asString <= b asString ].
	additionalLeft := (actualCollection difference: expectedCollections) sorted: sortBlock.
	additionalRight := (expectedCollections difference: actualCollection) sorted: sortBlock.
	^ String
		streamContents: [ :stream |
			stream
				nextPutAll: 'Given Collections do not match. Got ';
				crtab;
				nextPutAll: 'left = ';
				print: actualCollection;
				cr;
				nextPutAll: 'instead of';
				crtab;
				nextPutAll: 'right = ';
				print: expectedCollections;
				cr.
			actualCollection size = expectedCollections size
				ifFalse: [ stream
						nextPutAll: 'Collection size does not match: left=';
						print: actualCollection size;
						nextPutAll: ' vs. right=';
						print: expectedCollections size;
						cr ].
			additionalLeft isEmpty
				ifFalse: [ stream
						nextPutAll: 'Got ';
						print: additionalLeft size;
						nextPutAll: ' additional element(s) in the left collection: ';
						tab;
						print: additionalLeft ].
			additionalRight isEmpty
				ifFalse: [ stream
						nextPutAll: 'Got ';
						print: additionalRight size;
						nextPutAll: ' additional element(s) in the right collection: ';
						tab;
						print: additionalRight ] ]
]

{ #category : 'accessing' }
HeraAssertionMessageHelper >> comparingIdentityStringBetween: actualObject and: expectedObject [

	^ String streamContents: [ :stream |
		  stream
			  print: actualObject;
			  nextPutAll: ' is not identical to ';
			  print: expectedObject;
			  nextPut: $. ]
]

{ #category : 'accessing' }
HeraAssertionMessageHelper >> comparingStringBetween: actualObject and: expectedObject [

	^ String streamContents: [:stream |
		stream
			nextPutAll: 'Got ';
			nextPutAll: actualObject fullPrintString;
			nextPutAll: ' instead of ';
			nextPutAll: expectedObject fullPrintString;
			nextPutAll: '.']
]
