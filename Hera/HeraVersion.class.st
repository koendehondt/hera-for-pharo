Class {
	#name : 'HeraVersion',
	#superclass : 'Object',
	#instVars : [
		'major',
		'minor',
		'patch'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HeraVersion class >> major: majorNumber minor: minorNumber patch: patchNumber [

	^ self new
		major: majorNumber;
		minor: minorNumber;
		patch: patchNumber
]

{ #category : 'comparing' }
HeraVersion >> = other [

	^ self major = other major and: [ self minor = other minor and: [ self patch = other patch ] ]
]

{ #category : 'accessing' }
HeraVersion >> major [

	^ major
]

{ #category : 'accessing' }
HeraVersion >> major: anInteger [

	major := anInteger
]

{ #category : 'accessing' }
HeraVersion >> minor [

	^ minor
]

{ #category : 'accessing' }
HeraVersion >> minor: anInteger [

	minor := anInteger
]

{ #category : 'accessing' }
HeraVersion >> patch [

	^ patch
]

{ #category : 'accessing' }
HeraVersion >> patch: anInteger [

	patch := anInteger
]

{ #category : 'printing' }
HeraVersion >> printOn: aStream [

	aStream
		nextPutAll: 'Hera';
		space;
		print: self major;
		nextPut: $.;
		print: self minor;
		nextPut: $.;
		print: self patch
]
