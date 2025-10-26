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
HeraLintWarningTestCase >> testHighlightColor [

	self assert: subject highlightColor isNil
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

{ #category : 'tests' }
HeraLintWarningTestCase >> testUnderlineColor [

	self assert: subject underlineColor equals: Color orange
]
