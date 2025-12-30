Class {
	#name : 'HeraSelfAcceptanceTest',
	#superclass : 'HeraSpecAcceptanceTest',
	#instVars : [
		'browsingScope'
	],
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

{ #category : 'steps' }
HeraSelfAcceptanceTest >> stepIOpenTheFeatureBrowser [

	<heraStepDefinition: #(When 'I open the Feature Browser')>

	| browser |
	browser := HeraApplication new newFeatureBrowserOnScope: browsingScope.
	self openFeatureBrowser: browser
]
