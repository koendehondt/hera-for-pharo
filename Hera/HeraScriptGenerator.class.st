Class {
	#name : 'HeraScriptGenerator',
	#superclass : 'HeraScriptElementVisitor',
	#instVars : [
		'stream',
		'indentation'
	],
	#category : 'Hera-Script generation',
	#package : 'Hera',
	#tag : 'Script generation'
}

{ #category : 'private' }
HeraScriptGenerator >> decreaseIndentation [

	indentation := indentation - 1
]

{ #category : 'accessing' }
HeraScriptGenerator >> generatedScript [

	^ stream contents
]

{ #category : 'private' }
HeraScriptGenerator >> increaseIndentation [

	indentation := indentation + 1
]

{ #category : 'initialization' }
HeraScriptGenerator >> initialize [

	super initialize.
	stream := TextStream on: (Text new: 1000).
	indentation := 0
]

{ #category : 'private' }
HeraScriptGenerator >> nextPutKeyword: aString [

	stream
		withAttribute: TextEmphasis bold
		do: [ stream nextPutAll: aString ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitAndStep: anAndStep [

	stream
		crtab: indentation;
		nextPutAll: 'And ';
		nextPutAll: anAndStep description
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitBackground: aBackground [

	stream crtab: indentation.
	self nextPutKeyword: 'Background:'.
	self increaseIndentation.
	aBackground steps do: [ :each | self visit: each ].
	self decreaseIndentation
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitButStep: anButStep [

	stream
		crtab: indentation;
		nextPutAll: 'But ';
		nextPutAll: anButStep description
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitDataTableArgument: aDataTableArgument [

	aDataTableArgument printFormattedOn: stream indentation: indentation + 1
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitDocStringArgument: aDocStringArgument [

	aDocStringArgument printFormattedOn: stream indentation: indentation + 1
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitFeature: aFeature [

	aFeature tags do: [ :each |
		stream
			nextPut: $@;
			nextPutAll: each;
			cr ].
	self nextPutKeyword: 'Feature:'.
	stream
		space;
		nextPutAll: aFeature name.
	self increaseIndentation.
	aFeature description do: [ :each |
		stream
			crtab: indentation;
			nextPutAll: each].
	aFeature description
		ifEmpty: [ (aFeature background isNotNil or: [ aFeature scenarios isNotEmpty]) ifTrue: [ stream cr ] ];
		ifNotEmpty: [ stream cr ].
	aFeature background ifNotNil: [ :background |
		self visit: background.
		aFeature scenarios ifNotEmpty: [ stream cr ] ].
	aFeature scenarios do: [ :each | self visit: each ] separatedBy: [ stream cr ].
	aFeature rules ifNotEmpty: [ stream cr ].
	aFeature rules do: [ :each | self visitRule: each ] separatedBy: [ stream cr ].
	self decreaseIndentation
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitGivenStep: aGivenStep [

	stream
		crtab: indentation;
		nextPutAll: 'Given ';
		nextPutAll: aGivenStep description.
	aGivenStep argument ifNotNil: [ :stepArgument |
		stream cr.
		self visit: aGivenStep argument ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitRule: aRule [

	stream crtab: indentation.
	self nextPutKeyword: 'Rule:'.
	stream
		space;
		nextPutAll: aRule title.
	self increaseIndentation.
	aRule description do: [ :each |
		stream
			crtab: indentation;
			nextPutAll: each].
	aRule description
		ifEmpty: [ (aRule background isNotNil or: [ aRule scenarios isNotEmpty]) ifTrue: [ stream cr ] ];
		ifNotEmpty: [ stream cr ].
	aRule background ifNotNil: [ :background |
		self visit: background.
		aRule scenarios ifNotEmpty: [ stream cr ] ].
	aRule scenarios do: [ :each | self visit: each ] separatedBy: [ stream cr ].
	self decreaseIndentation

]

{ #category : 'visiting' }
HeraScriptGenerator >> visitScenario: aScenario [

	aScenario tags do: [ :each |
		stream
			crtab: indentation;
			nextPut: $@;
			nextPutAll: each].
	stream crtab: indentation.
	self nextPutKeyword: 'Scenario:'.
	stream
		space;
		nextPutAll: aScenario title.
	self increaseIndentation.
	aScenario description do: [ :each |
		stream
			crtab: 2;
			nextPutAll: each].
	aScenario description ifNotEmpty: [ stream cr ].
	aScenario steps do: [ :each | self visit: each ].
	self decreaseIndentation
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitThenStep: aThenStep [

	stream
		crtab: indentation;
		nextPutAll: 'Then ';
		nextPutAll: aThenStep description.
	aThenStep argument ifNotNil: [ :stepArgument |
		stream cr.
		self visit: aThenStep argument ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitWhenStep: aWhenStep [

	stream
		crtab: indentation;
		nextPutAll: 'When ';
		nextPutAll: aWhenStep description.
	aWhenStep argument ifNotNil: [ :stepArgument |
		stream cr.
		self visit: aWhenStep argument ]
]
