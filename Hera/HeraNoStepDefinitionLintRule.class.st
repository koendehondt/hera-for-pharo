Class {
	#name : 'HeraNoStepDefinitionLintRule',
	#superclass : 'HeraLintRule',
	#category : 'Hera-Linter',
	#package : 'Hera',
	#tag : 'Linter'
}

{ #category : 'applying' }
HeraNoStepDefinitionLintRule >> broken [

	^ (self stepDefinitionExists: astNode description) not
]

{ #category : 'applying' }
HeraNoStepDefinitionLintRule >> warning [

	^ HeraLintMissingStepDefinitionWarning new
		message: 'This step has no definition';
		start: astNode start;
		end: astNode end
]
