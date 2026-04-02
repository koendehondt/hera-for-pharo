Extension { #name : 'String' }

{ #category : '*Hera' }
String >> heraParameterFormat: aDictionary [
	"Replace all parameters in the receiver by their replacements in aDictionary, which maps Strings to Strings.
	 Do not replace a parameter if it is not included in aDictionary."

	| matcher |
	matcher := RxMatcher forString: '<([^<>\s]+)>'.
	^ matcher
		copy: self
		translatingMatchesUsing: [ :match |
			| name |
			name := match copyFrom: 2 to: match size - 1.
			aDictionary at: name ifAbsent: [ match ] ]
]

{ #category : '*Hera' }
String >> heraPluralizeFor: aNumber [

	^'{1} {2}' format: { aNumber . self asPluralBasedOn: aNumber }
]
