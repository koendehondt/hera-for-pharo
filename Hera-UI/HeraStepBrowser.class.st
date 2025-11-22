Class {
	#name : 'HeraStepBrowser',
	#superclass : 'HeraPresenter',
	#instVars : [
		'scope',
		'stepFilterCriteriaPanel',
		'filteredStepsPanel'
	],
	#category : 'Hera-UI-Step Browser',
	#package : 'Hera-UI',
	#tag : 'Step Browser'
}

{ #category : 'initialization' }
HeraStepBrowser >> connectPresenters [

	filteredStepsPanel stepFilterCriteria: stepFilterCriteriaPanel stepFilterCriteria
]

{ #category : 'test api' }
HeraStepBrowser >> copyStepDescriptionToClipboard [

	filteredStepsPanel copyStepDescriptionToClipboard
]

{ #category : 'layout' }
HeraStepBrowser >> defaultLayout [

	^ SpBoxLayout newVertical
		add: stepFilterCriteriaPanel expand: false fill: true padding: 15;
		add: filteredStepsPanel;
		yourself
]

{ #category : 'initialization' }
HeraStepBrowser >> initializePresenters [

	stepFilterCriteriaPanel := self instantiate: HeraStepFilterCriteriaPresenter on: HeraStepFilterCriteria new.
	filteredStepsPanel := (self instantiate: HeraFilteredSteps) scope: self scope
]

{ #category : 'initialization' }
HeraStepBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenOpenedDo: [ filteredStepsPanel setupAfterOpening ]
]

{ #category : 'accessing' }
HeraStepBrowser >> scope [

	^ scope ifNil: [ scope := HeraScope default ]
]

{ #category : 'accessing' }
HeraStepBrowser >> scope: aScope [

	scope := aScope.
	filteredStepsPanel scope: scope
]

{ #category : 'test api' }
HeraStepBrowser >> selectStepMethodItem: aStepMethodItem [

	filteredStepsPanel selectStepMethodItem: aStepMethodItem
]

{ #category : 'accessing' }
HeraStepBrowser >> windowIcon [

	^ Hera settings iconNamed: #book
]

{ #category : 'accessing' }
HeraStepBrowser >> windowTitle [

	^ 'Hera Step Browser'
]
