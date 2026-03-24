"
Open the selected feature in the Hera Feature Browser.
"
Class {
	#name : 'HeraOpenFeatureCommand',
	#superclass : 'ClyBrowserCommand',
	#instVars : [
		'selectedClass',
		'selectedFeatureTitle'
	],
	#category : 'Hera-CalypsoIntegration',
	#package : 'Hera-CalypsoIntegration'
}

{ #category : 'testing' }
HeraOpenFeatureCommand class >> canBeExecutedInContext: aBrowserContext [

    ^ aBrowserContext lastSelectedMethod
        ifNil: [ false ]
        ifNotNil: [ :method |
            (method methodClass inheritsFrom: HeraAcceptanceTest)
                and: [ method hasPragmaNamed: #heraFeature: ] ]
]

{ #category : 'activation' }
HeraOpenFeatureCommand class >> methodMenuActivation [

    <classAnnotation>

    ^ CmdContextMenuActivation
        byItemOf: ClyQueryMenuGroup
        order: 2000
        for: ClyMethod asCalypsoItemContext
]

{ #category : 'activation' }
HeraOpenFeatureCommand class >> methodShortcutActivation [

    <classAnnotation>

    ^ CmdShortcutActivation
        by: (KMKeyCombinationSequence first: $o meta next: $h meta)
        for: ClyMethod asCalypsoItemContext
]

{ #category : 'accessing' }
HeraOpenFeatureCommand >> defaultMenuItemName [

    ^ 'Open in Hera Feature Browser'
]

{ #category : 'execution' }
HeraOpenFeatureCommand >> execute [

    | scope featureBrowser |
    scope := HeraScope new addClass: selectedClass.
    featureBrowser := HeraApplication new openFeatureBrowserOnScope: scope.
    featureBrowser selectFeature: selectedFeatureTitle in: selectedClass nameInBrowser
]

{ #category : 'execution' }
HeraOpenFeatureCommand >> prepareFullExecutionInContext: aBrowserContext [

    | method |
    super prepareFullExecutionInContext: aBrowserContext.
    method := aBrowserContext lastSelectedMethod.
    selectedClass := method methodClass.
    selectedFeatureTitle := (method pragmaAt: #heraFeature:) argumentAt: 1
]
