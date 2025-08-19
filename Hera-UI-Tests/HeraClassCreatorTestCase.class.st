Class {
	#name : 'HeraClassCreatorTestCase',
	#superclass : 'HeraUnitTestCase',
	#instVars : [
		'createdClass'
	],
	#category : 'Hera-UI-Tests-Feature Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Feature Browser'
}

{ #category : 'running' }
HeraClassCreatorTestCase >> describedClass [

	^ HeraClassCreator
]

{ #category : 'running' }
HeraClassCreatorTestCase >> tearDown [

	createdClass ifNotNil: [ createdClass removeFromSystem ].
	super tearDown
]

{ #category : 'tests' }
HeraClassCreatorTestCase >> testCreateClass [

	| package tag |
	package := Smalltalk packages detect: [ :each | each name = 'Hera-Tests'].
	tag := package tags detect: [ :each | each name = 'Core'].
	subject
		targetClassName: 'NewAcceptanceTestClass';
		targetSuperclass: HeraWebAcceptanceTest;
		targetPackage: package;
		targetTag: tag.
	createdClass := subject createClass.
	self assert: createdClass name equals: #NewAcceptanceTestClass.
	self assert: createdClass superclass equals: HeraWebAcceptanceTest.
	self assert: createdClass package equals: package.
	self assert: createdClass packageTag equals: tag
]
