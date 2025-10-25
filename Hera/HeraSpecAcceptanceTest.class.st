Class {
	#name : 'HeraSpecAcceptanceTest',
	#superclass : 'HeraAcceptanceTest',
	#instVars : [
		'openPresenters',
		'widgetMapping',
		'activePresenter'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> activePresenter [

	^ activePresenter ifNil: [ self error: 'There is no active window.' ]
]

{ #category : 'hooks' }
HeraSpecAcceptanceTest >> afterScenario [

	super afterScenario.
	self closeWindows
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> check: aTogglePresenterPathArray [

	| presenter |
	presenter := self presenterAtPath: aTogglePresenterPathArray.
	self assert: presenter isEnabled description: [ 'The presenter at ' , aTogglePresenterPathArray printString , ' is not enabled.' ] .
	self assert: presenter state not description: [ 'The presenter at ' , aTogglePresenterPathArray printString , ' is already checked.' ] .
	presenter click
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> click: aPresenterPathArray [

	| presenter |
	presenter := self presenterAtPath: aPresenterPathArray.
	self assert: presenter isEnabled description: [ 'The presenter at ' , aPresenterPathArray printString , ' is not enabled.' ] .
	presenter click
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> closePresenterAt: aNameSymbol [

	(self presenterAt: aNameSymbol) window close.
	openPresenters removeKey: aNameSymbol
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> closeWindows [

	openPresenters do: [ :each | each window close ].
	openPresenters := Dictionary new
]

{ #category : 'helpers - trees' }
HeraSpecAcceptanceTest >> collectTreeItemsFrom: aTreePresenter startingFrom: anItem path: aPath in: accu [

	accu add: (HeraDataTreeItem new level: aPath size; text: (aTreePresenter display value: anItem)).
	(aTreePresenter isExpanded: aPath) ifFalse: [ ^ self ].
	(aTreePresenter childrenFor: anItem) withIndexDo: [ :childItem :childIndex | | childPath |
		childPath := aPath asOrderedCollection add: childIndex; asArray.
		self collectTreeItemsFrom: aTreePresenter startingFrom: childItem path: childPath in: accu ]
]

{ #category : 'helpers - trees' }
HeraSpecAcceptanceTest >> collectTreeItemsIn: aTreePresenter [

	| items index |
	items := OrderedCollection new.
	index := 1.
	aTreePresenter roots do: [ :root |
		self collectTreeItemsFrom: aTreePresenter startingFrom: root path: { index } in: items.
		index := index + items size ].
	^ items
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> detectPresenterInTopWindowAs: aNameSymbol [

	^ openPresenters at: aNameSymbol put: SystemWindow topWindow model presenter
]

{ #category : 'helpers - trees' }
HeraSpecAcceptanceTest >> findTreePathFor: aTreeItemPath inTreeNamed: aTreePresenterName andDo: aBlock [

	| pathItemLabels items treePresenter currentPath |
	pathItemLabels := ' >> ' split: aTreeItemPath.
	treePresenter := self activePresenter
		heraWidgetAt: aTreePresenterName
		ifAbsent: [ self error: 'The tree cannot be found.' ].
	currentPath := OrderedCollection new.
	items := treePresenter roots.
	pathItemLabels withIndexDo: [ :itemLabel :index | | matchedItemIndex |
		matchedItemIndex := items
			detectIndex: [ :each | itemLabel = (treePresenter display value: each) ]
			ifNone: [ self error: ('Item {1} at level {2} is not present.' format: { itemLabel . index }) ].
		currentPath add: matchedItemIndex.
		(pathItemLabels size > currentPath size and: [ (treePresenter isExpanded: currentPath) not ]) ifTrue: [
			self error: ('Item {1} at level {2} is not expanded.' format: { itemLabel . index }) ].
		items := treePresenter childrenFor: (items at: matchedItemIndex) ].
	aBlock value: treePresenter value: currentPath
]

{ #category : 'initialization' }
HeraSpecAcceptanceTest >> initialize [

	super initialize.
	openPresenters := Dictionary new.
	self initializeWidgetMapping
]

{ #category : 'initialization' }
HeraSpecAcceptanceTest >> initializeWidgetMapping [
	"Define the mapping from exteral names used in scripts to the presenters in the UI.
	 Override to add associations to the Dictionary."

	widgetMapping := Dictionary new
]

{ #category : 'helpers - simulating events' }
HeraSpecAcceptanceTest >> keyDownEventFromChar: aCharacter alt: useAlt ctrl: useCtrl command: useCommand shift: useShift [

	| event modifier code |
	event := KeyboardEvent new.
	modifier := 0.
	useShift ifTrue: [ modifier := modifier + 8 ].
	useCtrl ifTrue: [ modifier := modifier + 16 ].
	useAlt ifTrue: [ modifier := modifier + 32 ].
	useCommand ifTrue: [ modifier := modifier + 64 ].
	code := aCharacter asInteger.
	event
		setType: #keyDown
		buttons: modifier
		position: 0 @ 0
		keyValue: code
		charCode: code
		hand: self currentWorld currentHand
		stamp: Time now.
	event key: (KeyboardKey fromCharacter: aCharacter).
	^ event
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> openPresenter: aPresenter as: aNameSymbol [

	aPresenter open.
	activePresenter := aPresenter.
	^ openPresenters at: aNameSymbol put: aPresenter
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> openPresenterAs: aNameSymbol with: aBlock [

	^ openPresenters at: aNameSymbol put: aBlock value
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> presenterAt: aNameSymbol [

	^ openPresenters at: aNameSymbol ifAbsent: [ self error: ('Presenter with name "{1}" not found.' format: { aNameSymbol }) ]
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> presenterAtPath: aPresenterPathArray [

	^ aPresenterPathArray allButFirst
		inject: (self presenterAt: aPresenterPathArray first)
		into: [ :accu :each | accu perform: each ]
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> presenterAtPath: aPresenterPathArray do: aBlock [

	aBlock value: (self presenterAtPath: aPresenterPathArray)
]

{ #category : 'steps - trees' }
HeraSpecAcceptanceTest >> stepICollapse: aTreeItemPath inTreeNamed: aTreePresenterName [
	"Collapse the item at the end of the given path.
	 Note that expanding an item also selects the item."

	<heraStepDefinition: #(When match 'I collapse {string} in the {string} tree')>

	self
		findTreePathFor: aTreeItemPath
		inTreeNamed: aTreePresenterName
		andDo: [ :treePresenter :treePath |
			treePresenter collapsePath: treePath ]
]

{ #category : 'steps - trees' }
HeraSpecAcceptanceTest >> stepIExpand: aTreeItemPath inTreeNamed: aTreePresenterName [
	"Expand the item at the end of the given path.
	 Note that expanding an item also selects the item."

	<heraStepDefinition: #(When match 'I expand {string} in the {string} tree')>

	self
		findTreePathFor: aTreeItemPath
		inTreeNamed: aTreePresenterName
		andDo: [ :treePresenter :treePath |
			treePresenter expandPath: treePath ]
]

{ #category : 'steps - trees' }
HeraSpecAcceptanceTest >> stepISeeTheTreeNamed: aTreePresenterName with: aDataTree [

	<heraStepDefinition: #(Then match 'I see the following {string} tree:')>

	| tree actualDataTreeItems expectedDataTreeItems |
	tree := self activePresenter
		heraWidgetAt: aTreePresenterName
		ifAbsent: [ self error: 'The tree cannot be found.' ].
	actualDataTreeItems := self collectTreeItemsIn: tree.
	expectedDataTreeItems := aDataTree data.
	self assert: actualDataTreeItems size = expectedDataTreeItems size description: [ 'The tree has {1} items, while the data tree describes {2} items.' format: { actualDataTreeItems size . expectedDataTreeItems size } ].
	1 to: expectedDataTreeItems size do: [ :index | | actualDataTreeItem expectedDataTreeItem |
		actualDataTreeItem := actualDataTreeItems at: index.
		expectedDataTreeItem := expectedDataTreeItems at: index.
		self assert: actualDataTreeItem level = expectedDataTreeItem level description: [ 'The level of item {1} is "{2}", not "{3}".' format: { index . actualDataTreeItem level . expectedDataTreeItem level } ].
		self assert: actualDataTreeItem text = expectedDataTreeItem text description: [ 'The text of item {1} is "{2}", not "{3}".' format: { index . actualDataTreeItem text . expectedDataTreeItem text } ] ]
]

{ #category : 'steps - trees' }
HeraSpecAcceptanceTest >> stepISelect: aTreeItemPath inTreeNamed: aTreePresenterName [
	"Select the item at the end of the given path."

	<heraStepDefinition: #(When match 'I select {string} in the {string} tree')>

	self
		findTreePathFor: aTreeItemPath
		inTreeNamed: aTreePresenterName
		andDo: [ :treePresenter :treePath |
			treePresenter selectPath: treePath scrollToSelection: true ]
]

{ #category : 'steps - trees' }
HeraSpecAcceptanceTest >> stepItemAt: aTreeItemPath isCollapsedInTreeNamed: aTreePresenterName [
	"Verify that the item at the end of the given path is expanded."

	<heraStepDefinition: #(Then match '{string} is collapsed in the {string} tree')>

	self
		findTreePathFor: aTreeItemPath
		inTreeNamed: aTreePresenterName
		andDo: [ :treePresenter :treePath |
			self
				assert: (treePresenter isExpanded: treePath) not
				description: [ 'The item is not collapsed.' ] ]
]

{ #category : 'steps - trees' }
HeraSpecAcceptanceTest >> stepItemAt: aTreeItemPath isExpandedInTreeNamed: aTreePresenterName [
	"Verify that the item at the end of the given path is expanded."

	<heraStepDefinition: #(Then match '{string} is expanded in the {string} tree')>

	self
		findTreePathFor: aTreeItemPath
		inTreeNamed: aTreePresenterName
		andDo: [ :treePresenter :treePath |
			self
				assert: (treePresenter isExpanded: treePath)
				description: [ 'The item is not expanded.' ] ]
]

{ #category : 'steps - trees' }
HeraSpecAcceptanceTest >> stepItemAt: aTreeItemPath isNotSelectedInTreeNamed: aTreePresenterName [
	"Verify that the item at the end of the given path is not selected."

	<heraStepDefinition: #(Then match '{string} is not selected in the {string} tree')>

	self
		findTreePathFor: aTreeItemPath
		inTreeNamed: aTreePresenterName
		andDo: [ :treePresenter :treePath |
			self
				assert: treePath ~= treePresenter selection selectedPath
				description: [ 'The item is selected.' ] ]
]

{ #category : 'steps - trees' }
HeraSpecAcceptanceTest >> stepItemAt: aTreeItemPath isSelectedInTreeNamed: aTreePresenterName [
	"Verify that the item at the end of the given path is selected."

	<heraStepDefinition: #(Then match '{string} is selected in the {string} tree')>

	self
		findTreePathFor: aTreeItemPath
		inTreeNamed: aTreePresenterName
		andDo: [ :treePresenter :treePath |
			self
				assert: treePath = treePresenter selection selectedPath
				description: [ 'The item is not selected.' ] ]
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> uncheck: aTogglePresenterPathArray [

	| presenter |
	presenter := self presenterAtPath: aTogglePresenterPathArray.
	self assert: presenter isEnabled description: [ 'The presenter at ' , aTogglePresenterPathArray printString , ' is not enabled.' ] .
	self assert: presenter state description: [ 'The presenter at ' , aTogglePresenterPathArray printString , ' is already unchecked.' ] .
	presenter click
]

{ #category : 'helpers - widgets' }
HeraSpecAcceptanceTest >> widgetAt: aWidgetName [

	^ widgetMapping
		at: aWidgetName
		ifAbsent: [ self error: ('"{1}" not found. Maybe there is a typo in the name, or the name is not mapped to a presenter.' format: { aWidgetName }) ]
]
