Class {
	#name : 'HeraStepFinder',
	#superclass : 'Object',
	#instVars : [
		'scope',
		'stepMethodItem',
		'references'
	],
	#category : 'Hera-Analysis',
	#package : 'Hera',
	#tag : 'Analysis'
}

{ #category : 'finding/searching' }
HeraStepFinder >> collectReferencesTo: aStepDescription [

	| bag |
	bag := Bag new.
	self scope acceptanceTestClasses do: [ :eachClass |
		eachClass features do: [ :eachAcceptanceTest |
			(eachAcceptanceTest methodForStepDescription: aStepDescription) ifNotNil: [ :stepMethod |
				eachAcceptanceTest feature allSteps do: [ :eachStep |
					((stepMethod pragmaAt: #heraStepDefinition:) argumentAt: 1) last = eachStep description ifTrue: [ | foundStepMethodItem |
						foundStepMethodItem := HeraFeatureMethodItem new
							acceptanceTestClass: eachClass;
							featureMethodSelector: eachAcceptanceTest featureSelector.
						bag add: foundStepMethodItem ] ] ] ] ].
	^ bag
]

{ #category : 'finding/searching' }
HeraStepFinder >> findReferences [

	references := self collectReferencesTo: stepMethodItem stepDescription
]

{ #category : 'testing' }
HeraStepFinder >> hasReferences [

	^ references isNotEmpty
]

{ #category : 'accessing' }
HeraStepFinder >> references [

	^ references
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
HeraStepFinder >> stepMethodItem [

	^ stepMethodItem
]

{ #category : 'accessing' }
HeraStepFinder >> stepMethodItem: aStepMethodItem [

	stepMethodItem := aStepMethodItem
]
