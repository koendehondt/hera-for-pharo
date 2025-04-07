"
I am the abstract root class of the lint issue classes.

A lint issue is reported by the `HeraLinter`.

Instance variables:
- message: a String that describes the issue
- start: the index of the first character in the source where the issue has been found
- end: the index of the last character in the source where the issue has been found
"
Class {
	#name : 'HeraLintIssue',
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
HeraLintIssue >> color [

	self subclassResponsibility
]

{ #category : 'accessing' }
HeraLintIssue >> end [

	^ end
]

{ #category : 'accessing' }
HeraLintIssue >> end: anObject [

	end := anObject
]

{ #category : 'accessing' }
HeraLintIssue >> iconName [

	self subclassResponsibility
]

{ #category : 'accessing' }
HeraLintIssue >> message [

	^ message
]

{ #category : 'accessing' }
HeraLintIssue >> message: anObject [

	message := anObject
]

{ #category : 'printing' }
HeraLintIssue >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ' : ';
		nextPutAll: self message
]

{ #category : 'accessing' }
HeraLintIssue >> start [

	^ start
]

{ #category : 'accessing' }
HeraLintIssue >> start: anObject [

	start := anObject
]
