Class {
	#name : 'HeraFeatureMethodItem',
	#superclass : 'HeraBrowserItem',
	#instVars : [
		'featureMethod'
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

	^ (other isMemberOf: self class) and: [ featureMethod = other featureMethod ]
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> acceptanceTest [

	^ featureMethod methodClass selector: featureMethod selector
]

{ #category : 'actions' }
HeraFeatureMethodItem >> browse [

	featureMethod browse
]

{ #category : 'private' }
HeraFeatureMethodItem >> feature [

	^ featureMethod methodClass new perform: featureMethod selector
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> featureMethod [

	^ featureMethod
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> featureMethod: aCompiledMethod [

	featureMethod := aCompiledMethod
]

{ #category : 'comparing' }
HeraFeatureMethodItem >> hash [

	^ featureMethod hash
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> nameInBrowser [

	^ (featureMethod pragmaAt: #heraFeature:) argumentAt: 1
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> removalConfirmationQuestion [

	^ 'Are you sure you want to remove the feature "{1}"?' format: { self nameInBrowser }
]

{ #category : 'actions' }
HeraFeatureMethodItem >> remove [

	featureMethod removeFromSystem
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> richScript [

	^ self feature richScript
]

{ #category : 'actions' }
HeraFeatureMethodItem >> saveSource: ast [

	| featureMethodSource  |
	featureMethodSource := HeraFeatureMethodGenerator new
		generatedSelector: featureMethod selector;
		visit: ast;
		generatedCode.
	featureMethod methodClass compile: featureMethodSource
]

{ #category : 'accessing' }
HeraFeatureMethodItem >> subitems [

	^ #()
]

{ #category : 'private' }
HeraFeatureMethodItem >> targetClassForNewFeature [

	^ featureMethod methodClass
]
