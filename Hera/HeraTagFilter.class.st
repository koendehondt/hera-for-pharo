Class {
	#name : 'HeraTagFilter',
	#superclass : 'HeraFilter',
	#instVars : [
		'tag'
	],
	#category : 'Hera-Running',
	#package : 'Hera',
	#tag : 'Running'
}

{ #category : 'instance creation' }
HeraTagFilter class >> for: aTagSymbol [

	^ self new tag: aTagSymbol
]

{ #category : 'filtering' }
HeraTagFilter >> selects: aFilterable [

	(aFilterable isMemberOf: HeraScenario) ifFalse: [ ^ true ].
	^ (aFilterable tags includes: tag) or: [ aFilterable inheritedTags includes: tag ]
]

{ #category : 'accessing' }
HeraTagFilter >> tag: aSymbol [

	tag := aSymbol
]
