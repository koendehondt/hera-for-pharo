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
HeraFeatureMethodItemTestCase >> testHashIsHashOfCompiledMethod [

	| compiledMethod |
	compiledMethod := HeraAcceptanceTestWithPassForTesting>>#signingInFeature.
	subject featureMethod: compiledMethod.
	self assert: subject hash equals: compiledMethod hash
]

{ #category : 'tests' }
HeraFeatureMethodItemTestCase >> testIsEqualToMethodItemWithTheSameCompiledMethod [

	| anotherMethodItem |
	subject featureMethod: HeraAcceptanceTestWithPassForTesting>>#signingInFeature.
	anotherMethodItem := self describedClass new featureMethod: HeraAcceptanceTestWithPassForTesting>>#signingInFeature.
	self assert: subject equals: anotherMethodItem
]

{ #category : 'tests' }
HeraFeatureMethodItemTestCase >> testIsNotEqualToInstanceOfOtherClass [

	self deny: subject equals: Object new
]

{ #category : 'tests' }
HeraFeatureMethodItemTestCase >> testIsNotEqualToMethodItemWithAnotherCompiledMethod [

	| anotherMethodItem |
	subject featureMethod: HeraAcceptanceTestWithPassForTesting>>#signingInFeature.
	anotherMethodItem := self describedClass new featureMethod: HeraAcceptanceTestWithFailureForTesting>>#signingInFeature.
	self deny: subject equals: anotherMethodItem
]
