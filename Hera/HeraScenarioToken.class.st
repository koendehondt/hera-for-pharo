Class {
	#name : 'HeraScenarioToken',
	#superclass : 'HeraKeywordToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraScenarioToken class >> keyword [

	^ 'Scenario:'
]

{ #category : 'testing' }
HeraScenarioToken >> isScenarioToken [

	^ true
]
