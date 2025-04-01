Class {
	#name : 'HeraAcceptanceTestAssertionTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraAcceptanceTestAssertionTestCase >> describedClass [

	^ HeraAcceptanceTest
]

{ #category : 'tests' }
HeraAcceptanceTestAssertionTestCase >> testAssert [

	subject assert: true.
	self should: [ subject assert: false ] raise: HeraFailure description: 'Assertion failed'
]

{ #category : 'tests' }
HeraAcceptanceTestAssertionTestCase >> testAssertCollectionEquals [

	subject assertCollection: #(1 2) equals: { 1 . 2 }.
	self
		should: [ subject assertCollection: #(1 2) equals: #(1) ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: 'Given Collections do not match. Got 
	left = #(1 2)
instead of
	right = #(1)
Collection size does not match: left=2 vs. right=1
Got 1 additional element(s) in the left collection: 	#(2)' ]
]

{ #category : 'tests' }
HeraAcceptanceTestAssertionTestCase >> testAssertCollectionHasSameElements [

	subject assertCollection: #(1 2) hasSameElements: #(2 1).
	self
		should: [ subject assertCollection: #(1 2) hasSameElements: #(1 3) ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: 'Given Collections do not match!
	additions: #(2)
	missing: #(3)' ]
]

{ #category : 'tests' }
HeraAcceptanceTestAssertionTestCase >> testAssertCollectionIncludesAll [

	subject assertCollection: #(1 2 3) includesAll: #(2 1).
	self
		should: [ subject assertCollection: #(1 2) includesAll: #(1 3) ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: '#(1 2) does not include all in #(1 3)' ]
]

{ #category : 'tests' }
HeraAcceptanceTestAssertionTestCase >> testAssertCollectionIncludesAny [

	subject assertCollection: #(1 2) includesAny: #(3 1).
	self
		should: [ subject assertCollection: #(1 2) includesAny: #(4 3) ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: '#(1 2) does not include any of #(4 3)' ]
]

{ #category : 'tests' }
HeraAcceptanceTestAssertionTestCase >> testAssertDescription [

	subject assert: true description: 'Failed'.	
	self
		should: [ subject assert: false description: 'Failed' ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: 'Failed' ]
]

{ #category : 'tests' }
HeraAcceptanceTestAssertionTestCase >> testAssertEmpty [

	subject assertEmpty: #().
	self
		should: [ subject assertEmpty: #(1) ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: '#(1) is not empty' ]
]

{ #category : 'tests' }
HeraAcceptanceTestAssertionTestCase >> testAssertEquals [

	subject assert: 'abc' equals: 'abc'.
	self
		should: [ subject assert: 'abc' equals: 'xyz' ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: 'Got ''abc'' instead of ''xyz''.' ]
]

{ #category : 'tests' }
HeraAcceptanceTestAssertionTestCase >> testAssertIdenticalTo [

	subject assert: 5 identicalTo: 5.
	self
		should: [ subject assert: 'abc' identicalTo: #abc ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: '''abc'' is not identical to #abc.' ]
]

{ #category : 'tests' }
HeraAcceptanceTestAssertionTestCase >> testAssertNil [

	subject assertNil: nil.
	self
		should: [ subject assertNil: 1 ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: '1 is not nil' ]
]
