Class {
	#name : 'HeraScenarioFilter',
	#superclass : 'HeraFilter',
	#instVars : [
		'title'
	],
	#category : 'Hera-Running',
	#package : 'Hera',
	#tag : 'Running'
}

{ #category : 'filtering' }
HeraScenarioFilter >> selects: aFilterable [

	(aFilterable isMemberOf: HeraScenario) ifFalse: [ ^ true ].
	^ aFilterable title = title
]

{ #category : 'accessing' }
HeraScenarioFilter >> title: aString [

	title := aString
]
