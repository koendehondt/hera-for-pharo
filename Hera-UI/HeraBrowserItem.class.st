Class {
	#name : 'HeraBrowserItem',
	#superclass : 'Object',
	#instVars : [
		'acceptanceTestClass'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'comparing' }
HeraBrowserItem >> = other [

	^ (other isMemberOf: self class) and: [ acceptanceTestClass = other acceptanceTestClass ]
]

{ #category : 'accessing' }
HeraBrowserItem >> acceptanceTestClass [

	^ acceptanceTestClass
]

{ #category : 'accessing' }
HeraBrowserItem >> acceptanceTestClass: aClass [

	acceptanceTestClass := aClass
]

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
HeraBrowserItem >> addStepDefinitionMethodFor: aStepAstNode as: targetSelector [

	| stepMethodSource targetClass generatedMethod protocol |
	stepMethodSource := '{1}{2}{2}{3}{4}'.
	targetClass := self targetClassForNewFeature.
	targetClass compile: stepMethodSource.
	generatedMethod := targetClass >> targetSelector.
	protocol := targetClass ensureProtocol: 'steps'.
	targetClass classify: targetSelector under: protocol.
	^ generatedMethod
]

{ #category : 'private' }
HeraBrowserItem >> astForScript: aString [

	^ HeraParser new
		initializeParserWith: aString;
		parseFeature
]

{ #category : 'actions' }
HeraBrowserItem >> browse [

	self subclassResponsibility
]

{ #category : 'comparing' }
HeraBrowserItem >> hash [

	^ acceptanceTestClass hash
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
