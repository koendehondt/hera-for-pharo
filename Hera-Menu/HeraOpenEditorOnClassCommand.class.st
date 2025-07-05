"
I am in charge to create a submenu in Calypso when the selected class is `HeraAcceptanceTest`.
I can open a Hera Feature Browser with the selected class as a scope.
"
Class {
	#name : 'HeraOpenEditorOnClassCommand',
	#superclass : 'SycSingleClassCommand',
	#instVars : [
		'browser',
		'systemEnvironment'
	],
	#category : 'Hera-Menu',
	#package : 'Hera-Menu'
}

{ #category : 'testing' }
HeraOpenEditorOnClassCommand class >> canBeExecutedInContext: aToolContext [

	| selectedClass |
	aToolContext selectedClassItems size = 1 ifFalse: [ ^ false ].
	selectedClass := aToolContext selectedClassItems first actualObject.
	^ selectedClass inheritsFrom: HeraAcceptanceTest.
]

{ #category : 'activation' }
HeraOpenEditorOnClassCommand class >> fullBrowserMenuActivation [
	<classAnnotation>

	^ CmdContextMenuActivation byRootGroupItemOrder: 15 for: ClyFullBrowserClassContext
]

{ #category : 'activation' }
HeraOpenEditorOnClassCommand class >> fullBrowserShortcutActivation [
	<classAnnotation>

	^ CmdShortcutActivation by: $o meta, $f meta for: ClyFullBrowserClassContext
]

{ #category : 'accessing' }
HeraOpenEditorOnClassCommand >> defaultMenuItemName [
	^ 'Open with Hera Fetaures Browser'
]

{ #category : 'execution' }
HeraOpenEditorOnClassCommand >> execute [

	(HeraFeatureBrowser new scope: (HeraScope new addClass: targetClass)) open

]
