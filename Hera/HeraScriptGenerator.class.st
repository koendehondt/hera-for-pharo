Class {
	#name : 'HeraScriptGenerator',
	#superclass : 'HeraScriptElementVisitor',
	#instVars : [
		'stream',
		'indentation',
		'syntaxTheme'
	],
	#category : 'Hera-Generation',
	#package : 'Hera',
	#tag : 'Generation'
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
HeraScriptGenerator >> indentation: anInteger [

	indentation := anInteger
]

{ #category : 'initialization' }
HeraScriptGenerator >> initialize [

	super initialize.
	stream := TextStream on: (Text new: 1000).
	indentation := 0.
	syntaxTheme := Hera settings syntaxTheme
]

{ #category : 'streaming' }
HeraScriptGenerator >> nextPutDataTable: aDataTable [

	| columnWidths data |
	data := aDataTable data.
	data ifEmpty: [ ^ self ].
	columnWidths := Array new: data first size withAll: 0.
	data do: [ :eachRow |
		eachRow withIndexDo: [ :eachDatum :index |
			columnWidths at: index put: ((columnWidths at: index) max: eachDatum size) ] ].
	stream withAttribute: (TextColor color: syntaxTheme tableColor) do: [
		data withIndexDo: [ :eachRow :rowIndex |
			rowIndex > 1 ifTrue: [ stream cr ].
			stream
				tab: indentation;
				nextPut: $|.
			eachRow withIndexDo: [ :eachDatum :columnIndex |
				stream
					space;
					nextPutAll: (eachDatum padRightTo: (columnWidths at: columnIndex));
					space;
					nextPut: $| ] ] ]
]

{ #category : 'streaming' }
HeraScriptGenerator >> nextPutDataTree: aDataTree [

	| deepestLevel |
	deepestLevel := aDataTree deepestLevel.
	stream withAttribute: (TextColor color: syntaxTheme tableColor) do: [
		aDataTree data withIndexDo: [ :each :index |
			(each level = 1 and: [ index = 1]) ifFalse: [ stream cr ].
			stream
				tab: indentation;
				nextPutAll: ((String new: each level withAll: $>) padRightTo: deepestLevel with: Character space);
				space;
				nextPutAll: (String new: (each level - 1) * 2 withAll: Character space);
				nextPutAll: each text ] ]
]

{ #category : 'streaming' }
HeraScriptGenerator >> nextPutDocString: aDocString [

	stream withAttribute: (TextColor color: syntaxTheme docStringColor) do: [
		stream
			tab: indentation;
			nextPutAll: '"""'.
		aDocString lines do: [ :each | stream crtab: indentation; nextPutAll: each ].
		stream
			crtab: indentation;
			nextPutAll: '"""' ]
]

{ #category : 'streaming' }
HeraScriptGenerator >> nextPutKeyword: aString [

	stream
		withAttribute: (TextColor color: syntaxTheme keywordColor)
		do: [
			stream
				withAttribute: TextEmphasis bold
				do: [ stream nextPutAll: aString ] ]
]

{ #category : 'streaming' }
HeraScriptGenerator >> nextPutStepKeyword: aString [

	stream
		withAttribute: (TextColor color: syntaxTheme stepKeywordColor)
		do: [ stream nextPutAll: aString ]
]

{ #category : 'streaming' }
HeraScriptGenerator >> nextPutTag: aString [

	stream
		withAttribute: (TextColor color: syntaxTheme tagColor)
		do: [
			stream
				nextPut: $@;
				nextPutAll: aString ]
]

{ #category : 'streaming' }
HeraScriptGenerator >> nextPutTitle: aString [

	stream
		withAttribute: (TextColor color: syntaxTheme titleColor)
		do: [ stream nextPutAll: aString ]
]

{ #category : 'initialization' }
HeraScriptGenerator >> stream: aStream [

	stream := aStream
]

{ #category : 'initialization' }
HeraScriptGenerator >> syntaxTheme: aSyntaxTheme [

	syntaxTheme := aSyntaxTheme
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitAndStep: anAndStep [

	stream crtab: indentation.
	self nextPutStepKeyword: 'And'.
	stream space.
	stream nextPutAll: anAndStep description.
	anAndStep argument ifNotNil: [ :stepArgument |
		stream cr.
		self visit: anAndStep argument ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitBackground: aBackground [

	stream crtab: indentation.
	self nextPutKeyword: 'Background:'.
	self increaseIndentation.
	aBackground description ifNotEmpty: [ stream cr ].
	aBackground description do: [ :each |
		stream cr.
		each ifNotEmpty: [ stream tab: indentation ].
		stream nextPutAll: each ].
	aBackground description ifNotEmpty: [ stream cr ].
	aBackground steps do: [ :each | self visit: each ].
	self decreaseIndentation
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitButStep: aButStep [

	stream crtab: indentation.
	self nextPutStepKeyword: 'But'.
	stream space.
	stream nextPutAll: aButStep description.
	aButStep argument ifNotNil: [ :stepArgument |
		stream cr.
		self visit: aButStep argument ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitDataTableArgument: aDataTableArgument [

	self increaseIndentation.
	self nextPutDataTable: aDataTableArgument argumentValue.
	self decreaseIndentation.
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitDataTreeArgument: aDataTreeArgument [

	self increaseIndentation.
	self nextPutDataTree: aDataTreeArgument argumentValue.
	self decreaseIndentation.
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitDocStringArgument: aDocStringArgument [

	self increaseIndentation.
	self nextPutDocString: aDocStringArgument argumentValue.
	self decreaseIndentation.
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitFeature: aFeature [

	aFeature tags do: [ :each |
		self nextPutTag: each.
		stream cr ].
	self nextPutKeyword: 'Feature:'.
	stream space.
	self nextPutTitle: aFeature title.
	self increaseIndentation.
	aFeature description ifNotEmpty: [ stream cr ].
	aFeature description do: [ :each |
		stream cr.
		each ifNotEmpty: [ stream tab: indentation ].
		stream nextPutAll: each].
	aFeature description
		ifEmpty: [ (aFeature background isNotNil or: [ aFeature scenarios isNotEmpty]) ifTrue: [ stream cr ] ];
		ifNotEmpty: [ stream cr ].
	aFeature background ifNotNil: [ :background |
		self visit: background.
		aFeature scenarios ifNotEmpty: [ stream cr ] ].
	aFeature scenarios do: [ :each | self visit: each ] separatedBy: [ stream cr ].
	aFeature rules ifNotEmpty: [ stream cr ].
	aFeature rules do: [ :each | self visit: each ] separatedBy: [ stream cr ].
	self decreaseIndentation.
	stream cr; cr
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitGivenStep: aGivenStep [

	stream crtab: indentation.
	self nextPutStepKeyword: 'Given'.
	stream space.
	stream nextPutAll: aGivenStep description.
	aGivenStep argument ifNotNil: [ :stepArgument |
		stream cr.
		self visit: aGivenStep argument ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitRule: aRule [

	aRule tags do: [ :each |
		stream crtab: indentation.
		self nextPutTag: each ].
	stream crtab: indentation.
	self nextPutKeyword: 'Rule:'.
	stream space.
	self nextPutTitle: aRule title.
	self increaseIndentation.
	aRule description ifNotEmpty: [ stream cr ].
	aRule description do: [ :each |
		stream cr.
		each ifNotEmpty: [ stream tab: indentation ].
		stream nextPutAll: each].
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
		stream crtab: indentation.
		self nextPutTag: each ].
	stream crtab: indentation.
	self nextPutKeyword: 'Scenario:'.
	stream space.
	self nextPutTitle: aScenario title.
	self increaseIndentation.
	aScenario description ifNotEmpty: [ stream cr ].
	aScenario description do: [ :each |
		stream cr.
		each ifNotEmpty: [ stream tab: indentation ].
		stream nextPutAll: each ].
	aScenario description ifNotEmpty: [ stream cr ].
	aScenario steps do: [ :each | self visit: each ].
	self decreaseIndentation
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitScenarioOutline: aScenarioOutline [

	aScenarioOutline tags do: [ :each |
		stream crtab: indentation.
		self nextPutTag: each ].
	stream crtab: indentation.
	self nextPutKeyword: 'Scenario Outline:'.
	stream space.
	self nextPutTitle: aScenarioOutline title.
	self increaseIndentation.
	aScenarioOutline description ifNotEmpty: [ stream cr ].
	aScenarioOutline description do: [ :each |
		stream cr.
		each ifNotEmpty: [ stream tab: indentation ].
		stream nextPutAll: each ].
	aScenarioOutline description ifNotEmpty: [ stream cr ].
	aScenarioOutline steps do: [ :each | self visit: each ].
	 aScenarioOutline examples ifNotNil: [ :dataTable |
		stream cr; crtab: indentation.
		self nextPutKeyword: 'Examples:'.
		dataTable isEmpty ifFalse: [
			stream cr.
			self increaseIndentation.
			self nextPutDataTable: dataTable.
			self decreaseIndentation ] ].
	self decreaseIndentation
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitStarStep: aStarStep [

	stream crtab: indentation.
	self nextPutStepKeyword: '*'.
	stream space.
	stream nextPutAll: aStarStep description.
	aStarStep argument ifNotNil: [ :stepArgument |
		stream cr.
		self visit: aStarStep argument ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitThenStep: aThenStep [

	stream crtab: indentation.
	self nextPutStepKeyword: 'Then'.
	stream space.
	stream nextPutAll: aThenStep description.
	aThenStep argument ifNotNil: [ :stepArgument |
		stream cr.
		self visit: aThenStep argument ]
]

{ #category : 'visiting' }
HeraScriptGenerator >> visitWhenStep: aWhenStep [

	stream crtab: indentation.
	self nextPutStepKeyword: 'When'.
	stream space.
	stream nextPutAll: aWhenStep description.
	aWhenStep argument ifNotNil: [ :stepArgument |
		stream cr.
		self visit: aWhenStep argument ]
]
