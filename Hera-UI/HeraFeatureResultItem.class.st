Class {
	#name : 'HeraFeatureResultItem',
	#superclass : 'HeraResultItem',
	#instVars : [
		'feature',
		'scenarioResultItems',
		'acceptanceTest'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'accessing' }
HeraFeatureResultItem >> acceptanceTest [

	^ acceptanceTest
]

{ #category : 'accessing' }
HeraFeatureResultItem >> acceptanceTest: anAcceptanceTest [

	acceptanceTest := anAcceptanceTest
]

{ #category : 'adding' }
HeraFeatureResultItem >> add: aScenarioResultItem [

	scenarioResultItems add: aScenarioResultItem
]

{ #category : 'accessing' }
HeraFeatureResultItem >> description [

	^ feature title
]

{ #category : 'accessing' }
HeraFeatureResultItem >> descriptionAttributes [

	^ { TextEmphasis bold }
]

{ #category : 'test api' }
HeraFeatureResultItem >> feature [

	^ feature
]

{ #category : 'accessing' }
HeraFeatureResultItem >> feature: aFeature [

	feature := aFeature
]

{ #category : 'initialization' }
HeraFeatureResultItem >> initialize [

	super initialize.
	scenarioResultItems := OrderedCollection new
]

{ #category : 'accessing' }
HeraFeatureResultItem >> level [

	^ 2
]

{ #category : 'rerunning - double dispatch' }
HeraFeatureResultItem >> rerunDebuggingFromRunner: aRunner [

	aRunner rerunAndDebugFeatureResult: self
]

{ #category : 'rerunning - double dispatch' }
HeraFeatureResultItem >> rerunFromRunner: aRunner [

	aRunner rerunFeatureResult: self
]

{ #category : 'rerunning - double dispatch' }
HeraFeatureResultItem >> rerunSteppingFromRunner: aRunner [

	aRunner rerunAndStepFeatureResult: self
]

{ #category : 'accessing' }
HeraFeatureResultItem >> subItems [

	^ scenarioResultItems
]
