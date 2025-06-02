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
HeraSettingsTestCase >> testIcons [

	self assert: ((subject iconNamed: #heraRunner) isKindOf: Form)
]
