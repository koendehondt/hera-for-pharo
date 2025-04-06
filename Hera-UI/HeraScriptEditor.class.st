Class {
	#name : 'HeraScriptEditor',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'script',
		'submitBlock',
		'ast',
		'openStepBlock',
		'parser'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'private' }
HeraScriptEditor >> altKeyClick: event [

	| caretPosition astNode |
	ast ifNil: [ ^ self ].
	caretPosition := script selectionInterval first.
	astNode := HeraAstTextBasedSearchVisitor new
		textPosition: caretPosition;
		visit: ast.
	(astNode isNil or: [ astNode isStepNode not ]) ifTrue: [ ^ self ].
	openStepBlock value: astNode
]

{ #category : 'private' }
HeraScriptEditor >> astForScript: aString [

	^ self parser
		initializeParserWith: aString;
		parseFeature
]

{ #category : 'private' }
HeraScriptEditor >> buildAst: source [

	ast := self astForScript: source
]

{ #category : 'initialization' }
HeraScriptEditor >> connectPresenters [

	script whenSubmitDo: [ :source | self submit: source ].
	script eventHandler whenMouseUpDo: [ :event |
		event altKeyPressed ifTrue: [ self altKeyClick: event ] ]
]

{ #category : 'layout' }
HeraScriptEditor >> defaultLayout [

	^ SpBoxLayout newVertical
		add: script;
		yourself
]

{ #category : 'initialization' }
HeraScriptEditor >> initializePresenters [

	script := self newText
		addStyle: 'featureText';
		yourself
]

{ #category : 'private' }
HeraScriptEditor >> lintWarnings [

	^ HeraLinter new
		lint: ast;
		warnings
]

{ #category : 'initialization' }
HeraScriptEditor >> modelChanged [

	| text |
	self model ifNil: [
		self text: ''.
		^ self ].
	text := self model richScript.
	self
		text: text;
		selectionInterval: (text size + 1 to: text size + 1)
]

{ #category : 'private' }
HeraScriptEditor >> parser [

	^ parser ifNil: [ parser := HeraParser new ]
]

{ #category : 'api' }
HeraScriptEditor >> selectionInterval: anInterval [

	script selectionInterval: anInterval
]

{ #category : 'initialization' }
HeraScriptEditor >> setupAfterOpening [

	script withAdapterDo: [ :textAdapter |
		textAdapter widget
			withTextSegmentIcons;
			withLineNumbers ]
]

{ #category : 'private' }
HeraScriptEditor >> showParseError [

	| decorator error |
	error := parser parseError.
	decorator := SpTextPresenterDecorator new.
	"decorator highlightColor: Color red."
	decorator underlineColor: Color red.
	decorator title: error messageText.
	decorator icon: (self iconNamed: #halt).
	decorator iconBlock: [ :seg| seg ].
	decorator interval: (error start to: error end + 1).
	script
		removeAllTextSegmentDecorations;
		addTextSegmentDecoration: decorator
]

{ #category : 'private' }
HeraScriptEditor >> showWarnings [

	| decorator warnings |
	warnings := self lintWarnings.
	warnings ifEmpty: [ ^ self ].
	script removeAllTextSegmentDecorations.
	decorator := SpTextPresenterDecorator new.
	decorator underlineColor: Color orange.
	warnings do: [ :warning |
		decorator title: warning message.
		decorator icon: (self iconNamed: #warning).
		decorator iconBlock: [ :seg| seg ].
		decorator interval: (warning start to: warning end + 1).
		script addTextSegmentDecoration: decorator ]
]

{ #category : 'private' }
HeraScriptEditor >> submit: source [

	(self astForScript: source)
		ifNil: [ self showParseError ]
		ifNotNil: [ :featureAstNode |
			submitBlock value: featureAstNode.
			ast := featureAstNode.
			self showWarnings ]
]

{ #category : 'api' }
HeraScriptEditor >> text [

	^ script text
]

{ #category : 'api' }
HeraScriptEditor >> text: aText [

	script removeAllTextSegmentDecorations.
	script text: aText.
	aText ifEmpty: [ ^ self ].
	self buildAst: aText string.
	self showWarnings
]

{ #category : 'api' }
HeraScriptEditor >> whenOpenStepDo: aBlock [

	openStepBlock := aBlock
]

{ #category : 'api' }
HeraScriptEditor >> whenSubmitDo: aBlock [

	submitBlock := aBlock
]
