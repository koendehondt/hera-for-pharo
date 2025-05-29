Class {
	#name : 'HeraLintWarningTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Linter',
	#package : 'Hera-Tests',
	#tag : 'Linter'
}

{ #category : 'running' }
HeraLintWarningTestCase >> describedClass [

	^ HeraLintWarning
]

{ #category : 'tests' }
HeraLintWarningTestCase >> testColor [

	self assert: subject color equals: Color orange
]

{ #category : 'tests' }
HeraLintWarningTestCase >> testIconName [

	self assert: subject iconName equals: #warning
]

{ #category : 'tests' }
HeraLintWarningTestCase >> testPrintString [

	subject message: 'some message'.
	self assert: subject printString equals: 'a HeraLintWarning : some message'
]
