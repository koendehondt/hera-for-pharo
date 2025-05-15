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

{ #category : 'running' }
HeraScriptRunnerWithNoReporterTestCase >> initializeReporter [

	reporter := HeraTextReporter new
		reportsTags: true;
		reportsDescriptions: true
]

{ #category : 'running' }
HeraScriptRunnerWithNoReporterTestCase >> setUp [

	super setUp.
	self initializeReporter
]

{ #category : 'tests' }
HeraScriptRunnerWithNoReporterTestCase >> testRunWithRules [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithRules).
	subject reporter: reporter.
	subject run
	"No assertion here because HeraNoReporter does not have state."
]
