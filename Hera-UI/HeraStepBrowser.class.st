Class {
	#name : 'HeraStepBrowser',
	#superclass : 'SpPresenter',
	#instVars : [
		'notebook'
	],
	#category : 'Hera-UI-Step Browser',
	#package : 'Hera-UI',
	#tag : 'Step Browser'
}

{ #category : 'layout' }
HeraStepBrowser >> defaultLayout [

	^ SpBoxLayout newVertical
		add: notebook;
		yourself
]

{ #category : 'initialization' }
HeraStepBrowser >> initializePresenters [

	notebook := self newNotebook
		addPageTitle: 'All' provider: [ HeraFilteredSteps new filter: HeraAllStepsFilter new ];
		addPageTitle: 'Given' provider: [ HeraFilteredSteps new filter: (HeraTypeBasedStepFilter new stepType: #Given) ];
		addPageTitle: 'When' provider: [ HeraFilteredSteps new filter: (HeraTypeBasedStepFilter new stepType: #When) ];
		addPageTitle: 'Then' provider: [ HeraFilteredSteps new filter: (HeraTypeBasedStepFilter new stepType: #Then) ];
		addPageTitle: 'Duplicates' provider: [ SpLabelPresenter new label: 'Not implemented yet' ];
		addPageTitle: 'Empty' provider: [ SpLabelPresenter new label: 'Not implemented yet' ];
		addPageTitle: 'Unused' provider: [ SpLabelPresenter new label: 'Not implemented yet' ];
		yourself
]

{ #category : 'accessing' }
HeraStepBrowser >> windowTitle [

	^ 'Hera Step Browser'
]
