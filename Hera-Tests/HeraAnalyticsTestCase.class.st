Class {
	#name : 'HeraAnalyticsTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Analytics',
	#package : 'Hera-Tests',
	#tag : 'Analytics'
}

{ #category : 'running' }
HeraAnalyticsTestCase >> describedClass [

	^ HeraAnalytics
]

{ #category : 'tests' }
HeraAnalyticsTestCase >> testHighestFeatureNumber [

	"Based on the existing acceptance test classes in the Hera distribution."
	self assert: subject highestFeatureNumber equals: 0
]

{ #category : 'tests' }
HeraAnalyticsTestCase >> testNextAvailableFeatureNumber [

	"Based on the existing acceptance test classes in the Hera distribution."
	self assert: subject nextAvailableFeatureNumber equals: 1
]
