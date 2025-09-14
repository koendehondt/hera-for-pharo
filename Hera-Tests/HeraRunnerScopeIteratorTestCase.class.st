Class {
	#name : 'HeraRunnerScopeIteratorTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraRunnerScopeIteratorTestCase >> describedClass [

	^ HeraRunnerScopeIterator
]

{ #category : 'tests' }
HeraRunnerScopeIteratorTestCase >> testHasNext [

	subject scope: (HeraRunnerScope new
		addAcceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingOutFeature);
		addAcceptanceTest: (HeraAcceptanceTestWithFailureForTesting selector: #signingInFeature)).
	self assert: subject hasNext.
	subject next.
	self assert: subject hasNext.
	subject next.
	self deny: subject hasNext
]

{ #category : 'tests' }
HeraRunnerScopeIteratorTestCase >> testHasNextAnswersFalseWhenScopeIsEmpty [

	subject scope: HeraRunnerScope new.
	self deny: subject hasNext
]

{ #category : 'tests' }
HeraRunnerScopeIteratorTestCase >> testNext [

	subject scope: (HeraRunnerScope new
		addAcceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingOutFeature);
		addAcceptanceTest: (HeraAcceptanceTestWithFailureForTesting selector: #signingInFeature)).
	self assert: subject next equals: (HeraAcceptanceTestWithPassForTesting selector: #signingOutFeature).
	self assert: subject next equals: ((HeraAcceptanceTestWithFailureForTesting selector: #signingInFeature)).
	self assert: subject next isNil
]

{ #category : 'tests' }
HeraRunnerScopeIteratorTestCase >> testNextAnswersNilWhenScopeIsEmpty [

	subject scope: HeraRunnerScope new.
	self assert: subject next isNil
]

{ #category : 'tests' }
HeraRunnerScopeIteratorTestCase >> testNextDoWhenScopeHasOneClass [

	| handledAcceptanceTest |
	subject scope: (HeraAcceptanceTestWithPassForTesting selector: #signingOutFeature) asRunnerScope.
	handledAcceptanceTest := nil.
	subject nextDo: [ :acceptanceTestClass | handledAcceptanceTest := acceptanceTestClass ].
	self assert: handledAcceptanceTest equals: (HeraAcceptanceTestWithPassForTesting selector: #signingOutFeature)
]

{ #category : 'tests' }
HeraRunnerScopeIteratorTestCase >> testNextDoWhenScopeHasTwoClasses [

	| handledAcceptanceTests |
	subject scope: (HeraRunnerScope new
		addAcceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingOutFeature);
		addAcceptanceTest: (HeraAcceptanceTestWithFailureForTesting selector: #signingInFeature)).
	handledAcceptanceTests := Set new.
	subject nextDo: [ :acceptanceTest | handledAcceptanceTests add: acceptanceTest ].
	subject nextDo: [ :acceptanceTest | handledAcceptanceTests add: acceptanceTest ].
	self assert: handledAcceptanceTests equals: (Set with: (HeraAcceptanceTestWithPassForTesting selector: #signingOutFeature) with: (HeraAcceptanceTestWithFailureForTesting selector: #signingInFeature))
]

{ #category : 'tests' }
HeraRunnerScopeIteratorTestCase >> testNextDoWhenScopeIsEmpty [

	| noAcceptanceTestHandled |
	subject scope: HeraRunnerScope new.
	noAcceptanceTestHandled := true.
	subject nextDo: [ :acceptanceTestClass | noAcceptanceTestHandled := false ].
	self assert: noAcceptanceTestHandled
]
