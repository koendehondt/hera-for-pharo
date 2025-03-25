Class {
	#name : 'HeraScriptGenerator',
	#superclass : 'HeraScriptElementVisitor',
	#instVars : [
		'stream'
	],
	#category : 'Hera-Script generation',
	#package : 'Hera',
	#tag : 'Script generation'
}

{ #category : 'accessing' }
HeraScriptGenerator >> generatedScript [

	^ stream contents
]

{ #category : 'initialization' }
HeraScriptGenerator >> initialize [

	super initialize.
	stream := TextStream on: (Text new: 1000).
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
		crtab: 2;
		nextPutAll: 'And ';
		nextPutAll: anAndStep description
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitBackground: aBackground [

	stream crtab.
	self nextPutKeyword: 'Background:'.
	aBackground steps do: [ :each | self visit: each ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitButStep: anButStep [

	stream
		crtab: 2;
		nextPutAll: 'But ';
		nextPutAll: anButStep description
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitDataTableArgument: aDataTableArgument [

	aDataTableArgument printFormattedOn: stream indentation: 3
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitDocStringArgument: aDocStringArgument [

	aDocStringArgument printFormattedOn: stream indentation: 3
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
	aFeature description do: [ :each |
		stream
			crtab;
			nextPutAll: each].
	aFeature description
		ifEmpty: [ (aFeature background isNotNil or: [ aFeature scenarios isNotEmpty]) ifTrue: [ stream cr ] ];
		ifNotEmpty: [ stream cr ].
	aFeature background ifNotNil: [ :background |
		self visit: background.
		aFeature scenarios ifNotEmpty: [ stream cr ] ].
	aFeature scenarios do: [ :each | self visit: each ] separatedBy: [ stream cr ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitGivenStep: aGivenStep [

	stream
		crtab: 2;
		nextPutAll: 'Given ';
		nextPutAll: aGivenStep description.
	aGivenStep argument ifNotNil: [ :stepArgument |
		stream cr.
		self visit: aGivenStep argument ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitScenario: aScenario [

	aScenario tags do: [ :each |
		stream
			crtab;
			nextPut: $@;
			nextPutAll: each].
	stream crtab.
	self nextPutKeyword: 'Scenario:'.
	stream
		space;
		nextPutAll: aScenario title.
	aScenario description do: [ :each |
		stream
			crtab: 2;
			nextPutAll: each].
	aScenario description ifNotEmpty: [ stream cr ].
	aScenario steps do: [ :each | self visit: each ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitThenStep: aThenStep [

	stream
		crtab: 2;
		nextPutAll: 'Then ';
		nextPutAll: aThenStep description.
	aThenStep argument ifNotNil: [ :stepArgument |
		stream cr.
		self visit: aThenStep argument ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitWhenStep: aWhenStep [

	stream
		crtab: 2;
		nextPutAll: 'When ';
		nextPutAll: aWhenStep description.
	aWhenStep argument ifNotNil: [ :stepArgument |
		stream cr.
		self visit: aWhenStep argument ]
]
