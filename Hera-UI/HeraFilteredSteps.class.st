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

{ #category : 'initialization' }
HeraFilteredSteps >> filter: aStepFilter [

	filter := aStepFilter.
	table items: self sortedStepMethodItems
]

{ #category : 'actions' }
HeraFilteredSteps >> findReferences [

	HeraStepReferencesBrowser new
		scope: scope;
		browseReferencesTo: self selectedStepMethodItem;
		open
	
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
				addActionWith: [ :action |
					action		
						name: 'References';
						description: 'Copy the selected step description';
						shortcutKey: $n meta;
						actionEnabled: [ self canFindReferences ];
						action: [ self findReferences ] ] ]
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

{ #category : 'private' }
HeraFilteredSteps >> sortedStepMethodItems [

	^ self stepMethodItems sort: [ :some :other | some stepDescription caseInsensitiveLessOrEqual: other stepDescription ]
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

{ #category : 'test api' }
HeraFilteredSteps >> tableItems [

	^ table items
]
