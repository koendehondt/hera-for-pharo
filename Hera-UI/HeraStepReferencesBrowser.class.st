Class {
	#name : 'HeraStepReferencesBrowser',
	#superclass : 'HeraPresenter',
	#instVars : [
		'featureList',
		'scriptEditor',
		'stepFinder'
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
HeraStepReferencesBrowser >> browseReferences [

	featureList items: stepFinder references valuesAndCounts associations
]

{ #category : 'initialization' }
HeraStepReferencesBrowser >> connectPresenters [

	featureList whenSelectedItemChangedDo: [ :association |
		scriptEditor
			model: (association ifNotNil: [ association key ]);
			highlight: stepFinder stepMethodItem ].
	scriptEditor whenSubmitDo: [ :featureAstNode | self updateSelectedFeature: featureAstNode ].
]

{ #category : 'layout' }
HeraStepReferencesBrowser >> defaultLayout [

	^ SpPanedLayout newLeftToRight
		positionOfSlider: 33 percent;
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

{ #category : 'private' }
HeraStepReferencesBrowser >> selectedMethodItem [

	^ featureList selectedItem
]

{ #category : 'accessing' }
HeraStepReferencesBrowser >> stepFinder: aStepFinder [

	stepFinder := aStepFinder
]

{ #category : 'updating' }
HeraStepReferencesBrowser >> updateSelectedFeature: aFeatureAstNode [

	self selectedMethodItem saveSource: aFeatureAstNode
]

{ #category : 'updating' }
HeraStepReferencesBrowser >> updateWindowTitle [

	self withWindowDo: [ :window | | title |
		title := 'References to "{1}"' format: { stepFinder stepMethodItem fullStepDescription }.
		window title: title ]
]

{ #category : 'accessing' }
HeraStepReferencesBrowser >> windowIcon [

	^ self class windowIcon
]
