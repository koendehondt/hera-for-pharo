Class {
	#name : 'HeraAnalytics',
	#superclass : 'Object',
	#category : 'Hera-Analytics',
	#package : 'Hera',
	#tag : 'Analytics'
}

{ #category : 'accessing' }
HeraAnalytics >> allForBrowsing [

	^ HeraAcceptanceTest allSubclasses select: #showInBrowser
]

{ #category : 'accessing' }
HeraAnalytics >> allStepMethods [

	^ self allForBrowsing flatCollect: [ :each | each stepMethods ]
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
HeraAnalytics >> nextAvailableFeatureNumber [

	^ self highestFeatureNumber + 1
]
