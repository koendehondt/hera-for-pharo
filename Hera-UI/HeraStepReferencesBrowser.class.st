Class {
	#name : 'HeraStepReferencesBrowser',
	#superclass : 'HeraPresenter',
	#instVars : [
		'scope',
		'featureList',
		'stepMethodItem',
		'scriptEditor'
	],
	#category : 'Hera-UI-Step References Browser',
	#package : 'Hera-UI',
	#tag : 'Step References Browser'
}

{ #category : 'accessing' }
HeraStepReferencesBrowser class >> windowIcon [

	^ Hera settings iconNamed: #references
]

{ #category : 'accessing' }
HeraStepReferencesBrowser >> browseReferencesTo: aStepMethodItem [

	| references |
	stepMethodItem := aStepMethodItem.
	references := HeraStepFinder new
		scope: scope;
		stepMethodItem: aStepMethodItem;
		findReferences.
	featureList items: references valuesAndCounts associations
]

{ #category : 'initialization' }
HeraStepReferencesBrowser >> connectPresenters [

	featureList whenSelectedItemChangedDo: [ :association |
		scriptEditor
			model: (association ifNotNil: [ association key ]);
			highlight: stepMethodItem fullStepDescription ].
	scriptEditor whenSubmitDo: [ :featureAstNode | self updateSelectedFeature: featureAstNode ].
]

{ #category : 'layout' }
HeraStepReferencesBrowser >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		add: featureList;
		add: scriptEditor;
		yourself
]

{ #category : 'initialization' }
HeraStepReferencesBrowser >> initializePresenters [

	featureList := self newList
		display: [ :association | '{1} ({2})' format: { association key nameInBrowser . association value } ];
		yourself.
	scriptEditor := self instantiate: HeraScriptEditor
]

{ #category : 'initialization' }
HeraStepReferencesBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenOpenedDo: [ self updateWindowTitle ]
]

{ #category : 'accessing' }
HeraStepReferencesBrowser >> scope: aScope [

	scope := aScope
]

{ #category : 'private' }
HeraStepReferencesBrowser >> selectedMethodItem [

	^ featureList selectedItem
]

{ #category : 'updating' }
HeraStepReferencesBrowser >> updateSelectedFeature: aFeatureAstNode [

	self selectedMethodItem saveSource: aFeatureAstNode
]

{ #category : 'updating' }
HeraStepReferencesBrowser >> updateWindowTitle [

	self withWindowDo: [ :window | | title |
		title := 'References to "{1}"' format: { stepMethodItem fullStepDescription }.
		window title: title ]
]

{ #category : 'accessing' }
HeraStepReferencesBrowser >> windowIcon [

	^ self class windowIcon
]
