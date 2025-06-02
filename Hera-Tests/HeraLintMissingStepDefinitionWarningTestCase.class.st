Class {
	#name : 'HeraLintMissingStepDefinitionWarningTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Linter',
	#package : 'Hera-Tests',
	#tag : 'Linter'
}

{ #category : 'running' }
HeraLintMissingStepDefinitionWarningTestCase >> describedClass [

	^ HeraLintMissingStepDefinitionWarning
]

{ #category : 'tests' }
HeraLintMissingStepDefinitionWarningTestCase >> testColor [

	self assert: subject color equals: Color blue
]

{ #category : 'tests' }
HeraLintMissingStepDefinitionWarningTestCase >> testIconName [

	self assert: subject iconName equals: #uncommentedClass
]

{ #category : 'tests' }
HeraLintMissingStepDefinitionWarningTestCase >> testPrintString [

	subject message: 'some message'.
	self assert: subject printString equals: 'a HeraLintMissingStepDefinitionWarning : some message'
]
