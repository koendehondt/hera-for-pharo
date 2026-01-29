Class {
	#name : 'HeraSpecAcceptanceTestTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraSpecAcceptanceTestTestCase >> describedClass [

	^ HeraSpecAcceptanceTest
]

{ #category : 'helpers' }
HeraSpecAcceptanceTestTestCase >> newFamilyTreeOn: aPerson [

	^ HeraExampleFamilyTreePresenter new
		focusPerson: aPerson
]

{ #category : 'helpers' }
HeraSpecAcceptanceTestTestCase >> newFamilyTreeOnJohn [

	^ self newFamilyTreeOn: (HeraExamplePerson new name: 'John')
]

{ #category : 'running' }
HeraSpecAcceptanceTestTestCase >> tearDown [

	subject closeWindows.
	super tearDown
]

{ #category : 'tests - helpers' }
HeraSpecAcceptanceTestTestCase >> testCheckboxInteraction [

	subject openPresenter: self newFamilyTreeOnJohn.
	subject select: 'John' inTree: 'Family'.
	self assert: (subject isUnchecked: 'Disabled').
	subject check: 'Disabled'.
	self assert: (subject isChecked: 'Disabled').
	subject uncheck: 'Disabled'.
	self assert: (subject isUnchecked: 'Disabled')
]

{ #category : 'tests - helpers' }
HeraSpecAcceptanceTestTestCase >> testClickCheckbox [

	subject openPresenter: self newFamilyTreeOnJohn.
	subject select: 'John' inTree: 'Family'.
	self assert: (subject isUnchecked: 'Disabled').
	subject click: 'Disabled'.
	self assert: (subject isChecked: 'Disabled').
	subject click: 'Disabled'.
	self assert: (subject isUnchecked: 'Disabled')
]

{ #category : 'tests - helpers' }
HeraSpecAcceptanceTestTestCase >> testPresenterAt [

	| familyTreeApp |
	familyTreeApp := self newFamilyTreeOnJohn.
	subject openPresenter: familyTreeApp.
	subject select: 'John' inTree: 'Family'.
	self assert: ((subject presenterAt: 'Disabled') isMemberOf: SpCheckBoxPresenter)
]
