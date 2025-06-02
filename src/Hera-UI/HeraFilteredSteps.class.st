Class {
	#name : 'HeraFilteredSteps',
	#superclass : 'SpPresenter',
	#instVars : [
		'table',
		'editor',
		'filter',
		'scope'
	],
	#category : 'Hera-UI-Step Browser',
	#package : 'Hera-UI',
	#tag : 'Step Browser'
}

{ #category : 'initialization' }
HeraFilteredSteps >> connectPresenters [

	table
		whenSelectionChangedDo: [ :selection |
			editor model: selection selectedItem ]
]

{ #category : 'layout' }
HeraFilteredSteps >> defaultLayout [

	^ SpPanedLayout newHorizontal
		add: table;
		add: editor;
		yourself
]

{ #category : 'initialization' }
HeraFilteredSteps >> filter: aStepFilter [

	filter := aStepFilter.
	table items: self stepMethodItems
]

{ #category : 'initialization' }
HeraFilteredSteps >> initializePresenters [

	| descriptionColumn |
	descriptionColumn := SpStringTableColumn
		title: 'Step'
		evaluated: [ :stepMethod | stepMethod stepDescription ].
	descriptionColumn compareFunction: [ :some : other | some < other ].
	table := self newTable
		addColumn: descriptionColumn;
		yourself.
	editor := self instantiate: HeraStepEditor
]

{ #category : 'accessing' }
HeraFilteredSteps >> scope: aScope [

	scope := aScope
]

{ #category : 'private' }
HeraFilteredSteps >> stepMethodItems [

	^ self stepMethods
		collect: [ :each | HeraStepMethodItem new stepMethod: each ]
		thenSelect: [ :each | filter select: each ]
]

{ #category : 'private' }
HeraFilteredSteps >> stepMethods [

	^ scope allStepMethods
]
