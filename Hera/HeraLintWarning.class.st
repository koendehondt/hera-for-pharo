"
My instances represent a lint warning.

A lint warning does not have to be fixed to run a feature.
"
Class {
	#name : 'HeraLintWarning',
	#superclass : 'HeraLintIssue',
	#category : 'Hera-Linter',
	#package : 'Hera',
	#tag : 'Linter'
}

{ #category : 'accessing' }
HeraLintWarning >> highlightColor [

	^ nil
]

{ #category : 'accessing' }
HeraLintWarning >> iconName [

	^ #warning
]

{ #category : 'accessing' }
HeraLintWarning >> underlineColor [

	^ Color orange
]
