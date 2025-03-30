Class {
	#name : 'HeraBrowserItem',
	#superclass : 'Object',
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'actions' }
HeraBrowserItem >> addFeatureNamed: aString [

	| codeGenerator featureMethodSource targetClass targetSelector generatedMethod protocol |
	codeGenerator := HeraFeatureMethodGenerator new.
	featureMethodSource := codeGenerator
		visit: (self astForScript: ('Feature: {1}' format: { aString }));
		generatedCode.
	targetClass := self targetClassForNewFeature.
	targetSelector := codeGenerator generatedSelector.
	targetClass compile: featureMethodSource.
	generatedMethod := targetClass >> targetSelector.
	protocol := targetClass ensureProtocol: 'features'.
	targetClass classify: targetSelector under: protocol.
	^ generatedMethod
]

{ #category : 'actions' }
HeraBrowserItem >> addStepDefinitionMethodFor: aStepAstNode as: targetSelector withSignature: targetSelectorWithFormalArguments [

	| stepMethodSource targetClass generatedMethod protocol pragma defaultBody |
	pragma := '<heraStepDefinition: #({1} ''{2}'')>' format: { aStepAstNode stepType . aStepAstNode description }.
	defaultBody := 'self stepNotImplemented'.
	stepMethodSource := '{1}{2}{3}{2}{4}' format: {
		targetSelectorWithFormalArguments .
		String with: Character cr with: Character cr with: Character tab .
		pragma .
		defaultBody }. self halt: 'This is not implemented correctly yet'.
	targetClass := self targetClassForNewFeature.
	targetClass compile: stepMethodSource.
	generatedMethod := targetClass >> targetSelector.
	protocol := targetClass ensureProtocol: 'steps'.
	targetClass classify: targetSelector under: protocol.
	^ generatedMethod
]

{ #category : 'private' }
HeraBrowserItem >> astForScript: aString [

	^ HeraGherkinParser new
		initializeParserWith: aString;
		parseFeature
]

{ #category : 'actions' }
HeraBrowserItem >> browse [

	self subclassResponsibility
]

{ #category : 'testing' }
HeraBrowserItem >> isRunnable [

	^ false
]

{ #category : 'accessing' }
HeraBrowserItem >> nameInBrowser [

	self subclassResponsibility
]

{ #category : 'accessing' }
HeraBrowserItem >> removalConfirmationQuestion [

	self subclassResponsibility
]

{ #category : 'actions' }
HeraBrowserItem >> remove [

	self subclassResponsibility
]

{ #category : 'accessing' }
HeraBrowserItem >> richScript [

	self subclassResponsibility
]

{ #category : 'accessing' }
HeraBrowserItem >> subitems [

	self subclassResponsibility
]

{ #category : 'private' }
HeraBrowserItem >> targetClassForNewFeature [

	self subclassResponsibility
]
