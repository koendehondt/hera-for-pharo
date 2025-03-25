Class {
	#name : 'HeraRunner',
	#superclass : 'SpPresenter',
	#instVars : [
		'output',
		'lastRunAcceptanceTest',
		'scriptRunner',
		'continueButton',
		'stepOverButton',
		'resultSummary',
		'stepOverScenarioButton'
	],
	#category : 'Hera-UI-Runner',
	#package : 'Hera-UI',
	#tag : 'Runner'
}

{ #category : 'accessing' }
HeraRunner class >> defaultPreferredExtent [

	^ 800@400
]

{ #category : 'accessing' }
HeraRunner >> clear [

	output text: Text new
]

{ #category : 'actions' }
HeraRunner >> continue [

	scriptRunner continue
]

{ #category : 'running' }
HeraRunner >> debugAcceptanceTest: anAcceptanceTest [

	lastRunAcceptanceTest := anAcceptanceTest.
	scriptRunner := self scriptRunnerFor: anAcceptanceTest.
	resultSummary model: scriptRunner result.
	self updateButtons.
	scriptRunner debug
]

{ #category : 'running' }
HeraRunner >> debugAcceptanceTest: anAcceptanceTest filteredBy: aFilter [

	lastRunAcceptanceTest := anAcceptanceTest.
	scriptRunner := self scriptRunnerFor: anAcceptanceTest.
	scriptRunner filter: aFilter.
	resultSummary model: scriptRunner result.
	scriptRunner debug
]

{ #category : 'running' }
HeraRunner >> debugScenario: aScenario [

	| runner scenarioFilter |
	runner := self instantiate: self class.
	runner open.
	scenarioFilter := HeraScenarioFilter new title: aScenario title.
	runner debugAcceptanceTest: lastRunAcceptanceTest filteredBy: scenarioFilter
]

{ #category : 'layout' }
HeraRunner >> defaultLayout [

	| controls |
	controls := SpBoxLayout newHorizontal
		spacing: 10;
		add: continueButton width: 40;
		add: stepOverScenarioButton width: 40;
		add: stepOverButton width: 40;
		add: self newLabel width: 40;
		add: resultSummary;
		yourself.
	^ SpBoxLayout newVertical
		spacing: 5;
		add: controls expand: false;
		add: output;
		yourself
]

{ #category : 'testing' }
HeraRunner >> hasRunAllScenarios [

	^ scriptRunner hasRunAllScenarios
]

{ #category : 'test api' }
HeraRunner >> hasRunSteps [

	^ scriptRunner hasRunSteps
]

{ #category : 'initialization' }
HeraRunner >> initializePresenters [

	continueButton := self newButton
		iconName: #glamorousGo;
		action: [ self continue ];
		help: 'Continue';
		yourself.
	stepOverScenarioButton := self newButton
		iconName: #glamorousOver;
		action: [ self stepOverScenario ];
		help: 'Step until end of scenario';
		yourself.
	stepOverButton := self newButton
		iconName: #glamorousInto;
		action: [ self stepOver ];
		help: 'Step';
		yourself.
	resultSummary := HeraRunnerResultSummary on: HeraResult new.
	output := self newText
		text: Text new;
		addStyle: 'featureText';
		yourself
]

{ #category : 'testing' }
HeraRunner >> isRunningScenario [

	^ scriptRunner isRunningScenario
]

{ #category : 'accessing' }
HeraRunner >> report: aText [

	| newText afterText |
	newText := output text append: aText.
	afterText := newText size + 1.
	output
		text: newText;
		selectionInterval: (afterText to: afterText)
]

{ #category : 'reporting' }
HeraRunner >> reportStartOfFeatures: features withFilter: filter [

	"Do nothing."
]

{ #category : 'running' }
HeraRunner >> runAcceptanceTest: anAcceptanceTest [

	lastRunAcceptanceTest := anAcceptanceTest.
	scriptRunner := self scriptRunnerFor: anAcceptanceTest.
	resultSummary model: scriptRunner result.
	self updateButtons.
	scriptRunner run
]

{ #category : 'running' }
HeraRunner >> runAcceptanceTest: anAcceptanceTest filteredBy: aFilter [

	lastRunAcceptanceTest := anAcceptanceTest.
	scriptRunner := self scriptRunnerFor: anAcceptanceTest.
	scriptRunner filter: aFilter.
	resultSummary model: scriptRunner result.
	scriptRunner run
]

{ #category : 'private' }
HeraRunner >> scriptRunnerFor: anAcceptanceTest [

	^ HeraScriptRunner new
		acceptanceTest: anAcceptanceTest;
		reporter: (HeraRunnerReporter for: self);
		prepareForRunning
]

{ #category : 'running' }
HeraRunner >> stepAcceptanceTest: anAcceptanceTest [

	lastRunAcceptanceTest := anAcceptanceTest.
	scriptRunner := self scriptRunnerFor: anAcceptanceTest.
	resultSummary model: scriptRunner result.
	self updateButtons
]

{ #category : 'actions' }
HeraRunner >> stepOver [

	scriptRunner runNext.
	self updateButtons
]

{ #category : 'actions' }
HeraRunner >> stepOverScenario [

	scriptRunner runOverScenario.
	self updateButtons
]

{ #category : 'private' }
HeraRunner >> updateButtons [

	| isNotFinished |
	isNotFinished := self hasRunAllScenarios not.
	continueButton enabled: isNotFinished.
	stepOverButton enabled: isNotFinished.
	stepOverScenarioButton enabled: self isRunningScenario
]

{ #category : 'accessing' }
HeraRunner >> windowTitle [

	^ 'Hera Runner'
]
