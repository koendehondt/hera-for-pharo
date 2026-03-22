Class {
	#name : 'HeraTagFilterTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Running',
	#package : 'Hera-Tests',
	#tag : 'Running'
}

{ #category : 'running' }
HeraTagFilterTestCase >> describedClass [

	^ HeraTagFilter
]

{ #category : 'tests' }
HeraTagFilterTestCase >> testRejectsScenarioWithoutMatchingTag [

	| scenario |
	subject tag: #smoke.
	scenario := HeraScenario new tags: #(#regression).
	self deny: (subject selects: scenario)
]

{ #category : 'tests' }
HeraTagFilterTestCase >> testRejectsScenarioWithoutTags [

	| scenario |
	subject tag: #smoke.
	scenario := HeraScenario new tags: #().
	self deny: (subject selects: scenario)
]

{ #category : 'tests' }
HeraTagFilterTestCase >> testSelectsFeature [

	self assert: (subject selects: HeraFeature new)
]

{ #category : 'tests' }
HeraTagFilterTestCase >> testSelectsRule [

	self assert: (subject selects: HeraRule new)
]

{ #category : 'tests' }
HeraTagFilterTestCase >> testSelectsScenarioWithMatchingTag [

	| scenario |
	subject tag: #smoke.
	scenario := HeraScenario new tags: {#smoke}.
	self assert: (subject selects: scenario)
]

{ #category : 'tests' }
HeraTagFilterTestCase >> testSelectsScenarioWithMultipleTags [

	| scenario |
	subject tag: #smoke.
	scenario := HeraScenario new tags: #(#regression #smoke).
	self assert: (subject selects: scenario)
]
