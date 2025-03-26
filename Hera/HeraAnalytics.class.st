Class {
	#name : 'HeraAnalytics',
	#superclass : 'Object',
	#instVars : [
		'acceptanceTestClasses'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HeraAnalytics class >> all [

	^ self new
]

{ #category : 'instance creation' }
HeraAnalytics class >> default [

	^ self new
		excludeHierarchy: HeraAcceptanceTestForTesting;
		excludeHierarchy: HeraSelfAcceptanceTest
]

{ #category : 'accessing' }
HeraAnalytics >> allForBrowsing [

	^ acceptanceTestClasses sorted: [ :some :other | some name <= other name ]
]

{ #category : 'accessing' }
HeraAnalytics >> allStepMethods [

	^ self allForBrowsing flatCollect: [ :each | each stepMethods ]
]

{ #category : 'accessing' }
HeraAnalytics >> excludeHierarchy: aClass [

	acceptanceTestClasses removeAll: aClass withAllSubclasses
]

{ #category : 'accessing' }
HeraAnalytics >> highestFeatureNumber [

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
HeraAnalytics >> includeClass: aClass [

	acceptanceTestClasses add: aClass
]

{ #category : 'accessing' }
HeraAnalytics >> includeHierarchy: aClass [

	acceptanceTestClasses addAll: aClass allSubclasses
]

{ #category : 'initialization' }
HeraAnalytics >> initialize [

	super initialize.
	acceptanceTestClasses := HeraAcceptanceTest allSubclasses asSet.
]

{ #category : 'accessing' }
HeraAnalytics >> nextAvailableFeatureNumber [

	^ self highestFeatureNumber + 1
]
