"
I define expectation methods. Use me if you prefer expectation syntax over assertion syntax.

The trait user has to implement #signalFailure:.
"
Trait {
	#name : 'THeraExpectationTrait',
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'expecting' }
THeraExpectationTrait >> expect: aBoolean [

	<debuggerCompleteToSender>

	self expect: aBoolean description: 'Expectation failed'
]

{ #category : 'expecting' }
THeraExpectationTrait >> expect: aBoolean description: aStringOrBlock [

	<debuggerCompleteToSender>

	aBoolean ifTrue: [ ^ self ].
	self signalFailure: aStringOrBlock value
]

{ #category : 'expecting' }
THeraExpectationTrait >> expect: actualObject toBe: expectedObject [

	<debuggerCompleteToSender>

	self
		expect: actualObject == expectedObject
		description: [ HeraAssertionMessageHelper new comparingIdentityStringBetween: actualObject and: expectedObject ]
]

{ #category : 'expecting' }
THeraExpectationTrait >> expect: actualObject toEqual: expectedObject [

	<debuggerCompleteToSender>

	self
		expect: actualObject = expectedObject
		description: [ HeraAssertionMessageHelper new comparingStringBetween: actualObject and: expectedObject ]
]

{ #category : 'expecting' }
THeraExpectationTrait >> expectCollection: actualCollection toEqual: expectedCollection [

	<debuggerCompleteToSender>

	self
		expect: actualCollection = expectedCollection
		description: [ HeraAssertionMessageHelper new comparingCollectionBetween: actualCollection and: expectedCollection ]
]

{ #category : 'expecting' }
THeraExpectationTrait >> expectCollection: actualCollection toHaveSameElementsAs: expectedCollection [

	<debuggerCompleteToSender>
	
	| additionalElements missingElements |
	actualCollection = expectedCollection ifTrue: [ ^ self ].
	actualCollection asBag = expectedCollection asBag ifTrue: [ ^ self ].

	additionalElements := actualCollection difference: expectedCollection.
	missingElements := expectedCollection difference: (actualCollection intersection: expectedCollection).
	self
		expect: (additionalElements isEmpty and: [ missingElements isEmpty ])
		description: [ HeraAssertionMessageHelper new comparingAdditional: additionalElements missing: missingElements ]
]

{ #category : 'expecting' }
THeraExpectationTrait >> expectCollection: actualCollection toIncludeAll: subcollection [

	<debuggerCompleteToSender>

	self
		expect: (actualCollection includesAll: subcollection)
		description: [ actualCollection asString , ' does not include all in ' , subcollection asString ]
]

{ #category : 'expecting' }
THeraExpectationTrait >> expectCollection: actualCollection toIncludeAny: subcollection [

	<debuggerCompleteToSender>

	self
		expect: (actualCollection includesAny: subcollection)
		description: [ actualCollection asString , ' does not include any of ' , subcollection asString ]
]

{ #category : 'expecting' }
THeraExpectationTrait >> expectToBeEmpty: aCollection [

	<debuggerCompleteToSender>

	self
		expect: aCollection isEmpty
		description: [ aCollection asString , ' is not empty' ]
]
