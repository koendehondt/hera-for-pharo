Class {
	#name : 'HeraScriptRunnerWithNoReporterTestCase',
	#superclass : 'HeraTestCase',
	#instVars : [
		'reporter'
	],
	#category : 'Hera-Tests-Running',
	#package : 'Hera-Tests',
	#tag : 'Running'
}

{ #category : 'running' }
HeraScriptRunnerWithNoReporterTestCase >> describedClass [

	^ HeraScriptRunner
]

{ #category : 'tests' }
HeraScriptRunnerWithNoReporterTestCase >> testRunWithRules [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithRules).
	subject reporter: HeraNoReporter new.
	subject run
	"No assertion here because HeraNoReporter does not have state."
]
