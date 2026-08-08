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
HeraTestCase >> testConvertTextToMethodBodyNamed [

	| text |
	text := Text fromString: '@featureTag
Feature: Feature title

	Scenario: Scenario title'.
	text makeBoldFrom: 13 to: 20.
	text makeColor: Color red from: 13 to: 20.
	text makeBoldFrom: 38 to: 46.
	text makeColor: Color blue from: 38 to: 46.
	self
		assert: (self describedClass convertTextToRepresentation: text)
		equals: '(Text fromString: ''@featureTag
Feature: Feature title

	Scenario: Scenario title'')
	makeBoldFrom: 13 to: 20;
	makeColor: (Color fromHexString: ''FF0000'') from: 13 to: 20;
	makeBoldFrom: 38 to: 46;
	makeColor: (Color fromHexString: ''0000FF'') from: 38 to: 46;
	yourself'
]

{ #category : 'tests' }
HeraTestCase >> testSettings [

	self assert: self describedClass settings identicalTo: HeraSettings uniqueInstance
]

{ #category : 'tests' }
HeraTestCase >> testVersion [

	self assert: self describedClass version equals: (HeraVersion major: 1 minor: 1 patch: 0)
]
