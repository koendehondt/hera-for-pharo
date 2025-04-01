Class {
	#name : 'HeraAcceptanceTestExpectationTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraAcceptanceTestExpectationTestCase >> describedClass [

	^ HeraAcceptanceTest
]

{ #category : 'tests' }
HeraAcceptanceTestExpectationTestCase >> testAssert [

	subject expect: true.
	self should: [ subject expect: false ] raise: HeraFailure description: 'Assertion failed'
]

{ #category : 'tests' }
HeraAcceptanceTestExpectationTestCase >> testAssertCollectionToIncludeAny [

	subject expectCollection: #(1 2) toIncludeAny: #(3 1).
	self
		should: [ subject expectCollection: #(1 2) toIncludeAny: #(4 3) ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: '#(1 2) does not include any of #(4 3)' ]
]

{ #category : 'tests' }
HeraAcceptanceTestExpectationTestCase >> testExpectCollectionToEqual [

	subject expectCollection: #(1 2) toEqual: { 1 . 2 }.
	self
		should: [ subject expectCollection: #(1 2) toEqual: #(1) ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: 'Given Collections do not match. Got 
	left = #(1 2)
instead of
	right = #(1)
Collection size does not match: left=2 vs. right=1
Got 1 additional element(s) in the left collection: 	#(2)' ]
]

{ #category : 'tests' }
HeraAcceptanceTestExpectationTestCase >> testExpectCollectionToHaveSameElementsAs [

	subject expectCollection: #(1 2) toHaveSameElementsAs: #(2 1).
	self
		should: [ subject expectCollection: #(1 2) toHaveSameElementsAs: #(1 3) ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: 'Given Collections do not match!
	additions: #(2)
	missing: #(3)' ]
]

{ #category : 'tests' }
HeraAcceptanceTestExpectationTestCase >> testExpectCollectionToIncludeAll [

	subject expectCollection: #(1 2 3) toIncludeAll: #(2 1).
	self
		should: [ subject expectCollection: #(1 2) toIncludeAll: #(1 3) ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: '#(1 2) does not include all in #(1 3)' ]
]

{ #category : 'tests' }
HeraAcceptanceTestExpectationTestCase >> testExpectDescription [

	subject expect: true description: 'Failed'.
	self
		should: [ subject expect: false description: 'Failed' ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: 'Failed' ]
]

{ #category : 'tests' }
HeraAcceptanceTestExpectationTestCase >> testExpectToBe [

	subject expect: 5 toBe: 5.
	self
		should: [ subject expect: 'abc' toBe: #abc ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: '''abc'' is not identical to #abc.' ]
]

{ #category : 'tests' }
HeraAcceptanceTestExpectationTestCase >> testExpectToBeEmpty [

	subject expectToBeEmpty: #().
	self
		should: [ subject expectToBeEmpty: #(1) ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: '#(1) is not empty' ]
]

{ #category : 'tests' }
HeraAcceptanceTestExpectationTestCase >> testExpectToBeNil [

	subject expectToBeNil: nil.
	self
		should: [ subject expectToBeNil: 1 ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: '1 is not nil' ]
]

{ #category : 'tests' }
HeraAcceptanceTestExpectationTestCase >> testExpectToEqual [

	subject expect: 'abc' toEqual: 'abc'.
	self
		should: [ subject expect: 'abc' toEqual: 'xyz' ]
		raise: HeraFailure
		withExceptionDo: [ :failure | self assert: failure messageText equals: 'Got ''abc'' instead of ''xyz''.' ]
]
