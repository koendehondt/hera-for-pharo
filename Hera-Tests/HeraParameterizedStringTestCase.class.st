Class {
	#name : 'HeraParameterizedStringTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Script elements',
	#package : 'Hera-Tests',
	#tag : 'Script elements'
}

{ #category : 'running' }
HeraParameterizedStringTestCase >> describedClass [

	^ HeraParameterizedString
]

{ #category : 'tests' }
HeraParameterizedStringTestCase >> testHasParameters [

	subject string: 'I buy 5 apples'.
	self deny: subject hasParameters.

	subject string: 'I buy 5 <fruit>'.
	self assert: subject hasParameters.

	subject string: 'I buy <number> <fruit>'.
	self assert: subject hasParameters.

	subject string: 'I buy <fruit> and <fruit>'.
	self assert: subject hasParameters
]

{ #category : 'tests' }
HeraParameterizedStringTestCase >> testParameters [

	subject string: 'I buy 5 apples'.
	self assert: subject parameters equals: Set new.

	subject string: 'I buy 5 <fruit>'.
	self assert: subject parameters equals: (Set with: 'fruit').

	subject string: 'I buy <number> <fruit>'.
	self assert: subject parameters equals: (Set with: 'number' with: 'fruit').

	subject string: 'I buy <fruit> and <fruit>'.
	self assert: subject parameters equals: (Set with: 'fruit')
]
