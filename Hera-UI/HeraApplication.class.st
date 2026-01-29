Class {
	#name : 'HeraApplication',
	#superclass : 'SpApplication',
	#category : 'Hera-UI-Core',
	#package : 'Hera-UI',
	#tag : 'Core'
}

{ #category : 'private' }
HeraApplication >> defaulStylesheetSTON [

	"The failed and error background colors are the same as the text colors used by HeraTextReporter."
	"Note that the .resultCount style is useless because it does not work"
	^ '.application [
			.resultCount [ Font { #color: #white } ],
			.total [ Draw { #backgroundColor: #white} ],
			.passed [ Draw { #backgroundColor: #009900 } ],
			.failed [ Draw { #backgroundColor: #FE9900 } ],
			.error [ Draw { #backgroundColor: #FE0000 } ],
			.runButton [ Geometry { #hResizing: false }, Container { #borderColor: #transparent, #borderWidth: 1 } ],
			.activeButton [ Container { #borderColor: #darkGray } ],
			.featureText [ Font { #name: EnvironmentFont(#code) } ]
		]'
]

{ #category : 'initialization' }
HeraApplication >> initialize [

	super initialize.
	self addStyleSheetFromString: self defaulStylesheetSTON
]

{ #category : 'running' }
HeraApplication >> newFeatureBrowserOnScope: aScope [

	^ HeraFeatureBrowser new
		scope: aScope;
		application: self;
		yourself
]

{ #category : 'running' }
HeraApplication >> openDocumentation [

	| documentationBrowser |
	documentationBrowser := self openFeatureBrowserOnScope: (HeraScope new addClass: HeraSpecExamplesAcceptanceTest).
	documentationBrowser windowTitle: 'Documentation & Examples'
]

{ #category : 'running' }
HeraApplication >> openFeatureBrowser [

	^ self openFeatureBrowserOnScope: HeraScope default
]

{ #category : 'running' }
HeraApplication >> openFeatureBrowserOnAll [

	^ self openFeatureBrowserOnScope: HeraScope all
]

{ #category : 'running' }
HeraApplication >> openFeatureBrowserOnScope: aScope [

	^ (self newFeatureBrowserOnScope: aScope)
		open;
		yourself
]

{ #category : 'running' }
HeraApplication >> start [
	
	self openFeatureBrowserOnAll
]
