Class {
	#name : 'HeraLintWarning',
	#superclass : 'Object',
	#instVars : [
		'message',
		'start',
		'end'
	],
	#category : 'Hera-Linter',
	#package : 'Hera',
	#tag : 'Linter'
}

{ #category : 'accessing' }
HeraLintWarning >> end [

	^ end
]

{ #category : 'accessing' }
HeraLintWarning >> end: anObject [

	end := anObject
]

{ #category : 'accessing' }
HeraLintWarning >> message [

	^ message
]

{ #category : 'accessing' }
HeraLintWarning >> message: anObject [

	message := anObject
]

{ #category : 'accessing' }
HeraLintWarning >> start [

	^ start
]

{ #category : 'accessing' }
HeraLintWarning >> start: anObject [

	start := anObject
]
