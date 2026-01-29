"
I am the root class of acceptance test classes that describe the behavior of Spec application.

I keep a collection `openPresenters`, which are the top-level presenters that have been opened in a window.
Presenters are added to the `openPresenters` with #openPrester:as: and #openPresenterAs:with:. Both methods take a first argument that identifies the top-level presenter. The identifier can be passed to helper methods to interact with the presenter or its subpresenters.

I also keep track of the `activePresenter`, which is the top-level presenter that is the target of all UI interaction with the helper methods I provide. The `activePresenter` is set by #openPrester:as: and #openPresenterAs:with:, which means that opening a presenter makes it the active presenter. The `activePresenter` is also set by #detectPresenterInWindowTitled:, which is used to find a presenter of a window with a given title, so that switching to another presenter and interacting with it is possible.

My instances do not know which nested presenters are used by a top-level presenter. Therefore, the top-level presenters have to implement the method #heraPresenterAt:ifAbsent: (typically classified in the ""hera"" protocol). That method takes the name of a nested presenter and answers the presenter. The name of the nested presenter can be any string. Often, it is the same as the label of a presenter, e.g. 'First name' for a text field with a label 'First name', but often it is also the logical name. For instance, in the HeraExampleFamilyTreePresenter, 'Family tree' is the name that refers to the tree presenter with the family members. The UI does not display a label, but the tree presenter in intended to hold the family tree. Hence the name.

Top-level presenters have subpresenters, but those subpresenters have subpresenters too. The top-level presenter's #heraPresenterAt:ifAbsent: method is responsible to return any nested subpresenter for a given name. If the name does not refer to an immediate subpresenter, the method should ask its subpresenters to answer a presenter for the given name. So the classes of nested subpresenters at any level also have to implement the method #heraPresenterAt:ifAbsent:.

