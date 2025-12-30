Class {
	#name : 'HeraResultStatus',
	#superclass : 'Model',
	#classVars : [
		'ErrorStatus',
		'FailedStatus',
		'PassedStatus',
		'RunningStatus'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'instance creation' }
HeraResultStatus class >> errorStatus [

	^ ErrorStatus
]

{ #category : 'instance creation' }
HeraResultStatus class >> failedStatus [

	^ FailedStatus
]

{ #category : 'class initialization' }
HeraResultStatus class >> initialize [

	PassedStatus := HeraPassedStatus new.
	FailedStatus := HeraFailedStatus new.
	ErrorStatus := HeraErrorStatus new.
	RunningStatus := HeraRunningStatus new
]

{ #category : 'instance creation' }
HeraResultStatus class >> passedStatus [

	^ PassedStatus
]

{ #category : 'instance creation' }
HeraResultStatus class >> runningStatus [

	^ RunningStatus
]

{ #category : 'accessing' }
HeraResultStatus >> iconName [

	^ self subclassResponsibility
]
