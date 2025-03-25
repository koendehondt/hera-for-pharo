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
