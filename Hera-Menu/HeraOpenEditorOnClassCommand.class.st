"
Description
--------------------

I am a command available in the class context menu of Calypso. When activated I'll jump on the test class corresponding to the class. 

If the class does not exists I will create it in the corresponding package.
	
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	testClass:		<aClass>		Test class corresponding to the class I was activated with
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