Due to the responsibility of #heraPresenterAt:ifAbsent: to look for any arbitrarily nested presenters with the given name, encapsulation is ensured. It is not necessary to use paths of presenter names to refer to any nested presenter. Using paths would be brittle. They would show up all over the place in acceptance tests so that refactoring of nested presenters could break acceptance tests easily.
"
Class {
	#name : 'HeraSpecAcceptanceTest',
	#superclass : 'HeraAcceptanceTest',
	#instVars : [
		'targetWindow',
		'registeredWindows'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> activateWindow: aWindow [
	"Activate (bring to front) the given window.
	Register the window as the target window."

	(registeredWindows includes: aWindow)
		ifFalse: [ self error: 'The window cannot be activated because its opening has not been described before.' ].
	aWindow activate.
	targetWindow := aWindow.
	^ targetWindow
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> activateWindowTitled: aWindowTitle [
	"Activate (bring to front) the window with the given title.
	Register the window as the target window."

	^ self activateWindow: (self windowTitled: aWindowTitle)
]

{ #category : 'hooks' }
HeraSpecAcceptanceTest >> afterScenario [

	super afterScenario.
	self closeWindows
]

{ #category : 'asserting' }
HeraSpecAcceptanceTest >> assertDisabled: aPresenterName [

	self expect: (self isDisabled: aPresenterName) description: [ '"{1}" is enabled.' format: { aPresenterName } ]
]

{ #category : 'asserting' }
HeraSpecAcceptanceTest >> assertEmptyContents: aFieldPresenterName [

	self assert: (self stringContentsOf: aFieldPresenterName) isEmpty description: [ 'The field is not empty.' ]
]

{ #category : 'asserting' }
HeraSpecAcceptanceTest >> assertEmptyTree: aTreePresenterName [

	| tree |
	tree := self treePresenterAt: aTreePresenterName.
	self assert: tree roots isEmpty description: [ 'The tree is not empty.' ]
]

{ #category : 'asserting' }
HeraSpecAcceptanceTest >> assertEnabled: aPresenterName [

	self expect: (self isEnabled: aPresenterName) description: [ '"{1}" is disabled.' format: { aPresenterName } ]
]

{ #category : 'asserting' }
HeraSpecAcceptanceTest >> assertItems: expectedDataTreeItems inTree: aTreePresenterName [

	| tree actualDataTreeItems |
	tree := self presenterAt: aTreePresenterName.
	actualDataTreeItems := self collectTreeItemsIn: tree.
	self assert: actualDataTreeItems size = expectedDataTreeItems size description: [ 'The tree has {1}, while the data tree describes {2}.' format: { 'item' heraPluralizeFor: actualDataTreeItems size . 'item' heraPluralizeFor: expectedDataTreeItems size } ].
	1 to: expectedDataTreeItems size do: [ :index | | actualDataTreeItem expectedDataTreeItem |
		actualDataTreeItem := actualDataTreeItems at: index.
		expectedDataTreeItem := expectedDataTreeItems at: index.
		self assert: actualDataTreeItem level = expectedDataTreeItem level description: [ 'The level of item {1} is "{2}", not "{3}".' format: { index . actualDataTreeItem level . expectedDataTreeItem level } ].
		self assert: actualDataTreeItem text = expectedDataTreeItem text description: [ 'The text of item {1} is "{2}", not "{3}".' format: { index . actualDataTreeItem text . expectedDataTreeItem text } ] ]
]

{ #category : 'asserting' }
HeraSpecAcceptanceTest >> assertStringContentsOf: aFieldPresenterName equals: expectedString [

	self expect: (self stringContentsOf: aFieldPresenterName) toEqual: expectedString
]

{ #category : 'helpers - fields' }
HeraSpecAcceptanceTest >> assertText: expectedString inFieldNamed: aFieldPresenterName [

	| actualString |
	actualString := self stringContentsOf: aFieldPresenterName.
	self
		assert: actualString = expectedString
		description: [ 'The value of the field is "{1}".' format: { actualString } ]
]

{ #category : 'helpers - checkable presenters' }
HeraSpecAcceptanceTest >> check: aCheckboxPresenterName [

	| checkbox |
	checkbox := self checkboxPresenterAt: aCheckboxPresenterName.
	self
		errorIf: checkbox isEnabled not
		description: [ 'The checkbox "{1}" is disabled.' format: { aCheckboxPresenterName } ] .
	checkbox click
]

{ #category : 'helpers - finding presenters' }
HeraSpecAcceptanceTest >> checkboxPresenterAt: aCheckboxPresenterName [

	^ self presenterAt: aCheckboxPresenterName type: 'checkbox'
]

{ #category : 'initialization' }
HeraSpecAcceptanceTest >> clearRegisteredWindows [

	registeredWindows := IdentitySet new
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> click: aPresenterName [

	| presenter |
	presenter := self presenterAt: aPresenterName.
	self
		assert: presenter isEnabled
		description: [ 'The presenter "{1}" is disabled.' format: { aPresenterName } ] .
	presenter click
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> closeWindows [

	registeredWindows do: [ :each | each close ].
	self clearRegisteredWindows
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

{ #category : 'helpers - fields' }
HeraSpecAcceptanceTest >> enter: aString in: aFieldPresenterName [

	(self presenterAt: aFieldPresenterName) text: aString
]

{ #category : 'helpers - finding presenters' }
HeraSpecAcceptanceTest >> fieldPresenterAt: aFieldPresenterName [

	^ self presenterAt: aFieldPresenterName type: 'field'
]

{ #category : 'helpers - menus' }
HeraSpecAcceptanceTest >> findMenuItemForPath: aMenuItemPath inMenuBar: aMenubar [

	| pathItemLabels currentItems item |
	pathItemLabels := ' >> ' split: aMenuItemPath.
	currentItems := aMenubar menuBarItems.
	pathItemLabels do: [ :pathItemLabel |
		item := currentItems detect: [ :subItem | subItem label = pathItemLabel ] ifNone: [ self error: ('The menu item "{1}" is not present.' format: { pathItemLabel }) ].
		item enabled ifFalse: [ self error: ('The menu item "{1}" is disabled.' format: { pathItemLabel }) ].
		currentItems := item subMenu ifNotNil: [ :subMenu | subMenu items ] ].
	^item
]

{ #category : 'helpers - menus' }
HeraSpecAcceptanceTest >> findPharoMenuItemForPath: aMenuItemPath [

	^ self findMenuItemForPath: aMenuItemPath inMenuBar: self currentWorld menubar
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

{ #category : 'helpers - drop lists' }
HeraSpecAcceptanceTest >> indexOf: scope inDropListPresenter: dropListPresenter [

	| index |
	index := dropListPresenter getList detectIndex: [ :each | each model name = scope ] ifNone: [ 0 ].
	self assert: index > 0 description: 'Search mode not found: ' , scope.
	^ index
]

{ #category : 'initialization' }
HeraSpecAcceptanceTest >> initialize [

	super initialize.
	self clearRegisteredWindows
]

{ #category : 'helpers - checkable presenters' }
HeraSpecAcceptanceTest >> isChecked: aCheckboxPresenterName [

	^ (self checkboxPresenterAt: aCheckboxPresenterName) state
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> isDisabled: aPresenterName [

	^ (self presenterAt: aPresenterName) isEnabled not
]

{ #category : 'helpers - presenters' }
HeraSpecAcceptanceTest >> isEnabled: aPresenterName [

	^ (self presenterAt: aPresenterName) isEnabled
]

{ #category : 'helpers - checkable presenters' }
HeraSpecAcceptanceTest >> isUnchecked: aCheckboxPresenterName [

	^ (self checkboxPresenterAt: aCheckboxPresenterName) state not
]

{ #category : 'helpers - lists' }
HeraSpecAcceptanceTest >> itemsIn: aListPresenterName [

	^ (self listPresenterAt: aListPresenterName) items
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

{ #category : 'helpers - finding presenters' }
HeraSpecAcceptanceTest >> listPresenterAt: aListPresenterName [

	^ self presenterAt: aListPresenterName type: 'list'
]

{ #category : 'helpers - state' }
HeraSpecAcceptanceTest >> objectIdentifiedBy: anIdentifier [

	^ self stateAt: anIdentifier ifAbsent: [ self error: ('"{1}" has not been identified before' format: anIdentifier) ]
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> openPresenter: aPresenter [

	^ self registerWindow: aPresenter open window
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> openPresenterAs: aNameSymbol with: aBlock [

	^ self openPresenter: aBlock value
]

{ #category : 'helpers - finding presenters' }
HeraSpecAcceptanceTest >> presenterAt: aPresenterName [
	"Assume that the given name refers to a subpresenter at any level in the active presenter.
	 Answer the subpresenter or signal an error if it cannot be found."

	^ self targetPresenter
		heraPresenterAt: aPresenterName
		ifAbsent: [ self error: ('Presenter with name "{1}" not found.' format: { aPresenterName }) ]
]

{ #category : 'helpers - finding presenters' }
HeraSpecAcceptanceTest >> presenterAt: aFieldPresenterName type: aTypeString [

	self flag: 'aTypeString is not checked'.
	^ self targetPresenter
		heraPresenterAt: aFieldPresenterName
		ifAbsent: [ self error: ('The "{1}" {2} is not present in the "{3}" window. Maybe there is a typo in the name, or the name is not mapped to a presenter.' format: { aFieldPresenterName . aTypeString . self targetWindowLabel }) ]
]

{ #category : 'helpers - finding presenters' }
HeraSpecAcceptanceTest >> radioButtonPresenterAt: aRadioButtonPresenterName [

	^ self presenterAt: aRadioButtonPresenterName type: 'radio button'
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> registerWindow: aWindow [

	(registeredWindows includes: aWindow) ifTrue: [ self error: 'The opening of this window has been described before.' ].
	registeredWindows add: aWindow.
	targetWindow := aWindow.
	^ targetWindow
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> registerWindowTitled: aWindowTitle [

	^ self registerWindow: (self windowTitled: aWindowTitle)
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> registeredWindowTitled: aWindowTitle ifNone: noneBlock [

	^ registeredWindows detect: [ :window | window title = aWindowTitle ] ifNone: noneBlock
]

{ #category : 'helpers - drop lists' }
HeraSpecAcceptanceTest >> select: anItemString inDropList: aDropListPresenterName [

	| dropList index |
	dropList := self presenterAt: aDropListPresenterName.
	index := self indexOf: anItemString inDropListPresenter: dropList.
	dropList selectIndex: index
]

{ #category : 'helpers - trees' }
HeraSpecAcceptanceTest >> select: aTreeItemPath inTree: aTreePresenterName [

	self
		findTreePathFor: aTreeItemPath
		inTreeNamed: aTreePresenterName
		andDo: [ :treePresenter :treePath | treePresenter selectPath: treePath scrollToSelection: true ]
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepAWindowOpensWithTitle: aWindowTitle [

	<heraStepDefinition: #(Then match 'the {string} window opens')>

	self windowOpensWithTitle: aWindowTitle
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepAWindowOpensWithTitle: aWindowTitle identifiedBy: anIdentifier [

	<heraStepDefinition: #(Then match 'the {string} window opens, identified by {string}')>
	
	self stateAt: anIdentifier put: (self windowOpensWithTitle: aWindowTitle)
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepIActivateTheWindowIdentifiedBy: anIdentifier [

	<heraStepDefinition: #(When match 'I activate the window identified by {string}')>

	self activateWindow: (self objectIdentifiedBy: anIdentifier)
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepIActivateTheWindowTitled: aWindowTitle [	

	<heraStepDefinition: #(When match 'I activate the {string} window')>

	self activateWindowTitled: aWindowTitle
]

{ #category : 'steps - checkboxes' }
HeraSpecAcceptanceTest >> stepICheckTheCheckboxNamed: aCheckboxPresenterName [

	<heraStepDefinition: #(When match 'I check the {string} checkbox')>

	self check: aCheckboxPresenterName
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepIClickTheCloseBoxOfTheWindowIdentifiedBy: anIdentifier [

	<heraStepDefinition: #(When match 'I click the close box of the window identified by {string}')>

	(self objectIdentifiedBy: anIdentifier) closeBoxHit
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepIClickTheCloseBoxOfTheWindowTitled: aWindowTitle [

	<heraStepDefinition: #(When match 'I click the close box of the {string} window')>

	(self windowTitled: aWindowTitle) closeBoxHit
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
HeraSpecAcceptanceTest >> stepIDoubleClick: aTreeItemPath inTheTreeNamed: aTreePresenterName [

	<heraStepDefinition: #(When match 'I double click {string} in the {string} tree')>

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

	<heraStepDefinition: #(When match 'I fill in {string} in the {string} field')>

	self enter: aString in: aFieldPresenterName
]

{ #category : 'steps - buttons' }
HeraSpecAcceptanceTest >> stepIPressTheButtonNamed: aButtonName [

	<heraStepDefinition: #(When match 'I press the {string} button')>

	self click: aButtonName
]

{ #category : 'steps - fields' }
HeraSpecAcceptanceTest >> stepISee: expectedString inTheFieldNamed: aFieldPresenterName [

	<heraStepDefinition: #(Then match 'I see {string} in the {string} field')>

	self assertText: expectedString inFieldNamed: aFieldPresenterName
]

{ #category : 'steps - buttons' }
HeraSpecAcceptanceTest >> stepISeeADisabledButtonNamed: aButtonName [

	<heraStepDefinition: #(Then match 'I see a disabled {string} button')>

	self assertDisabled: aButtonName
]

{ #category : 'steps - lists' }
HeraSpecAcceptanceTest >> stepISeeAnEmptyListNamed: aListPresenterName [

	<heraStepDefinition: #(Then match 'I see an empty {string} list')>

	| list |
	list := self listPresenterAt: aListPresenterName.
	self assert: list items isEmpty description: [ 'The list has {1}.' format: { 'item' heraPluralizeFor: list listSize } ]
]

{ #category : 'steps - buttons' }
HeraSpecAcceptanceTest >> stepISeeAnEnabledButtonNamed: aButtonName [

	<heraStepDefinition: #(Then match 'I see an enabled {string} button')>

	self assertEnabled: aButtonName
]

{ #category : 'steps - fields' }
HeraSpecAcceptanceTest >> stepISeeTheFieldNamed: aFieldPresenterName hasText: expectedDocString [

	<heraStepDefinition: #(Then match 'I see the following text in the {string} field:')>

	self assertText: expectedDocString asString inFieldNamed: aFieldPresenterName
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

	self assertItems: aDataTree data inTree: aTreePresenterName
]

{ #category : 'steps - trees' }
HeraSpecAcceptanceTest >> stepISelect: aTreeItemPath inTreeNamed: aTreePresenterName [
	"Select the item at the end of the given path."

	<heraStepDefinition: #(When match 'I select {string} in the {string} tree')>

	self
		findTreePathFor: aTreeItemPath
		inTreeNamed: aTreePresenterName
		andDo: [ :treePresenter :treePath |
			treePresenter
				unselectAll; "Because #selectpath:scrollToSelection: adds the path to the selection."
				selectPath: treePath scrollToSelection: true ]
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

{ #category : 'steps - menus' }
HeraSpecAcceptanceTest >> stepISelectThePharoMenuBarItemWithPath: aMenuItemPath [

	<heraStepDefinition: #(When match 'I select the {string} menu item from the Pharo menu bar')>

	| menuItem |
	menuItem := self findPharoMenuItemForPath: aMenuItemPath.
	menuItem action value
]

{ #category : 'steps - radio buttons' }
HeraSpecAcceptanceTest >> stepISelectTheRadioButtonNamed: aRadioButtonPresenterName [

	<heraStepDefinition: #(When match 'I select the {string} radio button')>

	self check: aRadioButtonPresenterName
]

{ #category : 'steps - checkboxes' }
HeraSpecAcceptanceTest >> stepIUncheckTheCheckboxNamed: aCheckboxPresenterName [

	<heraStepDefinition: #(When match 'I uncheck the {string} checkbox')>

	self uncheck: aCheckboxPresenterName
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
				notSelected ifEmpty: [ '' ] ifNotEmpty: [ 'Not selected: {1}.' format: { notSelected asArray asCommaSeparatedDoubleQuotedStrings } ] .
				unexpectedSelected
					ifEmpty: [ '' ]
					ifNotEmpty: [ '{1}Selected: {2}.'
						format: {
							notSelected ifEmpty: [ '' ] ifNotEmpty: [ ' ' ] .
							unexpectedSelected asArray asCommaSeparatedDoubleQuotedStrings } ] } ]
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

	self
		assert: (self isChecked: aCheckboxPresenterName)
		description: [ 'The "{1}" checkbox in the "{2}" window is unchecked.' format: { aCheckboxPresenterName . self targetWindowLabel } ]
]

{ #category : 'steps - checkboxes' }
HeraSpecAcceptanceTest >> stepTheCheckboxIsUnchecked: aCheckboxPresenterName [

	<heraStepDefinition: #(Then match 'the {string} checkbox is unchecked')>

	self
		assert: (self isUnchecked: aCheckboxPresenterName)
		description: [ 'The "{1}" checkbox in the "{2}" window is checked.' format: { aCheckboxPresenterName . self targetWindowLabel } ]
]

{ #category : 'steps - radio buttons' }
HeraSpecAcceptanceTest >> stepTheRadioButtonIsOff: aRadioButtonPresenterName [

	<heraStepDefinition: #(Then match 'the {string} radio button is off')>

	self
		assert: (self isUnchecked: aRadioButtonPresenterName)
		description: [ 'The "{1}" radio button in the "{2}" window is on.' format: { aRadioButtonPresenterName . self targetWindowLabel } ]
]

{ #category : 'steps - radio buttons' }
HeraSpecAcceptanceTest >> stepTheRadioButtonIsOn: aRadioButtonPresenterName [

	<heraStepDefinition: #(Then match 'the {string} radio button is on')>

	self
		assert: (self isChecked: aRadioButtonPresenterName)
		description: [ 'The "{1}" radio button in the "{2}" window is off.' format: { aRadioButtonPresenterName . self targetWindowLabel } ]
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepTheTitleOfTheWindowIdentifiedBy: anIdentifier is: expectedWindowTitle [

	<heraStepDefinition: #(Then match 'the title of the window identified by {string} is {string}')>

	| window |
	window := self objectIdentifiedBy: anIdentifier.
	self
		assert: window title = expectedWindowTitle
		description: [ 'The title of the window identified by "{1}" is "{2}".' format: { anIdentifier . window title } ]
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepTheTitleOfTheWindowIs: expectedWindowTitle [

	<heraStepDefinition: #(Given match 'the title of the window is {string}')>

	self
		assert: self targetWindow title = expectedWindowTitle
		description: [ 'The target window title is "{1}".' format: { targetWindow title } ]
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepTheWindowClosesIdentifiedBy: anIdentifier [

	<heraStepDefinition: #(Then match 'the window identified by {string} closes')>

	self unregisterWindow: (self objectIdentifiedBy: anIdentifier)
]

{ #category : 'steps - windows' }
HeraSpecAcceptanceTest >> stepTheWindowClosesWithTitle: aWindowTitle [

	<heraStepDefinition: #(Then match 'the {string} window closes')>

	self unregisterWindowTitled: aWindowTitle
]

{ #category : 'helpers - fields' }
HeraSpecAcceptanceTest >> stringContentsOf: aFieldPresenterName [

	^ (self presenterAt: aFieldPresenterName) text asString
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> targetPresenter [

	^ self targetWindow model presenter
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> targetWindow [

	^ targetWindow ifNil: [ self error: 'The target window has not been set.' ]
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> targetWindowLabel [

	^ self targetWindow label
]

{ #category : 'helpers - finding presenters' }
HeraSpecAcceptanceTest >> treePresenterAt: aTreePresenterName [

	^ self presenterAt: aTreePresenterName type: 'tree'
]

{ #category : 'helpers - checkable presenters' }
HeraSpecAcceptanceTest >> uncheck: aCheckboxPresenterName [

	| checkbox |
	checkbox := self checkboxPresenterAt: aCheckboxPresenterName.
	self
		errorIf: checkbox isEnabled not
		description: [ 'The checkbox at {1} is not enabled.' format: { aCheckboxPresenterName } ] .
	checkbox click
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> unregisterWindow: aWindow [

	(registeredWindows includes: aWindow) ifFalse: [ self error: 'The opening of this window has not been described before.' ].
	self windowTitled: aWindow title ifFound: [ self signalFailure: 'The window is still open.' ].
	targetWindow = aWindow ifTrue: [ targetWindow := nil ].
	registeredWindows remove: aWindow
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> unregisterWindowTitled: aWindowTitle [

	| window |
	window := self registeredWindowTitled: aWindowTitle ifNone: [ self error: 'The opening of this window has not been described before.' ].
	self unregisterWindow: window
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> windowOpensWithTitle: aWindowTitle [

	self windowTitled: aWindowTitle ifNone: [ self signalFailure: 'The window is not open.' ].
	^ self registerWindowTitled: aWindowTitle
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> windowTitled: aWindowTitle [

	^ self
		windowTitled: aWindowTitle
		ifNone: [ self error: ('There is no window with title "{1}".' format: { aWindowTitle }) ]
]

{ #category : 'helpers - window management' }
HeraSpecAcceptanceTest >> windowTitled: aWindowTitle ifFound: foundBlock [

	| windows |
	windows := SystemWindow windowsIn: self currentWorld satisfying: [ :systemWindow | systemWindow label = aWindowTitle ].
	windows ifEmpty: [ ^ nil ].
	self
		errorIf: windows size > 1
		description: [ 'There is more than one window with title "{1}".' format: { aWindowTitle } ].
	foundBlock value: windows first
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
