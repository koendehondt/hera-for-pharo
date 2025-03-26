Class {
	#name : 'HeraBackgroundInstruction',
	#superclass : 'HeraRunInstruction',
	#instVars : [
		'background'
	],
	#category : 'Hera-Instructions',
	#package : 'Hera',
	#tag : 'Instructions'
}

{ #category : 'comparing' }
HeraBackgroundInstruction >> = other [

	^ super = other and: [ self background = other background ]
]

{ #category : 'accessing' }
HeraBackgroundInstruction >> background [

	^ background
]

{ #category : 'accessing' }
HeraBackgroundInstruction >> background: aBackground [

	background := aBackground
]

{ #category : 'performing' }
HeraBackgroundInstruction >> performFor: aScriptRunner [

	aScriptRunner runBackground: background
]
