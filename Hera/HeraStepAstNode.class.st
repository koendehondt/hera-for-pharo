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

{ #category : 'accessing' }
HeraStepAstNode >> typeForDefinition [

	self subclassResponsibility
]
