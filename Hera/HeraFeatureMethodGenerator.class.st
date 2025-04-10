Class {
	#name : 'HeraFeatureMethodGenerator',
	#superclass : 'HeraAstVisitor',
	#instVars : [
		'stream',
		'generatedSelector',
		'indentations'
	],
	#category : 'Hera-AST',
	#package : 'Hera',
	#tag : 'AST'
}

{ #category : 'private' }
HeraFeatureMethodGenerator >> allowedMethodSelectorCharacter: aCharacter [

	^ aCharacter isLetter or: [ aCharacter isDigit or: [ aCharacter = $_ ] ]
]

{ #category : 'private' }
HeraFeatureMethodGenerator >> currentIndentation [

	^ indentations last
	
]

{ #category : 'accessing' }
HeraFeatureMethodGenerator >> generatedCode [

	^ stream contents
]

{ #category : 'accessing' }
HeraFeatureMethodGenerator >> generatedSelector [

	^ generatedSelector
]

{ #category : 'accessing' }
HeraFeatureMethodGenerator >> generatedSelector: aSymbol [

	generatedSelector := aSymbol
]

{ #category : 'private' }
HeraFeatureMethodGenerator >> indent: anInteger while: aBlock [

	indentations add: anInteger.
	aBlock value.
	indentations removeLast
	
]

{ #category : 'initialization' }
HeraFeatureMethodGenerator >> initialize [

	super initialize.
	indentations := OrderedCollection with: 1.
	stream := (String new: 1000) writeStream
]

{ #category : 'accessing' }
HeraFeatureMethodGenerator >> suggestedFeatureMethodSelectorFor: featureTitleString [

	| camelCaseTitle |
	camelCaseTitle := featureTitleString asCamelCase select: [ :char | self allowedMethodSelectorCharacter: char ].
	^ ('feature{1}' format: { camelCaseTitle }) asSymbol
]

{ #category : 'initialization' }
HeraFeatureMethodGenerator >> useSuggestedFeatureMethodSelectorFor: featureTitleString [

	self generatedSelector: (self suggestedFeatureMethodSelectorFor: featureTitleString)
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitAndAstNode: aGivenAstNode [

	self visitStepAstNode: aGivenAstNode named: 'and'
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitBackgroundAstNode: aBackgroundAstNode [

	aBackgroundAstNode steps ifEmpty: [ ^ self ].
	stream crtab: 3.
	stream nextPutAll: 'background: (self background'.
	aBackgroundAstNode steps do: [ :each | self visit: each ] separatedBy: [ stream nextPut: $; ].
	stream nextPut: $)
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitButAstNode: aGivenAstNode [

	self visitStepAstNode: aGivenAstNode named: 'but'
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitDataTableStepArgumentAstNode: aDataTableStepArgumentAstNode [

	stream nextPutAll: ' with: (self dataTable: {'.
	aDataTableStepArgumentAstNode dataTable rows
		do: [ :eachRow |
			stream
				crtab: 5;
				nextPut: ${.
			eachRow
				do: [ :eachValue |
					stream
						space;
						nextPut: $';
						nextPutAll: eachValue;
						nextPut: $';
						space ]
				separatedBy: [ stream nextPut: $. ].
			stream nextPut: $}. ]
		separatedBy: [
			stream
				space;
				nextPut: $. ].
	stream nextPutAll: ' })'
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitDescriptionAstNode: aDescriptionAstNode [

	stream
		crtab: self currentIndentation;
		nextPutAll: 'description: {';
		crtab: self currentIndentation + 1.
	aDescriptionAstNode lines
		do: [ :each | stream nextPut: $'; nextPutAll: each; nextPut: $' ]
		separatedBy: [ stream space; nextPut: $.; crtab: self currentIndentation + 1 ].
	stream
		space;
		nextPut: $}
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitDocStringStepArgumentAstNode: aDocStringStepArgumentAstNode [

	stream nextPutAll: ' with: (self docString: {'.
	aDocStringStepArgumentAstNode docString lines
		do: [ :eachLine |
			stream
				crtab: 5;
				nextPut: $';
				nextPutAll: eachLine;
				nextPut: $' ]
		separatedBy: [ stream nextPutAll: ' .' ].
	stream nextPutAll: ' })'
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitFeatureAstNode: aFeatureAstNode [

	stream
		nextPutAll: self generatedSelector;
		cr;
		crtab;
		nextPutAll: '<heraFeature: ';
		print: aFeatureAstNode title text;
		nextPut: $>;
		cr.
	stream
		crtab;
		nextPutAll: '^ '.
	aFeatureAstNode isEmpty ifFalse: [ stream nextPut: $( ].
	stream
		nextPutAll: 'self feature: ';
		print: aFeatureAstNode title text.
	aFeatureAstNode isEmpty ifFalse: [ stream nextPut: $) ].
	aFeatureAstNode tags ifNotEmpty: [
			stream
				crtab: 2;
				nextPutAll: 'tags: {';
				crtab: 3.
			aFeatureAstNode tags
				do: [ :each | each accept: self ]
				separatedBy: [ stream space; nextPut: $.; crtab: 3 ].
			stream
				space;
				nextPut: $}.
			(aFeatureAstNode description isNotNil or: [ aFeatureAstNode background isNotNil or: [ aFeatureAstNode scenarios isNotEmpty ] ]) ifTrue: [ stream nextPut: $; ] ].
	aFeatureAstNode description ifNotNil: [ :description |
		self indent: 2 while: [ self visit: description ].
		(aFeatureAstNode background isNotNil or: [ aFeatureAstNode scenarios isNotEmpty]) ifTrue: [ stream nextPut: $; ] ].
	aFeatureAstNode background ifNotNil: [ :background |
		self visit: background.
		aFeatureAstNode scenarios ifNotEmpty: [ stream nextPut: $; ] ].
	aFeatureAstNode scenarios ifNotEmpty: [
		stream
			crtab: 2;
			nextPutAll: 'scenarios: ';
			nextPut: ${.
		aFeatureAstNode scenarios do: [ :each | self visit: each ] separatedBy: [ stream space; nextPut: $. ].
		stream
			space;
			nextPut: $} ]
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitGivenAstNode: aGivenAstNode [

	self visitStepAstNode: aGivenAstNode named: 'given'
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitScenarioAstNode: aScenarioAstNode [

	stream crtab: 3.
	aScenarioAstNode isEmpty ifFalse: [ stream nextPut: $( ].
	stream
		nextPutAll: 'self scenario: ';
		nextPut: $';
		nextPutAll: aScenarioAstNode title text;
		nextPut: $'.
	aScenarioAstNode isEmpty ifFalse: [ stream nextPut: $) ].
	aScenarioAstNode tags ifNotEmpty: [
		stream
			crtab: 4;
			nextPutAll: 'tags: {';
			crtab: 5.
		aScenarioAstNode tags
			do: [ :each | each accept: self ]
			separatedBy: [ stream space; nextPut: $.; crtab: 5 ].
		stream
			space;
			nextPut: $}.
		(aScenarioAstNode description isNotNil or: [ aScenarioAstNode steps isNotEmpty]) ifTrue: [ stream nextPut: $; ] ].
	aScenarioAstNode description ifNotNil: [ :description |
		self indent: 4 while: [ self visit: description ].
		aScenarioAstNode steps ifNotEmpty: [ stream nextPut: $; ] ].
	aScenarioAstNode steps do: [ :each | self visit: each ] separatedBy: [ stream nextPut: $; ]
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitStepAstNode: aStepAstNode named: aString [

	stream
		crtab: 4;
		nextPutAll: aString;
		nextPut: $:;
		space;
		nextPut: $';
		nextPutAll: aStepAstNode description;
		nextPut: $'.
	aStepAstNode argument ifNotNil: [ :argument | self visit: argument ]
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitTagAstNode: aTagAstNode [

	stream nextPut: $#; nextPutAll: aTagAstNode name
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitThenAstNode: aGivenAstNode [

	self visitStepAstNode: aGivenAstNode named: 'then'
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitWhenAstNode: aGivenAstNode [

	self visitStepAstNode: aGivenAstNode named: 'when'
]
