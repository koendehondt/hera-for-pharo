Class {
	#name : 'HeraTagFilter',
	#superclass : 'HeraFilter',
	#instVars : [
		'tagExpression'
	],
	#category : 'Hera-Running',
	#package : 'Hera',
	#tag : 'Running'
}

{ #category : 'instance creation' }
HeraTagFilter class >> for: tagExpression [

	^ self new tagExpression: tagExpression
]

{ #category : 'filtering' }
HeraTagFilter >> selects: aFilterable [

	| tags tag |
	(aFilterable isMemberOf: HeraScenario) ifFalse: [ ^ true ].
	tags := (tagExpression splitOn: Character space).
	tags size > 1 ifTrue: [ ^ true ]. "Real tag expressions are not supported yet."
	tag := tags first.
	(tag first = $@) ifFalse: [ ^ true ]. "This should be verified before getting here."
	tag := tag allButFirst.
	^ (aFilterable tags includes: tag) or: [ aFilterable inheritedTags includes: tag ]
]

{ #category : 'accessing' }
HeraTagFilter >> tagExpression: aTagExpression [

	tagExpression := aTagExpression
]
