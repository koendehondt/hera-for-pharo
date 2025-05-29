Class {
	#name : 'HeraScriptRunnerTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Running',
	#package : 'Hera-Tests',
	#tag : 'Running'
}

{ #category : 'running' }
HeraScriptRunnerTestCase >> describedClass [

	^ HeraScriptRunner
]

{ #category : 'tests' }
HeraScriptRunnerTestCase >> testInitialization [

	self deny: subject isDebugging.
	self deny: subject hasRunSteps.
	self deny: subject hasRunScenarios
]
