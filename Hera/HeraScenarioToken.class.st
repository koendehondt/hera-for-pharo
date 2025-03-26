Class {
	#name : 'HeraScenarioToken',
	#superclass : 'HeraKeywordToken',
	#category : 'Hera-Gherkin parser',
	#package : 'Hera',
	#tag : 'Gherkin parser'
}

{ #category : 'accessing' }
HeraScenarioToken class >> keyword [

	^ 'Scenario:'
]

{ #category : 'testing' }
HeraScenarioToken >> isScenarioToken [

	^ true
]
