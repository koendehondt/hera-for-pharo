Class {
	#name : 'HeraScenarioOutline',
	#superclass : 'HeraScenario',
	#instVars : [
		'examples'
	],
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraScenarioOutline >> accept: visitor [

	visitor visitScenarioOutline: self
]

{ #category : 'converting' }
HeraScenarioOutline >> asScenariosWithResolvedParameters [

	| dataTable parametersAndValues resolvedSteps |
	dataTable := self examples.
	(dataTable isNil or: [ dataTable isEmpty ]) ifTrue: [ ^ { self } ]. "No resolved parameters."
	parametersAndValues := dataTable asDictionaries.
	^ parametersAndValues collect: [ :parametersAndValuesForOneScenario |
		resolvedSteps := self steps withIndexCollect: [ :step :index | step asStepWithResolvedParameters: parametersAndValuesForOneScenario ].
		HeraScenario new
			tags: (self tagsWithResolvedParameters: parametersAndValuesForOneScenario);
			description: (self descriptionWithResolvedParameters: parametersAndValuesForOneScenario);
			title: (self title heraParameterFormat: parametersAndValuesForOneScenario);
			steps: resolvedSteps ]
]

{ #category : 'accessing' }
HeraScenarioOutline >> examples [

	^ examples
]

{ #category : 'dsl' }
HeraScenarioOutline >> examples: aDataTable [

	examples := aDataTable
]

{ #category : 'printing' }
HeraScenarioOutline >> printOn: aStream [

	aStream
		nextPutAll: 'Scenario Outline: ';
		nextPutAll: title
]
