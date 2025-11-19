Class {
	#name : 'HeraFeatureExporter',
	#superclass : 'Object',
	#instVars : [
		'scope'
	],
	#category : 'Hera-Exporting',
	#package : 'Hera',
	#tag : 'Exporting'
}

{ #category : 'private' }
HeraFeatureExporter >> exportFeature: aFeature to: aFolder [

	| featureFile |
	featureFile := aFolder / aFeature title asFileName , 'feature'.
	featureFile writeStreamDo: [ :stream | stream nextPutAll: aFeature script ]
]

{ #category : 'private' }
HeraFeatureExporter >> exportFeaturesOf: anAcceptanceTestClass to: aFolder [

	| acceptanceTestClassFolderReference |
	acceptanceTestClassFolderReference := aFolder / anAcceptanceTestClass nameInBrowser asFileName.
	acceptanceTestClassFolderReference ensureCreateDirectory.
	anAcceptanceTestClass featureMethods do: [ :featureMethod |
		self exportFeature: (anAcceptanceTestClass selector: featureMethod selector) feature to: acceptanceTestClassFolderReference ]
]

{ #category : 'exporting' }
HeraFeatureExporter >> exportFeaturesTo: aFolder [

	scope acceptanceTestClasses do: [ :acceptanceTestClass |
		self exportFeaturesOf: acceptanceTestClass to: aFolder ]
]

{ #category : 'accessing' }
HeraFeatureExporter >> scope: aScope [

	scope := aScope
]
