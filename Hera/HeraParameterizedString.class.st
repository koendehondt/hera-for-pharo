Class {
	#name : 'HeraParameterizedString',
	#superclass : 'Object',
	#instVars : [
		'string'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'testing' }
HeraParameterizedString >> hasParameters [

	^ self parameters isNotEmpty
]

{ #category : 'accessing' }
HeraParameterizedString >> parameters [
	"Answer a Set with the parameters."

	| matcher params |
	matcher := RxMatcher forString: '<([^<]+)>'.
	params := matcher matchesIn: string collect: [ :substring | substring copyFrom: 2 to: substring size - 1 ].
	^ params asSet
]

{ #category : 'accessing' }
HeraParameterizedString >> string: aString [

	string := aString
]
