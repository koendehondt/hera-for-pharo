Class {
	#name : 'HeraScriptEditor',
	#superclass : 'SpPresenter',
	#instVars : [
		'script',
		'submitBlock',
		'ast',
		'openStepBlock'
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
	astNode ifNil: [ ^ self ].
	openStepBlock value: astNode
]

{ #category : 'private' }
HeraScriptEditor >> astForSource: aString [

	^ HeraGherkinParser new
		initializeParserWith: aString;
		parseFeature
]

{ #category : 'private' }
HeraScriptEditor >> buildAst: source [

	ast := self astForSource: source
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

{ #category : 'api' }
HeraScriptEditor >> selectionInterval: anInterval [

	script selectionInterval: anInterval
]

{ #category : 'private' }
HeraScriptEditor >> submit: source [

	submitBlock value: source.
	self buildAst: source
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
