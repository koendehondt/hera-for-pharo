Class {
	#name : 'HeraRootResultItem',
	#superclass : 'HeraResultItem',
	#instVars : [
		'featureCount',
		'featureResultItems'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'adding' }
HeraRootResultItem >> add: aFeatureoResultItem [

	featureResultItems add: aFeatureoResultItem
]

{ #category : 'accessing' }
HeraRootResultItem >> description [

	^ 'feature' heraPluralizeFor: featureCount
]

{ #category : 'test api' }
HeraRootResultItem >> featureCount [

	^ featureCount
]

{ #category : 'accessing' }
HeraRootResultItem >> featureCount: anInteger [

	featureCount := anInteger
]

{ #category : 'initialization' }
HeraRootResultItem >> initialize [

	super initialize.
	featureResultItems := OrderedCollection new
]

{ #category : 'accessing' }
HeraRootResultItem >> level [

	^ 1
]

{ #category : 'rerunning - double dispatch' }
HeraRootResultItem >> rerunDebuggingFromRunner: aRunner [

	aRunner rerunAndDebugRootResult: self
]

{ #category : 'rerunning - double dispatch' }
HeraRootResultItem >> rerunFromRunner: aRunner [

	aRunner rerunRootResult: self
]

{ #category : 'rerunning - double dispatch' }
HeraRootResultItem >> rerunSteppingFromRunner: aRunner [

	aRunner rerunAndStepRootResult: self
]

{ #category : 'accessing' }
HeraRootResultItem >> subItems [

	^ featureResultItems
]
