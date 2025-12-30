Class {
	#name : 'HeraSettingsTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraSettingsTestCase >> describedClass [

	^ HeraSettings
]

{ #category : 'tests' }
HeraSettingsTestCase >> doesNotWorkOnCI_testIcons [

	self assert: subject iconCount equals: 14.
	#(
		#crown #checkedCircle #book #run
		#runAll #runAndPause #references
		#saveFeatures #help #passedResult
		#failedResult #errorResult #runningResult) do: [ :each |
			self assert: ((subject iconNamed: each) isKindOf: Form)]
]

{ #category : 'running' }
HeraSettingsTestCase >> initializeSubject [

	subject := self describedClass uniqueInstance
]

{ #category : 'tests' }
HeraSettingsTestCase >> testClassInitialization [

	| oldUniqueInstance newUniqueInstance |
	oldUniqueInstance := self describedClass uniqueInstance. 
	self describedClass initialize.
	newUniqueInstance := self describedClass uniqueInstance.
	self assert: (newUniqueInstance isMemberOf: self describedClass).
	self deny: newUniqueInstance equals: oldUniqueInstance
]

{ #category : 'tests' }
HeraSettingsTestCase >> testHumanReadableDuration [

	self assert: (subject humanReadableDuration: (Duration days: 2 hours: 3 minutes: 4 seconds: 5)) equals: '2 days 3 hours 4 minutes 5 seconds'
]

{ #category : 'tests' }
HeraSettingsTestCase >> testHumanReadableDurationLessThanAMinute [

	self assert: (subject humanReadableDuration: (Duration seconds: 59)) equals: '59 seconds'
]

{ #category : 'tests' }
HeraSettingsTestCase >> testHumanReadableDurationLessThanANanoSecond [

	self assert: (subject humanReadableDuration: Duration zero) equals: 'Less than a nanosecond'
]

{ #category : 'tests' }
HeraSettingsTestCase >> testHumanReadableDurationLessThanASecond [

	self assert: (subject humanReadableDuration: (Duration milliSeconds: 1)) equals: 'Less than a second'.
	self assert: (subject humanReadableDuration: (Duration milliSeconds: 999)) equals: 'Less than a second'
]
