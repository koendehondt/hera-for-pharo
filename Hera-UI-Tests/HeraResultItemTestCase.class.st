Class {
	#name : 'HeraResultItemTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Runner',
	#package : 'Hera-UI-Tests',
	#tag : 'Runner'
}

{ #category : 'running' }
HeraResultItemTestCase >> describedClass [

	^ HeraResultItem
]

{ #category : 'tests' }
HeraResultItemTestCase >> testDuration [

	| startTime endTime |
	startTime := DateAndTime now.
	endTime := startTime + 5 seconds.
	self describedClass subclasses do: [ :subclass |
		subject := subclass new
			startTime: startTime;
			endTime: endTime.
		self assert: subject duration equals: (Duration seconds: 5) ]
]

{ #category : 'tests' }
HeraResultItemTestCase >> testDurationLabelInMilliSeconds [

	| startTime endTime |
	startTime := DateAndTime now.
	endTime := startTime + 499 milliSeconds.
	self describedClass subclasses do: [ :subclass |
		subject := subclass new
			startTime: startTime;
			endTime: endTime.
		self assert: subject durationLabel equals: '(499ms)' ]
]

{ #category : 'tests' }
HeraResultItemTestCase >> testDurationLabelInSeconds [

	| startTime endTime |
	startTime := DateAndTime now.
	endTime := startTime + 5 seconds.
	self describedClass subclasses do: [ :subclass |
		subject := subclass new
			startTime: startTime;
			endTime: endTime.
		self assert: subject durationLabel equals: '(5s)' ]
]

{ #category : 'tests' }
HeraResultItemTestCase >> testDurationLabelInSecondsIsRounded [

	| startTime endTime |
	startTime := DateAndTime now.
	endTime := startTime + 3499 milliSeconds.
	self describedClass subclasses do: [ :subclass |
		subject := subclass new
			startTime: startTime;
			endTime: endTime.
		self assert: subject durationLabel equals: '(3s)'.
			subject endTime: startTime + 3500 milliSeconds.
		self assert: subject durationLabel equals: '(4s)' ]
]

{ #category : 'tests' }
HeraResultItemTestCase >> testDurationLabelWhenNoDuration [

	self describedClass subclasses do: [ :subclass |
		subject := subclass new.
		self assert: subject durationLabel equals: '' ]
]

{ #category : 'tests' }
HeraResultItemTestCase >> testDurationWhenNoEndTime [

	self describedClass subclasses do: [ :subclass |
		subject := subclass new startTime: DateAndTime now.
		self assert: subject duration isNil ]
]

{ #category : 'tests' }
HeraResultItemTestCase >> testDurationWhenNoStartTimeNorEndTime [

	self describedClass subclasses do: [ :subclass |
		subject := subclass new.
		self assert: subject duration isNil ]
]

{ #category : 'tests' }
HeraResultItemTestCase >> testLogFrom [

	self describedClass subclasses do: [ :subclass |
		subject := subclass new.
		subject
			logStartPosition: 5;
			logEndPosition: 10.
		self assert: (subject logFrom: 'abcdefghijklmnopqrstuvwxyz') equals: 'efghij' ]
]

{ #category : 'tests' }
HeraResultItemTestCase >> testLogFromWhenNoEndPosition [

	self describedClass subclasses do: [ :subclass |
		subject := subclass new.
		subject logStartPosition: 5.
		self assert: (subject logFrom: 'abcdefghijklmnopqrstuvwxyz') equals: '' ]
]

{ #category : 'tests' }
HeraResultItemTestCase >> testLogFromWhenNoStartNorEndPosition [

	self describedClass subclasses do: [ :subclass |
		subject := subclass new.
		self assert: (subject logFrom: 'abcdefghijklmnopqrstuvwxyz') equals: '' ]
]
