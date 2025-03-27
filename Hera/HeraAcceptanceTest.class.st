Class {
	#name : 'HeraAcceptanceTest',
	#superclass : 'Object',
	#traits : 'HeraAssertionTrait + HeraExpectationTrait',
	#classTraits : 'HeraAssertionTrait classTrait + HeraExpectationTrait classTrait',
	#instVars : [
		'featureSelector',
		'exactStepDefinitions',
		'patternStepDefinitions',
		'helpers'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'accessing' }
HeraAcceptanceTest class >> featureMethods [

	^ self methods select: [ :each | (each pragmaAt: #heraFeature:) isNotNil ]
]

{ #category : 'accessing' }
HeraAcceptanceTest class >> nameInBrowser [

	^ self name asString
]

{ #category : 'instance creation' }
HeraAcceptanceTest class >> selector: aFeatureSelectorSymbol [

	^ self new featureSelector: aFeatureSelectorSymbol
]

{ #category : 'accessing' }
HeraAcceptanceTest class >> stepMethods [
	"Answer all compiled methods that represent step definitions,
	 including methods from traits."

	^ self methods select: [ :each | (each pragmaAt: #heraStepDefinition:) isNotNil ]
]

{ #category : 'hooks' }
HeraAcceptanceTest >> afterScenario [
	"After scenario hook."
	
	"Default is to do nothing."
]

{ #category : 'private' }
HeraAcceptanceTest >> allAcceptanceTestClassesProvidingStepDefinitions [
	"Answer all classes that provide step definitions for the receiver.
	 Answer the superclasses from the highest superclass downto the receiver's class,
	 so that overriding of step definitions can be achieved."

	| currentClass acceptanceTestSuperclass classes |
	classes := OrderedCollection new.
	currentClass := self class.
	acceptanceTestSuperclass := HeraAcceptanceTest superclass.
	[ currentClass = acceptanceTestSuperclass ] whileFalse: [
		classes add: currentClass.
		currentClass := currentClass superclass ].
	^ classes reverse
]

{ #category : 'dsl' }
HeraAcceptanceTest >> background [

	^ HeraBackground new
]

{ #category : 'hooks' }
HeraAcceptanceTest >> beforeScenario [
	"Before scenario hook."
	
	"Default is to do nothing."
]

{ #category : 'copying' }
HeraAcceptanceTest >> copyForRunning [

	^ self class selector: featureSelector
]

{ #category : 'dsl' }
HeraAcceptanceTest >> dataTable: anArrayOfArrays [

	^ HeraDataTableArgument new dataTable: (HeraDataTable new data: anArrayOfArrays)
]

{ #category : 'dsl' }
HeraAcceptanceTest >> docString: anArrayOfStrings [

	^ HeraDocStringArgument new docString: (HeraDocString new lines: anArrayOfStrings)
]

{ #category : 'private' }
HeraAcceptanceTest >> executableStepForStepDescription: aString argument: data [

	| dataArgument |
	dataArgument := data ifNil: [ #() ] ifNotNil: [ { data } ].
	exactStepDefinitions at: (HeraExactStepDefinition for: aString) ifPresent: [ :executableStep |
		^ executableStep copy arguments: dataArgument ].
	patternStepDefinitions keysAndValuesDo: [ :stepDefinition :executableStep |
		(stepDefinition match: aString) ifNotNil: [ :arguments |
			^ executableStep copy arguments: (arguments copyWithAll: dataArgument) ] ].
	^ nil
]

{ #category : 'accessing' }
HeraAcceptanceTest >> feature [

	^ self perform: featureSelector
]

{ #category : 'dsl' }
HeraAcceptanceTest >> feature: aString [

	^ HeraFeature new name: aString
]

{ #category : 'accessing' }
HeraAcceptanceTest >> featureMethods [

	^ self class featureMethods
]

{ #category : 'accessing' }
HeraAcceptanceTest >> featureSelector [

	^ featureSelector
]

{ #category : 'initialization' }
HeraAcceptanceTest >> featureSelector: aSymbol [

	featureSelector := aSymbol
]

{ #category : 'initialization' }
HeraAcceptanceTest >> initialize [

	super initialize.
	exactStepDefinitions := Dictionary new.
	patternStepDefinitions := Dictionary new.
	helpers := OrderedCollection new.
	self registerHelpers.
	self initializeStepDefinitions
]

{ #category : 'initialization' }
HeraAcceptanceTest >> initializeStepDefinitions [

	self allAcceptanceTestClassesProvidingStepDefinitions do: [ :eachClass |
		eachClass stepMethods do: [ :eachStepMethod | | executableStep |
			executableStep := HeraExecutableAcceptanceTestStep new
				acceptanceTest: self;
				stepMethod: eachStepMethod.
			self registerExecutableStep: executableStep forStepMethod: eachStepMethod ] ].
	helpers do: [ :eachHelper |
		eachHelper class stepMethods do: [ :eachStepMethod | | executableStep |
			executableStep := HeraExecutableHelperStep new
				acceptanceTest: self;
				helper: eachHelper;
				stepMethod: eachStepMethod.
						self registerExecutableStep: executableStep forStepMethod: eachStepMethod ] ].
]

{ #category : 'accessing' }
HeraAcceptanceTest >> methodForStepDescription: aString [

	exactStepDefinitions at: (HeraExactStepDefinition for: aString) ifPresent: [ :executableStep | ^ executableStep stepMethod ].
	patternStepDefinitions keysAndValuesDo: [ :stepDefinition :executableStep |
		(stepDefinition matches: aString) ifTrue: [ ^ executableStep stepMethod ] ].
	^ nil
]

{ #category : 'preferences' }
HeraAcceptanceTest >> prefersDoubleQuotedStringArgumentsInStepDefinitions [
	"Answer true when double quotes are preferred.
	 Answer false when single quotes are preferred."

	^ true
]

{ #category : 'private' }
HeraAcceptanceTest >> regexStringForMatchStepDefinition: stepDefinition [

	^ stepDefinition copyReplaceAll: '{string}' with: '"([^"]+)"'
]

{ #category : 'private' }
HeraAcceptanceTest >> registerExecutableStep: anExecutableStep forStepMethod: aCompiledMethod [

	| arguments stepDescription stepDefinition |
	arguments := (aCompiledMethod pragmaAt: #heraStepDefinition:) argumentAt: 1.
	stepDescription := arguments last.
	arguments size = 2 ifTrue: [
		exactStepDefinitions at: (HeraExactStepDefinition for: stepDescription) put: anExecutableStep.
		^ self ].
	arguments size = 3 ifFalse: [ Error signal: 'Unexpected step definition' ].
	arguments second = #match ifTrue: [
		stepDefinition := HeraMatchStepDefinition for: stepDescription.
		self prefersDoubleQuotedStringArgumentsInStepDefinitions
			ifFalse: [ stepDefinition preferSingleQuotedStringArguments].
		patternStepDefinitions at: stepDefinition put: anExecutableStep.
		^ self ].
	arguments second = #regex ifTrue: [
		patternStepDefinitions at: (HeraRegexStepDefinition for: stepDescription) put: anExecutableStep.
		^ self ].
	Error signal: 'Unexpected step definition'
]

{ #category : 'private' }
HeraAcceptanceTest >> registerHelper: aHelper [

	aHelper acceptanceTest: self.
	helpers add: aHelper
]

{ #category : 'initialization' }
HeraAcceptanceTest >> registerHelpers [
	"By default, there are no helpers.
	 Override and send #registerHelper:."
]

{ #category : 'running' }
HeraAcceptanceTest >> runStep: aStep [

	| executableStep |
	executableStep := self executableStepForStepDescription: aStep description argument: aStep argumentValue.
	executableStep ifNil: [ HeraStepDefinitionNotFoundError signal ].
	executableStep run
]

{ #category : 'dsl' }
HeraAcceptanceTest >> scenario: aString [

	^ HeraScenario new title: aString
]

{ #category : 'failures' }
HeraAcceptanceTest >> signalFailure: aString [

	<debuggerCompleteToSender>

	HeraFailure signal: aString
]

{ #category : 'steps' }
HeraAcceptanceTest >> stepDebug [
	
	<heraStepDefinition: #(When 'I debug')>

	self halt: 'Debug step'
]
