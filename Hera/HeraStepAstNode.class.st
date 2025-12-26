Class {
	#name : 'HeraStepAstNode',
	#superclass : 'HeraAstNode',
	#instVars : [
		'description',
		'argument'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'accessing' }
HeraStepAstNode >> argument [

	^ argument
]

{ #category : 'accessing' }
HeraStepAstNode >> argument: aDataTable [

	argument := aDataTable
]

{ #category : 'converting' }
HeraStepAstNode >> asStepDefinitionPragma [

	^ String streamContents: [ :stream |
		stream
			nextPutAll: '<heraStepDefinition: #(';
			nextPutAll: self typeForDefinition;
			space;
			print: self description;
			nextPutAll: ')>' ]
]

{ #category : 'accessing' }
HeraStepAstNode >> description [

	^ description
]

{ #category : 'accessing' }
HeraStepAstNode >> description: aString [

	description := aString
]

{ #category : 'testing' }
HeraStepAstNode >> hasArgument [

	^ self argument isNotNil
]

{ #category : 'testing' }
HeraStepAstNode >> isGivenStepNode [

	^ false
]

{ #category : 'testing' }
HeraStepAstNode >> isStepNode [

	^ true
]

{ #category : 'accessing' }
HeraStepAstNode >> methodSignatureFor: aStepMethodSelector [
	
	aStepMethodSelector numArgs = 0 ifTrue: [ ^ aStepMethodSelector asString ].
	^ Character space join: (self methodSignaturePartsFor: aStepMethodSelector)
]

{ #category : 'private' }
HeraStepAstNode >> methodSignaturePartsFor: aStepMethodSelector [
	
	| parts keywords |
	keywords := aStepMethodSelector keywords.
	keywords size = 1 ifTrue: [
		^ self hasArgument
			ifTrue: [ { keywords first . self argument stepMethodArgumentName } ]
			ifFalse: [ { keywords first . 'arg' } ]].
	(keywords size = 2 and: [ self hasArgument ])
		ifTrue: [ ^ { keywords first . 'arg' . keywords second . self argument stepMethodArgumentName } ].
	parts := OrderedCollection new.
	keywords doWithIndex: [ :each :index |
		parts add: each.
		parts add: ('arg{1}' format: { index }) ].
	self hasArgument ifTrue: [ parts at: parts size put: self argument stepMethodArgumentName ].
	^ parts
]

{ #category : 'accessing' }
HeraStepAstNode >> parameters [

	| params |
	params := (HeraParameterizedString new string: self description) parameters asSet.
	self argument ifNotNil: [ :arg | params addAll: arg parameters ].
	^ params
]

{ #category : 'accessing' }
HeraStepAstNode >> typeForDefinition [

	self subclassResponsibility
]
