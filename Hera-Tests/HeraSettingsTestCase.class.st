Class {
	#name : 'HeraSettingsTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraSettingsTestCase >> describedClass [

	^ HeraSettings
]

{ #category : 'running' }
HeraSettingsTestCase >> initializeSubject [

	subject := self describedClass uniqueInstance
]

{ #category : 'tests' }
HeraSettingsTestCase >> testClassInitialization [

	| oldUniqueInstance newUniqueInstance |
	oldUniqueInstance := self describedClass uniqueInstance. 
	self describedClass initialize.
	newUniqueInstance := self describedClass uniqueInstance.
	self assert: (newUniqueInstance isMemberOf: self describedClass).
	self deny: newUniqueInstance equals: oldUniqueInstance
]

{ #category : 'tests' }
HeraSettingsTestCase >> testIcons [

	self assert: ((subject iconNamed: #crown) isKindOf: Form).
	self assert: ((subject iconNamed: #checkedCircle) isKindOf: Form).
	self assert: ((subject iconNamed: #book) isKindOf: Form)
]
