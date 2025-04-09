Class {
	#name : 'HeraNoColonAtBeginningOfStepDescriptionLintRule',
	#superclass : 'HeraLintRule',
	#category : 'Hera-Linter',
	#package : 'Hera',
	#tag : 'Linter'
}

{ #category : 'applying' }
HeraNoColonAtBeginningOfStepDescriptionLintRule >> broken [

	^ astNode description first = $:
]

{ #category : 'applying' }
HeraNoColonAtBeginningOfStepDescriptionLintRule >> warning [

	^ HeraLintWarning new
		message: 'A colon after a step keyword is not necessary';
		start: astNode start;
		end: astNode end.
]
