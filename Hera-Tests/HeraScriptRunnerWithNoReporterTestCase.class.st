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

	subject scope: (HeraAcceptanceTestWithErrorInAfterScenarioHookForTesting selector: #featureWithSingleStepScenarioForTesting) asRunnerScope.
	subject reporter: HeraNoReporter new.
	subject run
]

{ #category : 'tests' }
HeraScriptRunnerWithNoReporterTestCase >> testErrorInBeforeScenarioHook [

	subject scope: (HeraAcceptanceTestWithErrorInBeforeScenarioHookForTesting selector: #featureWithSingleStepScenarioForTesting) asRunnerScope.
	subject reporter: HeraNoReporter new.
	subject run
]

{ #category : 'tests' }
HeraScriptRunnerWithNoReporterTestCase >> testErrorRun [

	subject scope: (HeraAcceptanceTestWithErrorForTesting selector: #signingInFeature) asRunnerScope.
	subject reporter: HeraNoReporter new.
	subject run
]

{ #category : 'tests' }
HeraScriptRunnerWithNoReporterTestCase >> testFailedRun [

	subject scope: (HeraAcceptanceTestWithFailureForTesting selector: #signingInFeature) asRunnerScope.
	subject reporter: HeraNoReporter new.
	subject run
]

{ #category : 'tests' }
HeraScriptRunnerWithNoReporterTestCase >> testRunWithRules [

	subject scope: (HeraAcceptanceTestExamplesForTesting selector: #featureWithRules) asRunnerScope.
	subject reporter: HeraNoReporter new.
	subject run
]
