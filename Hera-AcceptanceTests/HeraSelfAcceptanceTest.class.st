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

	^ self stateAt: #featureBrowser
]

{ #category : 'private' }
HeraSelfAcceptanceTest >> openFeatureBrowser: aFeatureBrowser [

	self openPresenter: aFeatureBrowser.
	self stateAt: #featureBrowser put: aFeatureBrowser
]

{ #category : 'steps' }
HeraSelfAcceptanceTest >> stepIOpenTheFeatureBrowserOn: aDataTable [

	<heraStepDefinition: #(When 'I open the Feature Browser on:')>

	| browser classNames scope |
	classNames := aDataTable asArray collect: [ :each | Smalltalk globals classNamed: each ].
	scope := HeraScope new addClasses: classNames.
	browser := HeraApplication new newFeatureBrowserOnScope: scope.
	self openFeatureBrowser: browser
]

{ #category : 'steps' }
HeraSelfAcceptanceTest >> stepISeeTheOutputOfTheTestRunUptoTheFailingStep [

	<heraStepDefinition: #(Then 'I see the run log upto the failing step')>

	self assertStringContentsOf: 'Run log' equals: 'Running 1 feature.


Feature: With error

	Scenario: Running this scenario in debug mode opens the debugger
		When an error occurs'
]
