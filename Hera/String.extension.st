Extension { #name : 'String' }

{ #category : '*Hera' }
String >> heraParameterFormat: aDictionary [
	"Replace all parameters in the receiver by their replacements in aDictionary, which maps Strings to Strings.
	 Do not replace a parameter if it is not included in aDictionary."

	^ self species
		new: self size
		streamContents: [ :result |
			| stream |
			stream := self readStream.
			[ stream atEnd ]
				whileFalse: [ | currentChar |
					(currentChar := stream next) == $<
						ifTrue: [ | expression |
							expression := stream upTo: $>.
							aDictionary at: expression
								ifPresent: [ :replacement | result nextPutAll: replacement]
								ifAbsent: [ result nextPut: $<; nextPutAll: expression; nextPut: $> ] ]
						ifFalse: [ currentChar == $\
								ifTrue: [ stream atEnd
										ifFalse: [ result nextPut: stream next ] ]
								ifFalse: [ result nextPut: currentChar ] ] ] ]
]

{ #category : '*Hera' }
String >> heraPluralizeFor: aNumber [

	^'{1} {2}' format: { aNumber . self asPluralBasedOn: aNumber }
]
