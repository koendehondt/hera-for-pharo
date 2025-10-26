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
HeraLintMissingStepDefinitionWarning >> highlightColor [

	^ Color pink
]

{ #category : 'accessing' }
HeraLintMissingStepDefinitionWarning >> iconName [

	^ #uncommentedClass
]

{ #category : 'accessing' }
HeraLintMissingStepDefinitionWarning >> underlineColor [

	^ nil
]
