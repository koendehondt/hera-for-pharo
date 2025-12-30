Class {
	#name : 'HeraFeatureResultItemTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Runner',
	#package : 'Hera-UI-Tests',
	#tag : 'Runner'
}

{ #category : 'running' }
HeraFeatureResultItemTestCase >> describedClass [

	^ HeraFeatureResultItem
]

{ #category : 'tests' }
HeraFeatureResultItemTestCase >> testDescription [

	subject feature: (HeraFeature new title: 'User management').
	self assert: subject description equals: 'User management'
]

{ #category : 'tests' }
HeraFeatureResultItemTestCase >> testDescriptionlabel [

	subject feature: (HeraFeature new title: 'User management').
	self assert: subject descriptionLabel equals: 'User management' asText allBold
]

{ #category : 'tests' }
HeraFeatureResultItemTestCase >> testLevel [

	self assert: subject level equals: 2
]

{ #category : 'tests' }
HeraFeatureResultItemTestCase >> testStatus [

	self assert: subject status isNil
]
