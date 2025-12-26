Class {
	#name : 'HeraScenarioOutlineToken',
	#superclass : 'HeraKeywordToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraScenarioOutlineToken class >> keyword [

	^ 'Scenario Outline:'
]

{ #category : 'testing' }
HeraScenarioOutlineToken >> isScenarioOutlineToken [

	^ true
]
