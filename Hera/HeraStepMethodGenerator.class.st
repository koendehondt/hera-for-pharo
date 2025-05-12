Class {
	#name : 'HeraStepMethodGenerator',
	#superclass : 'Object',
	#instVars : [
		'stream',
		'source',
		'description',
		'type',
		'acceptanceTestClass',
		'pattern'
	],
	#category : 'Hera-Generation',
	#package : 'Hera',
	#tag : 'Generation'
}

{ #category : 'accessing' }
HeraStepMethodGenerator >> acceptanceTestClass: anAcceptanceTestClass [

	acceptanceTestClass := anAcceptanceTestClass
]

{ #category : 'private' }
HeraStepMethodGenerator >> definitionPragma [

	^ String streamContents: [ :pragmaStream |
		pragmaStream
			nextPutAll: '<heraStepDefinition: #(';
			nextPutAll: type;
			space.
		pattern ifNotNil: [ :matchOrRegex |
			pragmaStream
				nextPutAll: matchOrRegex;
				space ].
		pragmaStream
			print: description;
			nextPutAll: ')>' ]
]

{ #category : 'accessing' }
HeraStepMethodGenerator >> description: aString [

	description := aString
]

{ #category : 'private' }
HeraStepMethodGenerator >> generate [

	| methodAstNode bodyStart |
	methodAstNode := Smalltalk compiler
		source: source;
		class: acceptanceTestClass;
		parse.
	bodyStart := methodAstNode body start.
	methodAstNode statements
		ifEmpty: [
			stream
				nextPutAll: source;
				cr;
				crtab;
				nextPutAll: self definitionPragma]
		ifNotEmpty: [
			stream
				nextPutAll: (source copyFrom: 1 to: bodyStart - 1);
				nextPutAll: self definitionPragma;
				cr;
				crtab;
				nextPutAll: (source copyFrom: bodyStart to: source size) ]
]

{ #category : 'accessing' }
HeraStepMethodGenerator >> generatedCode [

	self generate.
	^ stream contents
]

{ #category : 'initialization' }
HeraStepMethodGenerator >> initialize [

	super initialize.
	stream := (String new: 1000) writeStream
]

{ #category : 'accessing' }
HeraStepMethodGenerator >> pattern: aString [

	pattern := aString
]

{ #category : 'accessing' }
HeraStepMethodGenerator >> source: aString [

	source := aString
]

{ #category : 'accessing' }
HeraStepMethodGenerator >> type: aString [

	type := aString
]
