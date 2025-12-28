Class {
	#name : 'HeraFilteredSteps',
	#superclass : 'SpPresenter',
	#instVars : [
		'table',
		'editor',
		'scope',
		'stepFilterCriteria'
	],
	#category : 'Hera-UI-Step Browser',
	#package : 'Hera-UI',
	#tag : 'Step Browser'
}

{ #category : 'actions' }
HeraFilteredSteps >> canCopyStepDescriptionToClipboard [

	^ self selectedStepMethodItem isNotNil
]

{ #category : 'actions' }
HeraFilteredSteps >> canFindReferences [

	^ self selectedStepMethodItem isNotNil
]

{ #category : 'initialization' }
HeraFilteredSteps >> connectPresenters [

	table
		whenSelectionChangedDo: [ :selection |
			editor model: selection selectedItem ].
	self installContextMenu
]

{ #category : 'actions' }
HeraFilteredSteps >> copyStepDescriptionToClipboard [

	Clipboard clipboardText: self selectedStepMethodItem fullStepDescription
]

{ #category : 'layout' }
HeraFilteredSteps >> defaultLayout [

	^ SpPanedLayout newHorizontal
		add: table;
		add: editor;
		yourself
]

{ #category : 'private' }
HeraFilteredSteps >> filterSteps [

	table items: self sortedStepMethodItems
]

{ #category : 'test api' }
HeraFilteredSteps >> filteredSteps [

	^ table items
]

{ #category : 'actions' }
HeraFilteredSteps >> findReferences [

	Hera browseReferencesTo: self selectedStepMethodItem inScope: scope
]

{ #category : 'initialization' }
HeraFilteredSteps >> initializePresenters [

	| descriptionColumn |
	descriptionColumn := SpStringTableColumn
		title: 'Step'
		evaluated: [ :stepMethod | stepMethod fullStepDescription ].
	descriptionColumn compareFunction: [ :some : other | some < other ].
	table := self newTable
		addColumn: descriptionColumn;
		yourself.
	editor := self instantiate: HeraStepEditor
]

{ #category : 'private - menus' }
HeraFilteredSteps >> installContextMenu [

	table
		actionsWith: [ :rootGroup |
			rootGroup
				addActionWith: [ :action |
					action		
						name: 'Copy';
						description: 'Copy the selected step description';
						shortcutKey: $c meta;
						actionEnabled: [ self canCopyStepDescriptionToClipboard ];
						action: [ self copyStepDescriptionToClipboard ] ];
				addGroupWith: [ :referencesGroup |
					referencesGroup
						beDisplayedAsGroup;
						addActionWith: [ :action |
							action	
								name: 'References';
								description: 'Browse references to the selected step';
								shortcutKey: $n meta;
								iconProvider: Hera settings;
								iconName: 'references';
								actionEnabled: [ self canFindReferences ];
								action: [ self findReferences ] ] ] ]
]

{ #category : 'accessing' }
HeraFilteredSteps >> scope: aScope [

	scope := aScope
]

{ #category : 'test api' }
HeraFilteredSteps >> selectStepMethodItem: aStepMethodItem [
	
	table selectItem: aStepMethodItem
]

{ #category : 'accessing' }
HeraFilteredSteps >> selectedStepMethodItem [

	^ table selectedItem
]

{ #category : 'initialization' }
HeraFilteredSteps >> setupAfterOpening [

	self filterSteps
]

{ #category : 'private' }
HeraFilteredSteps >> sortedStepMethodItems [

	^ self stepMethodItems sort: [ :some :other | some fullStepDescription caseInsensitiveLessOrEqual: other fullStepDescription ]
]

{ #category : 'accessing' }
HeraFilteredSteps >> stepFilterCriteria: someStepFilterCriteria [

	stepFilterCriteria ifNotNil: [ stepFilterCriteria removeDependent: self ].
	stepFilterCriteria := someStepFilterCriteria.
	stepFilterCriteria addDependent: self
]

{ #category : 'private' }
HeraFilteredSteps >> stepMethodItems [

	^ self stepMethods
		collect: [ :each | HeraStepMethodItem new stepMethod: each ]
		thenSelect: [ :each | stepFilterCriteria satisfiedBy: each ]
]

{ #category : 'private' }
HeraFilteredSteps >> stepMethods [

	^ scope allStepMethods
]

{ #category : 'updating' }
HeraFilteredSteps >> update: anAspect [

	self filterSteps
]
