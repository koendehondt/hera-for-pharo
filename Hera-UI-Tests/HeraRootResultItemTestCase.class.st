Class {
	#name : 'HeraRootResultItemTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Runner',
	#package : 'Hera-UI-Tests',
	#tag : 'Runner'
}

{ #category : 'running' }
HeraRootResultItemTestCase >> describedClass [

	^ HeraRootResultItem
]

{ #category : 'tests' }
HeraRootResultItemTestCase >> testDescription [

	subject featureCount: 1.
	self assert: subject description equals: '1 feature'.

	subject featureCount: 2.
	self assert: subject description equals: '2 features'
]

{ #category : 'tests' }
HeraRootResultItemTestCase >> testDescriptionlabel [

	subject featureCount: 1.
	self assert: subject descriptionLabel equals: '1 feature'
]

{ #category : 'tests' }
HeraRootResultItemTestCase >> testLevel [

	self assert: subject level equals: 1
]

{ #category : 'tests' }
HeraRootResultItemTestCase >> testStatus [

	self assert: subject status isNil
]
