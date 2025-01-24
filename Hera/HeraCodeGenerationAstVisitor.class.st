Class {
	#name : 'HeraCodeGenerationAstVisitor',
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
HeraCodeGenerationAstVisitor >> currentIndentation [

	^ indentations last
	
]

{ #category : 'accessing' }
HeraCodeGenerationAstVisitor >> generatedCode [

	^ stream contents
]

{ #category : 'accessing' }
HeraCodeGenerationAstVisitor >> generatedSelector [

	^ generatedSelector
]

{ #category : 'accessing' }
HeraCodeGenerationAstVisitor >> generatedSelector: aSymbol [

	generatedSelector := aSymbol
]

{ #category : 'private' }
HeraCodeGenerationAstVisitor >> indent: anInteger while: aBlock [

	indentations add: anInteger.
	aBlock value.
	indentations removeLast
	
]

{ #category : 'initialization' }
HeraCodeGenerationAstVisitor >> initialize [

	super initialize.
	indentations := OrderedCollection with: 1.
	stream := (String new: 1000) writeStream.
	generatedSelector := ('feature{1}' format: { HeraAnalytics new nextAvailableFeatureNumber }) asSymbol
]

{ #category : 'visiting' }
HeraCodeGenerationAstVisitor >> visitAndAstNode: aGivenAstNode [

	self visitStepAstNode: aGivenAstNode named: 'and'
]

{ #category : 'visiting' }
HeraCodeGenerationAstVisitor >> visitBackgroundAstNode: aBackgroundAstNode [

	aBackgroundAstNode steps ifEmpty: [ ^ self ].
	stream crtab: 3.
	stream nextPutAll: 'background: (self background'.
	aBackgroundAstNode steps do: [ :each | self visit: each ] separatedBy: [ stream nextPut: $; ].
	stream nextPut: $)
]

{ #category : 'visiting' }
HeraCodeGenerationAstVisitor >> visitButAstNode: aGivenAstNode [

	self visitStepAstNode: aGivenAstNode named: 'but'
]

{ #category : 'visiting' }
HeraCodeGenerationAstVisitor >> visitDataTableStepArgumentAstNode: aDataTableStepArgumentAstNode [

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
HeraCodeGenerationAstVisitor >> visitDescriptionAstNode: aDescriptionAstNode [

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
HeraCodeGenerationAstVisitor >> visitDocStringStepArgumentAstNode: aDocStringStepArgumentAstNode [

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
HeraCodeGenerationAstVisitor >> visitFeatureAstNode: aFeatureAstNode [

	stream
		nextPutAll: self generatedSelector;
		cr;
		crtab;
		nextPutAll: '<heraFeature: ';
		print: aFeatureAstNode name;
		nextPut: $>;
		cr.
	stream
		crtab;
		nextPutAll: '^ '.
	aFeatureAstNode isEmpty ifFalse: [ stream nextPut: $( ].
	stream
		nextPutAll: 'self feature: ';
		nextPut: $';
		nextPutAll: aFeatureAstNode name;
		nextPut: $'.
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
HeraCodeGenerationAstVisitor >> visitGivenAstNode: aGivenAstNode [

	self visitStepAstNode: aGivenAstNode named: 'given'
]

{ #category : 'visiting' }
HeraCodeGenerationAstVisitor >> visitScenarioAstNode: aScenarioAstNode [

	stream crtab: 3.
	aScenarioAstNode isEmpty ifFalse: [ stream nextPut: $( ].
	stream
		nextPutAll: 'self scenario: ';
		nextPut: $';
		nextPutAll: aScenarioAstNode title;
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
HeraCodeGenerationAstVisitor >> visitStepAstNode: aStepAstNode named: aString [

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
HeraCodeGenerationAstVisitor >> visitTagAstNode: aTagAstNode [

	stream nextPut: $#; nextPutAll: aTagAstNode name
]

{ #category : 'visiting' }
HeraCodeGenerationAstVisitor >> visitThenAstNode: aGivenAstNode [

	self visitStepAstNode: aGivenAstNode named: 'then'
]

{ #category : 'visiting' }
HeraCodeGenerationAstVisitor >> visitWhenAstNode: aGivenAstNode [

	self visitStepAstNode: aGivenAstNode named: 'when'
]
