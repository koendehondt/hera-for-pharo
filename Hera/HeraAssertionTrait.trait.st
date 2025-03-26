"
I define assertion methods to be used by subclasses HeraAcceptanceTest.

The trait user has to implement #signalFailure:.
"
Trait {
	#name : 'HeraAssertionTrait',
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'asserting' }
HeraAssertionTrait >> assert: aBoolean [

	<debuggerCompleteToSender>

	self assert: aBoolean description: 'Assertion failed'
]

{ #category : 'asserting' }
HeraAssertionTrait >> assert: aBoolean description: aStringOrBlock [

	<debuggerCompleteToSender>
	
	aBoolean ifTrue: [ ^ self ].
	self signalFailure: aStringOrBlock value
]

{ #category : 'asserting' }
HeraAssertionTrait >> assert: actualObject equals: expectedObject [

	<debuggerCompleteToSender>

	self
		assert: actualObject = expectedObject
		description: [ HeraAssertionMessageHelper new comparingStringBetween: actualObject and: expectedObject ]
]

{ #category : 'asserting' }
HeraAssertionTrait >> assert: actualObject identicalTo: expectedObject [

	<debuggerCompleteToSender>

	self
		assert: actualObject == expectedObject
		description: [ HeraAssertionMessageHelper new comparingIdentityStringBetween: actualObject and: expectedObject ]
]

{ #category : 'asserting' }
HeraAssertionTrait >> assertCollection: actualCollection equals: expectedCollection [

	<debuggerCompleteToSender>

	self
		assert: actualCollection = expectedCollection
		description: [ HeraAssertionMessageHelper new comparingCollectionBetween: actualCollection and: expectedCollection ]
]

{ #category : 'asserting' }
HeraAssertionTrait >> assertCollection: actualCollection hasSameElements: expectedCollection [

	<debuggerCompleteToSender>
	
	| additionalElements missingElements |
	actualCollection = expectedCollection ifTrue: [ ^ self ].
	actualCollection asBag = expectedCollection asBag ifTrue: [ ^ self ].

	additionalElements := actualCollection difference: expectedCollection.
	missingElements := expectedCollection difference: (actualCollection intersection: expectedCollection).
	self
		assert: (additionalElements isEmpty and: [ missingElements isEmpty ])
		description: [ HeraAssertionMessageHelper new comparingAdditional: additionalElements missing: missingElements ]
]

{ #category : 'asserting' }
HeraAssertionTrait >> assertCollection: actualCollection includesAll: subcollection [

	<debuggerCompleteToSender>

	self
		assert: (actualCollection includesAll: subcollection)
		description: [ actualCollection asString , ' does not include all in ' , subcollection asString ]
]

{ #category : 'asserting' }
HeraAssertionTrait >> assertCollection: actualCollection includesAny: subcollection [

	<debuggerCompleteToSender>

	self
		assert: (actualCollection includesAny: subcollection)
		description: [ actualCollection asString , ' does not include any of ' , subcollection asString ]
]

{ #category : 'asserting' }
HeraAssertionTrait >> assertEmpty: aCollection [

	<debuggerCompleteToSender>

	self
		assert: aCollection isEmpty
		description: [ aCollection asString , ' is not empty' ]
]
