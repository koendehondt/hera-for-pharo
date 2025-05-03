Class {
	#name : 'HeraFeatureBrowser',
	#superclass : 'SpPresenter',
	#instVars : [
		'scriptEditor',
		'stepEditor',
		'scope',
		'featureSelector'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'accessing' }
HeraFeatureBrowser class >> defaultPreferredExtent [

	^ 800@400
]

{ #category : 'private' }
HeraFeatureBrowser >> addStepDefinitionMethodFor: aStepAstNode [

	| methodSelector message invalidMessage |
	methodSelector := self suggestedStepMethodSelectorFor: aStepAstNode.
	invalidMessage := ''.
	[ message := 'The step "{1}" has no definition yet. If you want to create it, please enter a method selector.{2}' format: { aStepAstNode description . invalidMessage }.
		[ methodSelector := self request: message initialAnswer: methodSelector title: 'Missing step definition' ]
		on: SpCancelledInteractionError
		do: [ ^ self ].
		invalidMessage := ' That is not a valid method selector. Only letters, digits, and underscores are allowed.'.
		self allowedMethodSelector: methodSelector ] whileFalse.
	featureSelector selectedItem addStepDefinitionMethodFor: aStepAstNode as: methodSelector
]

{ #category : 'private' }
HeraFeatureBrowser >> allowedMethodSelector: methodSelector [

	^ methodSelector allSatisfy: [ :char | self allowedMethodSelectorCharacter: char ]
]

{ #category : 'private' }
HeraFeatureBrowser >> allowedMethodSelectorCharacter: aCharacter [

	^ aCharacter isLetter or: [ aCharacter isDigit or: [ aCharacter = $_ ] ]
]

{ #category : 'initialization' }
HeraFeatureBrowser >> connectPresenters [

	featureSelector whenFeatureSelectionChangedDo: [ :featureMethodItem |
		scriptEditor model: featureMethodItem ].
	scriptEditor whenSubmitDo: [ :featureAstNode | self updateSelectedFeature: featureAstNode ].
	scriptEditor whenOpenStepDo: [ :stepAstNode | self updateStepEditor: stepAstNode ]
]

{ #category : 'layout' }
HeraFeatureBrowser >> defaultLayout [

	| leftPanes |
	leftPanes := SpPanedLayout newLeftToRight
		add: featureSelector;
		add: scriptEditor;
		yourself.
	^ SpPanedLayout newLeftToRight
		positionOfSlider: 66 percent;
		add: leftPanes;
		add: stepEditor;
		yourself
]

{ #category : 'test api' }
HeraFeatureBrowser >> displayedTreeItems [

	^ featureSelector displayedTreeItems
]

{ #category : 'private' }
HeraFeatureBrowser >> featureSelectionChanged [

	scriptEditor model: self selectedMethodItem
]

{ #category : 'test api' }
HeraFeatureBrowser >> hasNoFeatures [

	^ featureSelector hasNoFeatures
]

{ #category : 'private' }
HeraFeatureBrowser >> heraApplication [

	^ HeraApplication new
		addStyleSheetFromString: '.application [
			.total [ Draw { #backgroundColor: #white} ],
			.passed [ Draw { #backgroundColor: #green } ],
			.failed [ Draw { #backgroundColor: #yellow } ],
			.error [ Draw { #backgroundColor: #red } ],
			.runButton [ Geometry { #hResizing: false }, Container { #borderColor: #transparent, #borderWidth: 1 } ],
			.activeButton [ Container { #borderColor: #darkGray } ],
			.featureText [ Font { #name: EnvironmentFont(#code) } ]
		]';
		yourself
]

{ #category : 'initialization' }
HeraFeatureBrowser >> initialize [

	super initialize.
	self application: self heraApplication
]

{ #category : 'initialization' }
HeraFeatureBrowser >> initializePresenters [

	featureSelector := self instantiate: HeraFeatureSelector.
	scriptEditor := self instantiate: HeraScriptEditor.
	stepEditor := self instantiate: HeraStepEditor
]

{ #category : 'initialization' }
HeraFeatureBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenOpenedDo: [
		featureSelector setupAfterOpening.
		scriptEditor setupAfterOpening ]
]

{ #category : 'private' }
HeraFeatureBrowser >> methodFor: aStepAstNode [

	^ self selectedMethodItem acceptanceTest methodForStepDescription: aStepAstNode description
]

{ #category : 'accessing' }
HeraFeatureBrowser >> scope [

	^ scope ifNil: [ scope := HeraScope default ]
]

{ #category : 'accessing' }
HeraFeatureBrowser >> scope: aScope [

	scope := aScope.
	featureSelector scope: aScope
]

{ #category : 'test api' }
HeraFeatureBrowser >> script [

	^ scriptEditor text
]

{ #category : 'test api' }
HeraFeatureBrowser >> selectPath: anArray [

	featureSelector selectPath: anArray
]

{ #category : 'private' }
HeraFeatureBrowser >> selectedMethodItem [

	^ featureSelector selectedItem
]

{ #category : 'private' }
HeraFeatureBrowser >> suggestedStepMethodSelectorFor: aStepAstNode [

	| colonOrNothing suggestion |
	self flag: 'Take step arguments into account'.
	colonOrNothing := aStepAstNode argument ifNil: [ '' ] ifNotNil: [ ':' ].
	suggestion := aStepAstNode description asCamelCase select: [ :char | self allowedMethodSelectorCharacter: char ].
	^ 'step{1}{2}' format: { suggestion . colonOrNothing }
]

{ #category : 'private' }
HeraFeatureBrowser >> updateSelectedFeature: aFeatureAstNode [

	self selectedMethodItem saveSource: aFeatureAstNode.
	self featureSelectionChanged
]

{ #category : 'private' }
HeraFeatureBrowser >> updateStepEditor: aStepAstNode [

	(self methodFor: aStepAstNode)
		ifNil: [ self addStepDefinitionMethodFor: aStepAstNode ]
		ifNotNil: [ :stepMethod |
			stepEditor model: (HeraStepMethodItem new stepMethod: stepMethod) ]
]

{ #category : 'accessing' }
HeraFeatureBrowser >> windowTitle [

	^ 'Hera Feature Browser'
]
