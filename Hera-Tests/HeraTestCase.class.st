Class {
	#name : 'HeraTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraTestCase >> describedClass [

	^ Hera
]

{ #category : 'tests' }
HeraTestCase >> testAbout [

	| expectedAbout |
	expectedAbout := Text fromString: 'Hera 1.1.0

Hera is a Behaviour Driven Development framework for Pharo. It allows for a better communication of acceptance criteria between technical and non-technical people. The Hera browser allows writing Given-When-Then scenarios in Gherkin and translating them to classes and methods.'.
	expectedAbout addAttribute: TextEmphasis bold from: 1 to: 10.
	self assertText: self describedClass about equals: expectedAbout
]

{ #category : 'tests' }
HeraTestCase >> testSettings [

	self assert: self describedClass settings identicalTo: HeraSettings uniqueInstance
]

{ #category : 'tests' }
HeraTestCase >> testVersion [

	self assert: self describedClass version equals: (HeraVersion major: 1 minor: 1 patch: 0)
]
