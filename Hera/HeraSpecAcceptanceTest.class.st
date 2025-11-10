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

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> activeWindowLabel [

	^ self activePresenter window window label
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

{ #category : 'helpers - finding presenters' }
HeraSpecAcceptanceTest >> checkboxPresenterAt: aCheckboxPresenterName [

	^ self presenterAt: aCheckboxPresenterName type: 'checkbox'
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
HeraSpecAcceptanceTest >> closePresenterInWindowTitled: aWindowTitle [

	| window |
	window := self windowTitled: aWindowTitle.
	activePresenter := window model presenter.
	activePresenter window close.
	^ openPresenters removeKey: aWindowTitle
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

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> detectPresenterInWindowTitled: aWindowTitle [

	| window |
	window := self windowTitled: aWindowTitle.
	activePresenter := window model presenter.
	^ openPresenters at: aWindowTitle put: activePresenter
]

{ #category : 'helpers - finding presenters' }
HeraSpecAcceptanceTest >> fieldPresenterAt: aFieldPresenterName [

	^ self presenterAt: aFieldPresenterName type: 'field'
]

{ #category : 'helpers - trees' }
HeraSpecAcceptanceTest >> findTreePathFor: aTreeItemPath inTreeNamed: aTreePresenterName andDo: aBlock [

	| pathItemLabels items treePresenter currentPath |
	pathItemLabels := ' >> ' split: aTreeItemPath.
	treePresenter := self treePresenterAt: aTreePresenterName.
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

{ #category : 'helpers - lists' }
HeraSpecAcceptanceTest >> listPresenterAt: aListPresenterName [

	^ self presenterAt: aListPresenterName type: 'list'
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

{ #category : 'helpers - finding presenters' }
HeraSpecAcceptanceTest >> presenterAt: aFieldPresenterName type: aTypeString [

	^ self activePresenter
		heraPresenterAt: aFieldPresenterName
		ifAbsent: [ self error: ('The "{1}" {2} is not present in the "{3}" window. Maybe there is a typo in the name, or the name is not mapped to a presenter.' format: { aFieldPresenterName . aTypeString . self activeWindowLabel }) ]
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

{ #category : 'helpers - finding presenters' }
HeraSpecAcceptanceTest >> radioButtonPresenterAt: aRadioButtonPresenterName [

	^ self presenterAt: aRadioButtonPresenterName type: 'radio button'
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepIActivateTheWindowTitled: aWindowTitle [	

	<heraStepDefinition: #(When match 'I activate the {string} window')>

	self detectPresenterInWindowTitled: aWindowTitle
]

{ #category : 'steps - checkboxes' }
HeraSpecAcceptanceTest >> stepICheckTheCheckboxNamed: aCheckboxPresenterName [

	<heraStepDefinition: #(When match 'I check the {string} checkbox')>

	| checkbox |
	checkbox := self checkboxPresenterAt: aCheckboxPresenterName.
	checkbox state: true
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepICloseTheWindowTitled: aWindowTitle [

	<heraStepDefinition: #(When match 'I close the {string} window')>

	self closePresenterInWindowTitled: aWindowTitle
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

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepIDoNotSeeTheWindowTitled: aWindowTitle [

	<heraStepDefinition: #(Then match 'I do not see the {string} window')>

	self windowTitled: aWindowTitle ifNone: [ ^ self ].
	self signalFailure: 'The window is visible.'
]

{ #category : 'steps - trees' }
HeraSpecAcceptanceTest >> stepIDoubleClick: aTreeItemPath inTheTreeNamed: aTreePresenterName [

	<heraStepDefinition: #(Given match 'I double click {string} in the {string} tree')>

	self
		findTreePathFor: aTreeItemPath
		inTreeNamed: aTreePresenterName
		andDo: [ :treePresenter :treePath | | doubleClickEvent |
			treePresenter selectPath: treePath scrollToSelection: true.
			self
				errorIf: treePresenter hasEventHandler not
				description: [ 'The tree does not have an event handler.' ].
			doubleClickEvent := treePresenter eventHandler heraDoubleClickEvent.
			self
				errorIf: treePresenter hasEventHandler not
				description: [ 'The tree does not have a double click event handler.' ].
			doubleClickEvent action value: nil ]
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

{ #category : 'steps - fields' }
HeraSpecAcceptanceTest >> stepIFillIn: aString inTheFieldNamed: aFieldPresenterName [

	<heraStepDefinition: #(Given match 'I fill in {string} in the {string} field')>

	| field |
	field := self fieldPresenterAt: aFieldPresenterName.
	field text: aString
]

{ #category : 'steps - fields' }
HeraSpecAcceptanceTest >> stepISee: expectedString inTheFieldNamed: aFieldPresenterName [

	<heraStepDefinition: #(Then match 'I see {string} in the {string} field')>

	| field |
	field := self fieldPresenterAt: aFieldPresenterName.
	self
		assert: field text = expectedString
		description: [ 'The value of the field is "{1}".' format: { field text } ]
]

{ #category : 'steps - lists' }
HeraSpecAcceptanceTest >> stepISeeAnEmptyListNamed: aListPresenterName [

	<heraStepDefinition: #(Then match 'I see an empty {string} list')>

	| list |
	list := self listPresenterAt: aListPresenterName.
	self assert: list items isEmpty description: [ 'The list has {1}.' format: { 'item' heraPluralizeFor: list listSize } ]
]

{ #category : 'steps - lists' }
HeraSpecAcceptanceTest >> stepISeeTheListNamed: aListPresenterName withTheFollowingItems: aDataTable [

	<heraStepDefinition: #(Then match 'I see exactly the following items in the {string} list:')>

	| list actualItems expectedItems |
	list := self listPresenterAt: aListPresenterName.
	actualItems := list items.
	expectedItems := aDataTable asArray.
	self
		assert: actualItems size = expectedItems size
		description: [ 'The list has {1}, but the data table has {2}.' format: { 'item' heraPluralizeFor: actualItems size . 'item' heraPluralizeFor: expectedItems size } ].
	expectedItems withIndexDo: [ :expectedItem :index | | actualItem |
		actualItem := list display value: (actualItems at: index).
		self
			assert: expectedItem = actualItem
			description: [ 'Row {1}: Expected {2}, but found {3}.' format: { index . expectedItem . actualItem } ] ]
]

{ #category : 'steps - trees' }
HeraSpecAcceptanceTest >> stepISeeTheTreeNamed: aTreePresenterName with: aDataTree [

	<heraStepDefinition: #(Then match 'I see the following {string} tree:')>

	| tree actualDataTreeItems expectedDataTreeItems |
	tree := self treePresenterAt: aTreePresenterName.
	actualDataTreeItems := self collectTreeItemsIn: tree.
	expectedDataTreeItems := aDataTree data.
	self assert: actualDataTreeItems size = expectedDataTreeItems size description: [ 'The tree has {1}, while the data tree describes {2}.' format: { 'item' heraPluralizeFor: actualDataTreeItems size . 'item' heraPluralizeFor: expectedDataTreeItems size } ].
	1 to: expectedDataTreeItems size do: [ :index | | actualDataTreeItem expectedDataTreeItem |
		actualDataTreeItem := actualDataTreeItems at: index.
		expectedDataTreeItem := expectedDataTreeItems at: index.
		self assert: actualDataTreeItem level = expectedDataTreeItem level description: [ 'The level of item {1} is "{2}", not "{3}".' format: { index . actualDataTreeItem level . expectedDataTreeItem level } ].
		self assert: actualDataTreeItem text = expectedDataTreeItem text description: [ 'The text of item {1} is "{2}", not "{3}".' format: { index . actualDataTreeItem text . expectedDataTreeItem text } ] ]
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepISeeTheWindowTitled: aWindowTitle [

	<heraStepDefinition: #(Then match 'I see the {string} window')>

	self detectPresenterInWindowTitled: aWindowTitle
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

{ #category : 'steps - lists' }
HeraSpecAcceptanceTest >> stepISelectItemAtIndex: index inTheListNamed: aListPresenterName [

	<heraStepDefinition: #(When match 'I select item {int} in the {string} list')>

	| list |
	list := self listPresenterAt: aListPresenterName.
	self
		errorIf: (index < 1 or: [ index > list listSize ])
		description: [ '{1} is not a valid index. It should range from 1 to {2}.' format: { index . list listSize } ].
	list selectIndexes: { index }
]

{ #category : 'steps - lists' }
HeraSpecAcceptanceTest >> stepISelectItems: itemsExpression inTheListNamed: aListPresenterName [

	<heraStepDefinition: #(When match 'I select items {} in the {string} list')>

	| matcher startIndex endIndex list indexes |
	list := self listPresenterAt: aListPresenterName.
	matcher := RxMatcher forString: '(\d+) to (\d+)'.
	(matcher matches: itemsExpression) ifTrue: [
		startIndex := (matcher subexpression: 2) asInteger.
		endIndex := (matcher subexpression: 3) asInteger.
		self
			errorIf: (startIndex < 1 or: [ startIndex > list listSize ])
			description: [ '{1} is not a valid index. It should range from 1 to {2}.' format: { startIndex . list listSize } ].
		self
			errorIf: (endIndex < 1 or: [ endIndex > list listSize ])
			description: [ '{1} is not a valid index. It should range from 1 to {2}.' format: { endIndex . list listSize } ].
		self
			errorIf: endIndex < startIndex
			description: [ 'The end index should be greather than the start index.' ].
		list selectIndexes: (startIndex to: endIndex).
		^ self].
	matcher := RxMatcher forString: '(\d+)(, (\d))* and (\d+)'.
	(matcher matches: itemsExpression) ifTrue: [
		indexes := OrderedCollection new.
		2 to: matcher subexpressionCount do: [ :each | | indexString |
			indexString := matcher subexpression: each.
			indexString ifNotNil: [
				(indexString beginsWith: ',') ifFalse: [ indexes add: indexString asInteger ] ].
		indexes do: [ :eachIndex |
				self
					errorIf: (eachIndex < 1 or: [ eachIndex > list listSize ])
					description: [ '{1} is not a valid index. It should range from 1 to {2}.' format: { eachIndex . list listSize } ] ] ].
		list selectIndexes: indexes.
		^ self].
	self error: 'The expression for the item indexes is not recognized. Here are some examples: "1, 3, and 4", " "1 to 3".'
]

{ #category : 'steps - radio buttons' }
HeraSpecAcceptanceTest >> stepISelectTheRadioButtonNamed: aRadioButtonPresenterName [

	<heraStepDefinition: #(When match 'I select the {string} radio button')>

	| radioButton |
	radioButton := self radioButtonPresenterAt: aRadioButtonPresenterName.
	radioButton state: true
]

{ #category : 'steps - checkboxes' }
HeraSpecAcceptanceTest >> stepIUncheckTheCheckboxNamed: aCheckboxPresenterName [

	<heraStepDefinition: #(When match 'I uncheck the {string} checkbox')>

	| checkbox |
	checkbox := self checkboxPresenterAt: aCheckboxPresenterName.
	checkbox state: false
]

{ #category : 'steps - lists' }
HeraSpecAcceptanceTest >> stepInTheListNamed: aListPresenterName iSeeTheFollowingSelectedItems: aDataTable [

	<heraStepDefinition: #(Then match 'I see the following selected items in the {string} list:')>

	| list actualSelectedItems expectedSelectedItems notSelected unexpectedSelected |
	list := self listPresenterAt: aListPresenterName.
	actualSelectedItems := list selectedItems collect: [ :each | list display value: each ] as: Set.
	expectedSelectedItems := aDataTable asArray asSet.
	self
		assert: actualSelectedItems = expectedSelectedItems
		description: [
			notSelected := expectedSelectedItems difference: actualSelectedItems.
			unexpectedSelected := actualSelectedItems difference: expectedSelectedItems.
			'{1}{2}' format: {
				notSelected ifEmpty: [ '' ] ifNotEmpty: [ 'Not selected: {1}.' format: { self commaSeparated: notSelected asArray } ] .
				unexpectedSelected
					ifEmpty: [ '' ]
					ifNotEmpty: [ '{1}Selected: {2}.'
						format: {
							notSelected ifEmpty: [ '' ] ifNotEmpty: [ ' ' ] .
							self commaSeparated: unexpectedSelected asArray } ] } ]
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

{ #category : 'steps - checkboxes' }
HeraSpecAcceptanceTest >> stepTheCheckboxIsChecked: aCheckboxPresenterName [

	<heraStepDefinition: #(Then match 'the {string} checkbox is checked')>

	| checkbox |
	checkbox := self checkboxPresenterAt: aCheckboxPresenterName.
	self
		assert: checkbox state
		description: [ 'The "{1}" checkbox in the "{2}" window is unchecked.' format: { aCheckboxPresenterName . self activeWindowLabel } ]
]

{ #category : 'steps - checkboxes' }
HeraSpecAcceptanceTest >> stepTheCheckboxIsUnchecked: aCheckboxPresenterName [

	<heraStepDefinition: #(Then match 'the {string} checkbox is unchecked')>

	| checkbox |
	checkbox := self checkboxPresenterAt: aCheckboxPresenterName.
	self
		assert: checkbox state not
		description: [ 'The "{1}" checkbox in the "{2}" window is checked.' format: { aCheckboxPresenterName . self activeWindowLabel } ]
]

{ #category : 'steps - radio buttons' }
HeraSpecAcceptanceTest >> stepTheRadioButtonIsOff: aRadioButtonPresenterName [

	<heraStepDefinition: #(Then match 'the {string} radio button is off')>

	| radioButton |
	radioButton := self radioButtonPresenterAt: aRadioButtonPresenterName.
	self
		assert: radioButton state not
		description: [ 'The "{1}" radio button in the "{2}" window is on.' format: { aRadioButtonPresenterName . self activeWindowLabel } ]
]

{ #category : 'steps - radio buttons' }
HeraSpecAcceptanceTest >> stepTheRadioButtonIsOn: aRadioButtonPresenterName [

	<heraStepDefinition: #(Then match 'the {string} radio button is on')>

	| radioButton |
	radioButton := self radioButtonPresenterAt: aRadioButtonPresenterName.
	self
		assert: radioButton state
		description: [ 'The "{1}" radio button in the "{2}" window is off.' format: { aRadioButtonPresenterName . self activeWindowLabel } ]
]

{ #category : 'helpers - trees' }
HeraSpecAcceptanceTest >> treePresenterAt: aTreePresenterName [

	^ self presenterAt: aTreePresenterName type: 'tree'
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> uncheck: aTogglePresenterPathArray [

	| presenter |
	presenter := self presenterAtPath: aTogglePresenterPathArray.
	self assert: presenter isEnabled description: [ 'The presenter at ' , aTogglePresenterPathArray printString , ' is not enabled.' ] .
	self assert: presenter state description: [ 'The presenter at ' , aTogglePresenterPathArray printString , ' is already unchecked.' ] .
	presenter click
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> windowTitled: aWindowTitle [

	^ self
		windowTitled: aWindowTitle
		ifNone: [ self error: ('There is no window with title "{1}".' format: { aWindowTitle }) ]
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> windowTitled: aWindowTitle ifNone: noneBlock [

	| windows |
	windows := SystemWindow windowsIn: self currentWorld satisfying: [ :systemWindow | systemWindow label = aWindowTitle ].
	windows ifEmpty: [ ^ noneBlock value ].
	self
		errorIf: windows size > 1
		description: [ 'There is more than one window with title "{1}".' format: { aWindowTitle } ].
	^ windows first
]
