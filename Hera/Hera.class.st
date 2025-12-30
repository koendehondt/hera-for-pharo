Class {
	#name : 'Hera',
	#superclass : 'Object',
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'accessing' }
Hera class >> about [

	^ Text streamContents: [ :stream |
		stream
			withAttribute: TextEmphasis bold do: [ stream print: self version ];
			cr; cr;
			nextPutAll: self aboutText ]
]

{ #category : 'accessing' }
Hera class >> aboutText [

	^ 'Hera is a Behaviour Driven Development framework for Pharo. It allows for a better communication of acceptance criteria between technical and non-technical people. The Hera browser allows writing Given-When-Then scenarios in Gherkin and translating them to classes and methods.'
]

{ #category : 'browsing' }
Hera class >> browseReferencesTo: aStepMethod inScope: scope [

	| stepMethodItem stepFinder |
	stepMethodItem := aStepMethod.
	stepFinder := HeraStepFinder new
		scope: scope;
		stepMethodItem: stepMethodItem;
		findReferences;
		yourself.
	stepFinder hasReferences
		ifTrue: [
			HeraStepReferencesBrowser new
				stepFinder: stepFinder;
				browseReferences;
				open ]
		ifFalse: [ 
			self inform: ('There are no references to "{1}".' format: { stepMethodItem fullStepDescription }) ]
]

{ #category : 'accessing' }
Hera class >> settings [

	^ HeraSettings uniqueInstance
]

{ #category : 'accessing' }
Hera class >> version [
	"From https://semver.org/
		Given a version number MAJOR.MINOR.PATCH, increment the:
			MAJOR version when you make incompatible API changes
			MINOR version when you add functionality in a backward compatible manner
			PATCH version when you make backward compatible bug fixes"

	^ HeraVersion new
		major: 1;
		minor: 1;
		patch: 0
]
