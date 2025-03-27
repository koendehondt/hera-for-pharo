Class {
	#name : 'HeraScriptEditor',
	#superclass : 'SpPresenter',
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
	script eventHandler whenMouseDownDo: [ :event |
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
HeraScriptEditor >> parser [

	^ parser ifNil: [ parser := HeraGherkinParser new ]
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
	decorator iconBlock: [ :seg| seg].
	decorator interval: (error start to: error end + 1).
	script
		removeAllTextSegmentDecorations;
		addTextSegmentDecoration: decorator
]

{ #category : 'private' }
HeraScriptEditor >> submit: source [

	(self astForScript: source)
		ifNil: [ self showParseError ]
		ifNotNil: [ :featureAstNode | submitBlock value: featureAstNode ]
]

{ #category : 'api' }
HeraScriptEditor >> text [

	^ script text
]

{ #category : 'api' }
HeraScriptEditor >> text: aText [

	script text: aText.
	self buildAst: aText string
]

{ #category : 'api' }
HeraScriptEditor >> whenOpenStepDo: aBlock [

	openStepBlock := aBlock
]

{ #category : 'api' }
HeraScriptEditor >> whenSubmitDo: aBlock [

	submitBlock := aBlock
]
