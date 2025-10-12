Class {
	#name : 'HeraStepFinder',
	#superclass : 'Object',
	#instVars : [
		'scope',
		'stepMethodItem'
	],
	#category : 'Hera-Analysis',
	#package : 'Hera',
	#tag : 'Analysis'
}

{ #category : 'finding/searching' }
HeraStepFinder >> collectReferencesTo: aStepDescription [

	| references |
	references := Bag new.
	self scope acceptanceTestClasses do: [ :eachClass |
		eachClass features do: [ :eachAcceptanceTest |
			(eachAcceptanceTest methodForStepDescription: aStepDescription) ifNotNil: [ :stepMethod |
				eachAcceptanceTest feature allSteps do: [ :eachStep |
					((stepMethod pragmaAt: #heraStepDefinition:) argumentAt: 1) last = eachStep description ifTrue: [ | foundStepMethodItem |
						foundStepMethodItem := HeraFeatureMethodItem new
							acceptanceTestClass: eachClass;
							featureMethodSelector: eachAcceptanceTest featureSelector.
						references add: foundStepMethodItem ] ] ] ] ].
	^ references
]

{ #category : 'finding/searching' }
HeraStepFinder >> findReferences [

	^ self collectReferencesTo: stepMethodItem stepDescription
]

{ #category : 'accessing' }
HeraStepFinder >> scope [

	^ scope
]

{ #category : 'accessing' }
HeraStepFinder >> scope: aScope [

	scope := aScope
]

{ #category : 'accessing' }
HeraStepFinder >> stepMethodItem: aStepMethodItem [

	stepMethodItem := aStepMethodItem
]
