Class {
	#name : 'HeraAcceptanceTestClassItem',
	#superclass : 'HeraBrowserItem',
	#instVars : [
		'acceptanceTestClass'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'comparing' }
HeraAcceptanceTestClassItem >> = other [

	^ (other isMemberOf: self class) and: [ acceptanceTestClass = other acceptanceTestClass ]
]

{ #category : 'accessing' }
HeraAcceptanceTestClassItem >> acceptanceTestClass [

	^ acceptanceTestClass
]

{ #category : 'accessing' }
HeraAcceptanceTestClassItem >> acceptanceTestClass: aClass [

	acceptanceTestClass := aClass
]

{ #category : 'actions' }
HeraAcceptanceTestClassItem >> browse [

	acceptanceTestClass browse
]

{ #category : 'comparing' }
HeraAcceptanceTestClassItem >> hash [

	^ acceptanceTestClass hash
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
		HeraFeatureMethodItem new featureMethod: each ].
	^ items sorted
]

{ #category : 'accessing' }
HeraAcceptanceTestClassItem >> targetClassForNewFeature [

	^ acceptanceTestClass
]
