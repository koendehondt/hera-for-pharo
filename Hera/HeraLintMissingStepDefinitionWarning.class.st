"
My instances describe a missing step.

A missing step definition has to be fixed to run a feature.
"
Class {
	#name : 'HeraLintMissingStepDefinitionWarning',
	#superclass : 'HeraLintIssue',
	#category : 'Hera-Linter',
	#package : 'Hera',
	#tag : 'Linter'
}

{ #category : 'accessing' }
HeraLintMissingStepDefinitionWarning >> color [

	^ Color blue
]

{ #category : 'accessing' }
HeraLintMissingStepDefinitionWarning >> iconName [

	^ #uncommentedClass
]
