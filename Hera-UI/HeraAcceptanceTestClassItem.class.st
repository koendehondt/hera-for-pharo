Class {
	#name : 'HeraAcceptanceTestClassItem',
	#superclass : 'HeraBrowserItem',
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'actions' }
HeraAcceptanceTestClassItem >> browse [

	acceptanceTestClass browse
]

{ #category : 'accessing' }
HeraAcceptanceTestClassItem >> nameInBrowser [

	^ acceptanceTestClass nameInBrowser
]

{ #category : 'accessing' }
HeraAcceptanceTestClassItem >> removalConfirmationQuestion [

	^ 'Are you sure you want to remove the class "{1}"?' format: { self nameInBrowser }
]

{ #category : 'actions' }
HeraAcceptanceTestClassItem >> remove [

	acceptanceTestClass removeFromSystem
]

{ #category : 'accessing' }
HeraAcceptanceTestClassItem >> richScript [

	^ ''
]

{ #category : 'accessing' }
HeraAcceptanceTestClassItem >> subitems [

	| items |
	items := acceptanceTestClass featureMethods collect: [ :each |
		HeraFeatureMethodItem new acceptanceTestClass: each methodClass; featureMethodSelector: each selector ].
	^ items sorted
]

{ #category : 'accessing' }
HeraAcceptanceTestClassItem >> targetClassForNewFeature [

	^ acceptanceTestClass
]
