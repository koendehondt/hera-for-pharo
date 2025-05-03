Class {
	#name : 'HeraAcceptanceTestClassItemTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-UI-Tests-Feature Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Feature Browser'
}

{ #category : 'running' }
HeraAcceptanceTestClassItemTestCase >> describedClass [

	^ HeraAcceptanceTestClassItem
]

{ #category : 'tests' }
HeraAcceptanceTestClassItemTestCase >> testHashIsHashOfAcceptanceTestClass [

	subject acceptanceTestClass: HeraAcceptanceTestWithPassForTesting.
	self assert: subject hash equals: HeraAcceptanceTestWithPassForTesting hash
]

{ #category : 'tests' }
HeraAcceptanceTestClassItemTestCase >> testIsEditable [

	self deny: subject isEditable
]

{ #category : 'tests' }
HeraAcceptanceTestClassItemTestCase >> testIsEqualToAcceptanceTestClassItemWithTheSameAcceptanceTestClass [

	| anotherAcceptanceTestClassItem |
	subject acceptanceTestClass: HeraAcceptanceTestWithPassForTesting.
	anotherAcceptanceTestClassItem := self describedClass new acceptanceTestClass: HeraAcceptanceTestWithPassForTesting.
	self assert: subject equals: anotherAcceptanceTestClassItem
]

{ #category : 'tests' }
HeraAcceptanceTestClassItemTestCase >> testIsNotEqualToAcceptanceTestClassItemWithAnotherAcceptanceTestClass [

	| anotherAcceptanceTestClassItem |
	subject acceptanceTestClass: HeraAcceptanceTestWithPassForTesting.
	anotherAcceptanceTestClassItem := self describedClass new acceptanceTestClass: HeraAcceptanceTestWithFailureForTesting.
	self deny: subject equals: anotherAcceptanceTestClassItem
]

{ #category : 'tests' }
HeraAcceptanceTestClassItemTestCase >> testIsNotEqualToInstanceOfOtherClass [

	self deny: subject equals: Object new
]

{ #category : 'tests' }
HeraAcceptanceTestClassItemTestCase >> testIsRunnable [

	self deny: subject isRunnable
]
