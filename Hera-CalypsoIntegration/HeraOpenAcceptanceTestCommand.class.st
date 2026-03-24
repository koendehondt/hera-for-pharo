"
Open the selected acceptance test class in the Hera Feature Browser.
"
Class {
	#name : 'HeraOpenAcceptanceTestCommand',
	#superclass : 'ClyBrowserCommand',
	#instVars : [
		'selectedClass'
	],
	#category : 'Hera-CalypsoIntegration',
	#package : 'Hera-CalypsoIntegration'
}

{ #category : 'testing' }
HeraOpenAcceptanceTestCommand class >> canBeExecutedInContext: aBrowserContext [

    ^ aBrowserContext lastSelectedClass
        ifNil: [ false ]
        ifNotNil: [ :cls | cls inheritsFrom: HeraAcceptanceTest ]
]

{ #category : 'activation' }
HeraOpenAcceptanceTestCommand class >> fullBrowserMenuActivation [

    <classAnnotation>

    ^ CmdContextMenuActivation
        byItemOf: ClyQueryMenuGroup
        order: 2000
        for: ClyFullBrowserClassContext
]

{ #category : 'activation' }
HeraOpenAcceptanceTestCommand class >> fullBrowserShortcutActivation [

    <classAnnotation>

    ^ CmdShortcutActivation
        by: (KMKeyCombinationSequence first: $o meta next: $h meta)
        for: ClyFullBrowserClassContext
]

{ #category : 'accessing' }
HeraOpenAcceptanceTestCommand >> defaultMenuItemName [

    ^ 'Open in Hera Feature Browser'
]

{ #category : 'execution' }
HeraOpenAcceptanceTestCommand >> execute [

    | scope featureBrowser |
    scope := HeraScope new addClass: selectedClass.
    featureBrowser := HeraApplication new openFeatureBrowserOnScope: scope.
    featureBrowser selectAcceptanceTestClassNamed: selectedClass nameInBrowser
]

{ #category : 'execution' }
HeraOpenAcceptanceTestCommand >> prepareFullExecutionInContext: aBrowserContext [

    super prepareFullExecutionInContext: aBrowserContext.
    selectedClass := aBrowserContext lastSelectedClass
]
