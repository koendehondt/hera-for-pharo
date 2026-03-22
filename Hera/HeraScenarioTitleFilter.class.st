Class {
	#name : 'HeraScenarioTitleFilter',
	#superclass : 'HeraFilter',
	#instVars : [
		'title'
	],
	#category : 'Hera-Running',
	#package : 'Hera',
	#tag : 'Running'
}

{ #category : 'filtering' }
HeraScenarioTitleFilter >> selects: aFilterable [

	(aFilterable isMemberOf: HeraScenario) ifFalse: [ ^ true ].
	^ aFilterable title = title
]

{ #category : 'accessing' }
HeraScenarioTitleFilter >> title: aString [

	title := aString
]
