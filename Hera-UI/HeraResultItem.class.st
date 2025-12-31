Class {
	#name : 'HeraResultItem',
	#superclass : 'Object',
	#instVars : [
		'startTime',
		'endTime',
		'logStartPosition',
		'logEndPosition'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'accessing' }
HeraResultItem >> description [

	self subclassResponsibility
]

{ #category : 'accessing' }
HeraResultItem >> descriptionAttributes [

	^ { TextEmphasis normal }
]

{ #category : 'accessing' }
HeraResultItem >> descriptionLabel [

	^ Text streamContents: [ :stream |
		stream
			withAttributes: self descriptionAttributes
			do: [ stream nextPutAll: self description ] ]
]

{ #category : 'accessing' }
HeraResultItem >> duration [

	^ endTime ifNotNil: [ endTime - startTime ]
]

{ #category : 'accessing' }
HeraResultItem >> durationLabel [

	| duration |
	duration := self duration.
	duration ifNil: [ ^ '' ].
	^ duration < 1 second
		ifTrue: [ '({1}ms)' format: { duration asMilliSeconds } ]
		ifFalse: ['({1}s)' format: { (duration asMilliSeconds / 1000) rounded } ]
]

{ #category : 'accessing' }
HeraResultItem >> endTime: aDateAndTime [

	endTime := aDateAndTime
]

{ #category : 'accessing' }
HeraResultItem >> iconName [

	^ nil
]

{ #category : 'accessing' }
HeraResultItem >> level [

	self subclassResponsibility
]

{ #category : 'test api' }
HeraResultItem >> logEndPosition [

	^ logEndPosition
]

{ #category : 'accessing' }
HeraResultItem >> logEndPosition: anInteger [

	logEndPosition := anInteger
]

{ #category : 'accessing' }
HeraResultItem >> logFrom: aText [

	(logStartPosition isNil or: [ logEndPosition isNil ]) ifTrue: [ ^ '' ].
	^ aText copyFrom: logStartPosition to: logEndPosition
]

{ #category : 'test api' }
HeraResultItem >> logStartPosition [

	^ logStartPosition
]

{ #category : 'accessing' }
HeraResultItem >> logStartPosition: anInteger [

	logStartPosition := anInteger
]

{ #category : 'rerunning - double dispatch' }
HeraResultItem >> rerunDebuggingFromRunner: aRunner [

	self subclassResponsibility
]

{ #category : 'rerunning - double dispatch' }
HeraResultItem >> rerunFromRunner: aRunner [

	self subclassResponsibility
]

{ #category : 'rerunning - double dispatch' }
HeraResultItem >> rerunSteppingFromRunner: aRunner [

	self subclassResponsibility
]

{ #category : 'accessing' }
HeraResultItem >> startTime: aDateAndTime [

	startTime := aDateAndTime
]

{ #category : 'accessing' }
HeraResultItem >> status [

	^ nil
]

{ #category : 'accessing' }
HeraResultItem >> subItems [

	self subclassResponsibility
]
