Class {
	#name : 'HeraFeatureMethodItemTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-UI-Tests-Feature Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Feature Browser'
}

{ #category : 'running' }
HeraFeatureMethodItemTestCase >> describedClass [

	^ HeraFeatureMethodItem
]

{ #category : 'tests' }
HeraFeatureMethodItemTestCase >> testHashIsHashOfSelector [

	subject
		acceptanceTestClass: HeraAcceptanceTestWithPassForTesting;
		featureMethodSelector: #signingInFeature.
	self assert: subject hash equals: #signingInFeature hash
]

{ #category : 'tests' }
HeraFeatureMethodItemTestCase >> testIsEqualToMethodItemWithTheSameAcceptanceTestClassAndFeatureMethodSelector [

	| anotherMethodItem |
	subject
		acceptanceTestClass: HeraAcceptanceTestWithPassForTesting;
		featureMethodSelector: #signingInFeature.
	anotherMethodItem := self describedClass new
		acceptanceTestClass: HeraAcceptanceTestWithPassForTesting;
		featureMethodSelector: #signingInFeature.
	self assert: subject equals: anotherMethodItem
]

{ #category : 'tests' }
HeraFeatureMethodItemTestCase >> testIsNotEqualToInstanceOfOtherClass [

	self deny: subject equals: Object new
]

{ #category : 'tests' }
HeraFeatureMethodItemTestCase >> testIsNotEqualToMethodItemWithAnotherAcceptanceTestClassOrFeatureMethodSelector [

	| anotherMethodItem |
	subject
		acceptanceTestClass: HeraAcceptanceTestWithPassForTesting;
		featureMethodSelector: #signingInFeature.
	anotherMethodItem := self describedClass new
		acceptanceTestClass: HeraAcceptanceTestWithFailureForTesting;
		featureMethodSelector: #signingInFeature.
	self deny: subject equals: anotherMethodItem.
	anotherMethodItem := self describedClass new
		acceptanceTestClass: HeraAcceptanceTestWithPassForTesting;
		featureMethodSelector: #signingOutFeature.
	self deny: subject equals: anotherMethodItem
]

{ #category : 'tests' }
HeraFeatureMethodItemTestCase >> testIsRunnable [

	self assert: subject isRunnable
]
