Class {
	#name : 'HeraSelfAcceptanceTest',
	#superclass : 'HeraAcceptanceTest',
	#category : 'Hera-AcceptanceTests',
	#package : 'Hera-AcceptanceTests'
}

{ #category : 'testing' }
HeraSelfAcceptanceTest class >> isForTestingHera [

	^ true
]

{ #category : 'private' }
HeraSelfAcceptanceTest >> featureBrowser [

	^ self presenterAt: #featureBrowser
]

{ #category : 'private' }
HeraSelfAcceptanceTest >> featureRunner [

	^ self presenterAt: #featureRunner
]

{ #category : 'private' }
HeraSelfAcceptanceTest >> openFeatureBrowser: aFeatureBrowser [

	^ self openPresenter: aFeatureBrowser as: #featureBrowser
]
