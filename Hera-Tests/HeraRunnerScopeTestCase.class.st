Class {
	#name : 'HeraRunnerScopeTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraRunnerScopeTestCase >> describedClass [

	^ HeraRunnerScope
]

{ #category : 'tests' }
HeraRunnerScopeTestCase >> testAddAcceptanceTest [

	subject addAcceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingOut).
	self assert: subject acceptanceTests equals: { HeraAcceptanceTestWithPassForTesting selector: #signingOut }.
	subject addAcceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingIn).
	self assert: subject acceptanceTests equals: {
		HeraAcceptanceTestWithPassForTesting selector: #signingOut .
		HeraAcceptanceTestWithPassForTesting selector: #signingIn }
]

{ #category : 'tests' }
HeraRunnerScopeTestCase >> testIteratorIsImmutable [

	| iterator |
	iterator :=	subject iterator.
	self deny: iterator hasNext.
	subject addAcceptanceTest: (HeraAcceptanceTestWithPassForTesting selector: #signingIn).
	self deny: iterator hasNext.
	iterator :=	subject iterator.
	self assert: iterator next equals: (HeraAcceptanceTestWithPassForTesting selector: #signingIn)
]

{ #category : 'tests' }
HeraRunnerScopeTestCase >> testWithInstanceCreation [

	| instance |
	instance := self describedClass with: (HeraAcceptanceTestWithPassForTesting selector: #signingOut).
	self assert: instance acceptanceTests equals: { HeraAcceptanceTestWithPassForTesting selector: #signingOut }
]
