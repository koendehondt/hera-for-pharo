Class {
	#name : 'HeraFeatureMethodGenerator',
	#superclass : 'HeraAstVisitor',
	#instVars : [
		'stream',
		'generatedSelector',
		'indentation'
	],
	#category : 'Hera-Generation',
	#package : 'Hera',
	#tag : 'Generation'
}

{ #category : 'private' }
HeraFeatureMethodGenerator >> allowedMethodSelectorCharacter: aCharacter [

	^ aCharacter isLetter or: [ aCharacter isDigit or: [ aCharacter = $_ ] ]
]

{ #category : 'private' }
HeraFeatureMethodGenerator >> decreaseIndentation [

	indentation := indentation - 1
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
HeraFeatureMethodGenerator >> increaseIndentation [

	indentation := indentation + 1
]

{ #category : 'initialization' }
HeraFeatureMethodGenerator >> initialize [

	super initialize.
	stream := (String new: 1000) writeStream.
	indentation := 0
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

	stream crtab: indentation.
	stream nextPutAll: 'background: '.
	aBackgroundAstNode steps ifNotEmpty: [stream nextPut: $( ].
	stream nextPutAll: 'self background'.
	aBackgroundAstNode steps
		do: [ :each |
			self increaseIndentation.
			self visit: each.
			self decreaseIndentation ]
		separatedBy: [ stream nextPut: $; ].
	aBackgroundAstNode steps ifNotEmpty: [stream nextPut: $) ]
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitButAstNode: aGivenAstNode [

	self visitStepAstNode: aGivenAstNode named: 'but'
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitDataTableStepArgumentAstNode: aDataTableStepArgumentAstNode [

	stream nextPutAll: ' with: (self dataTable: {'.
	self increaseIndentation.
	aDataTableStepArgumentAstNode dataTable rows
		do: [ :eachRow |
			stream
				crtab: indentation;
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
	stream nextPutAll: ' })'.
	self decreaseIndentation
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitDescriptionAstNode: aDescriptionAstNode [

	stream
		crtab: indentation;
		nextPutAll: 'description: {'.
	self increaseIndentation.
	stream
		crtab: indentation.
	aDescriptionAstNode lines
		do: [ :each | stream nextPut: $'; nextPutAll: each; nextPut: $' ]
		separatedBy: [ stream space; nextPut: $.; crtab: indentation ].
	stream
		space;
		nextPut: $}.
	self decreaseIndentation
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitDocStringStepArgumentAstNode: aDocStringStepArgumentAstNode [

	stream nextPutAll: ' with: (self docString: {'.
	self increaseIndentation.
	aDocStringStepArgumentAstNode docString lines
		do: [ :eachLine |
			stream
				crtab: indentation;
				nextPut: $';
				nextPutAll: eachLine;
				nextPut: $' ]
		separatedBy: [ stream nextPutAll: ' .' ].
	stream nextPutAll: ' })'.
	self decreaseIndentation.
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitFeatureAstNode: aFeatureAstNode [

	stream
		nextPutAll: self generatedSelector;
		cr.
	self increaseIndentation.
	stream
		crtab: indentation;
		nextPutAll: '<heraFeature: ';
		print: aFeatureAstNode title text;
		nextPut: $>;
		cr.
	stream
		crtab: indentation;
		nextPutAll: '^ '.
	aFeatureAstNode isEmpty ifFalse: [ stream nextPut: $( ].
	stream
		nextPutAll: 'self feature: ';
		print: aFeatureAstNode title text.
	aFeatureAstNode isEmpty ifFalse: [ stream nextPut: $) ].
	aFeatureAstNode tags ifNotEmpty: [
	self increaseIndentation.
		stream
			crtab: indentation;
			nextPutAll: 'tags: {'.
		self increaseIndentation.
		stream
			crtab: indentation.
		aFeatureAstNode tags
			do: [ :each | each accept: self ]
			separatedBy: [ stream space; nextPut: $.; crtab: indentation ].
		stream
			space;
			nextPut: $}.
		self decreaseIndentation.
		(aFeatureAstNode description isNotNil or: [ aFeatureAstNode background isNotNil or: [ aFeatureAstNode scenarios isNotEmpty ] ]) ifTrue: [ stream nextPut: $; ].
		self decreaseIndentation ].
	aFeatureAstNode description ifNotNil: [ :description |
		self increaseIndentation.
		self visit: description.
		(aFeatureAstNode background isNotNil or: [ aFeatureAstNode scenarios isNotEmpty]) ifTrue: [ stream nextPut: $; ].
		self decreaseIndentation ].
	aFeatureAstNode background ifNotNil: [ :background |
		self increaseIndentation.
		self visit: background.
		aFeatureAstNode scenarios ifNotEmpty: [ stream nextPut: $; ].
		self decreaseIndentation ].
	aFeatureAstNode scenarios ifNotEmpty: [
		self increaseIndentation.
		stream
			crtab: indentation;
			nextPutAll: 'scenarios: ';
			nextPut: ${.
		aFeatureAstNode scenarios
			do: [ :each |
				self increaseIndentation.
				self visit: each.
				self decreaseIndentation. ]
			separatedBy: [ stream space; nextPut: $. ].
		stream
			space;
			nextPut: $}.
			aFeatureAstNode rules ifNotEmpty: [ stream nextPut: $; ].
		self decreaseIndentation ].
	aFeatureAstNode rules ifNotEmpty: [
		self increaseIndentation.
		stream
			crtab: indentation;
			nextPutAll: 'rules: ';
			nextPut: ${.
		aFeatureAstNode rules
			do: [ :each |
				self increaseIndentation.
				self visit: each.
				self decreaseIndentation ]
			separatedBy: [ stream space; nextPut: $. ].
		stream
			space;
			nextPut: $}.
		self decreaseIndentation ].
	self decreaseIndentation
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitGivenAstNode: aGivenAstNode [

	self visitStepAstNode: aGivenAstNode named: 'given'
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitRuleAstNode: aRuleAstNode [

	stream crtab: indentation.
	aRuleAstNode isEmpty ifFalse: [ stream nextPut: $( ].
	stream
		nextPutAll: 'self rule: ';
		print: aRuleAstNode title text.
	aRuleAstNode isEmpty ifFalse: [ stream nextPut: $) ].
	self increaseIndentation.
	aRuleAstNode description ifNotNil: [ :description |
		self visit: description .
		(aRuleAstNode background isNotNil or: [ aRuleAstNode scenarios isNotEmpty]) ifTrue: [ stream nextPut: $; ] ].
	aRuleAstNode background ifNotNil: [ :background |
		self visit: background.
		aRuleAstNode scenarios ifNotEmpty: [ stream nextPut: $; ] ].
	aRuleAstNode scenarios ifNotEmpty: [
		stream
			crtab: indentation;
			nextPutAll: 'scenarios: ';
			nextPut: ${.
		aRuleAstNode scenarios
			do: [ :each |
				self increaseIndentation.
				self visit: each.
				self decreaseIndentation ]
			separatedBy: [ stream space; nextPut: $. ].
		stream
			space;
			nextPut: $} ].
	self decreaseIndentation
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitScenarioAstNode: aScenarioAstNode [

	stream crtab: indentation.
	aScenarioAstNode isEmpty ifFalse: [ stream nextPut: $( ].
	stream
		nextPutAll: 'self scenario: ';
		nextPut: $';
		nextPutAll: aScenarioAstNode title text;
		nextPut: $'.
	aScenarioAstNode isEmpty ifFalse: [ stream nextPut: $) ].
	aScenarioAstNode tags ifNotEmpty: [
		self increaseIndentation.
		stream
			crtab: indentation;
			nextPutAll: 'tags: {'.
		self increaseIndentation.
		stream crtab: indentation.
		aScenarioAstNode tags
			do: [ :each | each accept: self ]
			separatedBy: [ stream space; nextPut: $.; crtab: indentation ].
		stream
			space;
			nextPut: $}.
		self decreaseIndentation.
		(aScenarioAstNode description isNotNil or: [ aScenarioAstNode steps isNotEmpty]) ifTrue: [ stream nextPut: $; ].
		self decreaseIndentation ].
	aScenarioAstNode description ifNotNil: [ :description |
		self increaseIndentation.
		self visit: description .
		aScenarioAstNode steps ifNotEmpty: [ stream nextPut: $; ].
		self decreaseIndentation ].
	aScenarioAstNode steps
		do: [ :each |
			self increaseIndentation.
			self visit: each.
			self decreaseIndentation ]
		separatedBy: [ stream nextPut: $; ]
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitStarAstNode: aStarAstNode [

	self visitStepAstNode: aStarAstNode named: 'star'
]

{ #category : 'visiting' }
HeraFeatureMethodGenerator >> visitStepAstNode: aStepAstNode named: aString [

	stream
		crtab: indentation;
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
