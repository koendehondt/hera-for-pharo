Class {
	#name : 'HeraFeatureMethodItem',
	#superclass : 'HeraBrowserItem',
	#instVars : [
		'featureMethodSelector'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'comparing' }
HeraFeatureMethodItem >> <= other [

	^ self nameInBrowser <= other nameInBrowser
]

{ #category : 'comparing' }
HeraFeatureMethodItem >> = other [

	^ super = other and: [ featureMethodSelector = other featureMethodSelector ]
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> acceptanceTest [

	^ acceptanceTestClass selector: featureMethodSelector
]

{ #category : 'actions' }
HeraFeatureMethodItem >> browse [

	self featureMethod browse
]

{ #category : 'private' }
HeraFeatureMethodItem >> feature [

	^ acceptanceTestClass new perform: featureMethodSelector
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> featureMethod [

	^ acceptanceTestClass >> featureMethodSelector
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> featureMethodSelector [

	^ featureMethodSelector
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> featureMethodSelector: aMethodSelector [

	featureMethodSelector := aMethodSelector
]

{ #category : 'comparing' }
HeraFeatureMethodItem >> hash [

	^ featureMethodSelector hash
]

{ #category : 'testing' }
HeraFeatureMethodItem >> isRunnable [

	^ true
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> nameInBrowser [

	^ (self featureMethod pragmaAt: #heraFeature:) argumentAt: 1
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> removalConfirmationQuestion [

	^ 'Are you sure you want to remove the feature "{1}"?' format: { self nameInBrowser }
]

{ #category : 'actions' }
HeraFeatureMethodItem >> remove [

	self featureMethod removeFromSystem
]

{ #category : 'actions' }
HeraFeatureMethodItem >> removeFromScope: aScope [

	"Do nothing."
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> richScript [

	^ self feature richScript
]

{ #category : 'actions' }
HeraFeatureMethodItem >> saveSource: ast [

	| featureMethodSource |
	featureMethodSource := HeraFeatureMethodGenerator new
		generatedSelector: featureMethodSelector;
		visit: ast;
		generatedCode.
	featureMethodSelector := acceptanceTestClass compile: featureMethodSource
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> subitems [

	^ #()
]

{ #category : 'private' }
HeraFeatureMethodItem >> targetClassForNewFeature [

	^ acceptanceTestClass
]
