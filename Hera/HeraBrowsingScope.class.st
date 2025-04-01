Class {
	#name : 'HeraBrowsingScope',
	#superclass : 'Object',
	#instVars : [
		'acceptanceTestClasses'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HeraBrowsingScope class >> all [

	^ self new
]

{ #category : 'instance creation' }
HeraBrowsingScope class >> default [

	^ self new
		excludeHierarchy: HeraAcceptanceTestForTesting;
		excludeHierarchy: HeraSelfAcceptanceTest
]

{ #category : 'accessing' }
HeraBrowsingScope >> allForBrowsing [

	^ acceptanceTestClasses sorted: [ :some :other | some name <= other name ]
]

{ #category : 'accessing' }
HeraBrowsingScope >> allStepMethods [

	^ self allForBrowsing flatCollect: [ :each | each stepMethods ]
]

{ #category : 'accessing' }
HeraBrowsingScope >> excludeHierarchy: aClass [

	acceptanceTestClasses removeAll: aClass withAllSubclasses
]

{ #category : 'accessing' }
HeraBrowsingScope >> highestFeatureNumber [

	| max |
	max := 0.
	HeraAcceptanceTest allSubclasses do: [ :eachClass |
		eachClass featureMethods do: [ :eachMethod | | matcher |
			matcher := RxMatcher forString: 'feature(\d+)'.
			(matcher matches: eachMethod selector)
				ifTrue: [ | index |
					index := (matcher subexpressions: 2) first asInteger.
					max := index max: max ] ] ].
	^ max
]

{ #category : 'accessing' }
HeraBrowsingScope >> includeClass: aClass [

	acceptanceTestClasses add: aClass
]

{ #category : 'accessing' }
HeraBrowsingScope >> includeHierarchy: aClass [

	acceptanceTestClasses addAll: aClass allSubclasses
]

{ #category : 'initialization' }
HeraBrowsingScope >> initialize [

	super initialize.
	acceptanceTestClasses := HeraAcceptanceTest allSubclasses asSet.
]

{ #category : 'accessing' }
HeraBrowsingScope >> nextAvailableFeatureNumber [

	^ self highestFeatureNumber + 1
]
