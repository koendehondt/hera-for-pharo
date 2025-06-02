Class {
	#name : 'HeraScriptRunnerWithNoReporterTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Running',
	#package : 'Hera-Tests',
	#tag : 'Running'
}

{ #category : 'running' }
HeraScriptRunnerWithNoReporterTestCase >> describedClass [

	^ HeraScriptRunner
]

{ #category : 'tests' }
HeraScriptRunnerWithNoReporterTestCase >> testErrorInAfterScenarioHook [

	subject acceptanceTest: (HeraAcceptanceTestWithErrorInAfterScenarioHookForTesting selector: #featureWithSingleStepScenarioForTesting).
	subject reporter: HeraNoReporter new.
	subject run
]

{ #category : 'tests' }
HeraScriptRunnerWithNoReporterTestCase >> testErrorInBeforeScenarioHook [

	subject acceptanceTest: (HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting selector: #featureWithSingleStepScenarioForTesting).
	subject reporter: HeraNoReporter new.
	subject run
]

{ #category : 'tests' }
HeraScriptRunnerWithNoReporterTestCase >> testErrorRun [

	subject acceptanceTest: (HeraAcceptanceTestWithErrorForTesting selector: #signingInFeature).
	subject reporter: HeraNoReporter new.
	subject run
]

{ #category : 'tests' }
HeraScriptRunnerWithNoReporterTestCase >> testFailedRun [

	subject acceptanceTest: (HeraAcceptanceTestWithFailureForTesting selector: #signingInFeature).
	subject reporter: HeraNoReporter new.
	subject run
]

{ #category : 'tests' }
HeraScriptRunnerWithNoReporterTestCase >> testRunWithRules [

	subject acceptanceTest: (HeraAcceptanceTestExamplesForTesting selector: #featureWithRules).
	subject reporter: HeraNoReporter new.
	subject run
]
