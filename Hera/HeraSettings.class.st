Class {
	#name : 'HeraSettings',
	#superclass : 'Object',
	#classVars : [
		'Icons'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'class initialization' }
HeraSettings class >> initialize [
	<script: 'HeraSettings initialize'>

	self installIcons.
	uniqueInstance := self new
]

{ #category : 'icons' }
HeraSettings class >> installIcon: aForm as: nameSymbol [

	Icons at: nameSymbol put: aForm
]

{ #category : 'class initialization' }
HeraSettings class >> installIcons [

	| heraRepo iconFolder iconProvider checkedCircle crown book addFeature run runAll runAndPause references saveFeatures help passedResult failedResult errorResult runningResult |
	Icons := Dictionary new.

	heraRepo := IceRepository repositories detect: [ :repo | repo name = 'hera-for-pharo' ].
	iconFolder := heraRepo location / 'icons'.
	iconProvider := SpLocationIconProvider newLocation: iconFolder.
	iconProvider loadAllIcons.

	addFeature := iconProvider iconNamed: #addFeature ifAbsent: [ nil ].
	crown := iconProvider iconNamed: #crown ifAbsent: [ nil ].
	checkedCircle := iconProvider iconNamed: #checkedCircle ifAbsent: [ nil ].
	book := iconProvider iconNamed: #book ifAbsent: [ nil ].
	run := iconProvider iconNamed: #run ifAbsent: [ nil ].
	runAll := iconProvider iconNamed: #runAll ifAbsent: [ nil ].
	runAndPause := iconProvider iconNamed: #runAndPause ifAbsent: [ nil ].
	references := iconProvider iconNamed: #references ifAbsent: [ nil ].
	saveFeatures := iconProvider iconNamed: #saveFeatures ifAbsent: [ nil ].
	help := iconProvider iconNamed: #help ifAbsent: [ nil ].
	passedResult := iconProvider iconNamed: #passedResult ifAbsent: [ nil ].
	failedResult := iconProvider iconNamed: #failedResult ifAbsent: [ nil ].
	errorResult := iconProvider iconNamed: #errorResult ifAbsent: [ nil ].
	runningResult := iconProvider iconNamed: #runningResult ifAbsent: [ nil ].
	self installIcon: addFeature as: #addFeature.
	self installIcon: crown as: #crown.
	self installIcon: checkedCircle as: #checkedCircle.
	self installIcon: book as: #book.
	self installIcon: run as: #run.
	self installIcon: runAll as: #runAll.
	self installIcon: runAndPause as: #runAndPause.
	self installIcon: references as: #references.
	self installIcon: saveFeatures as: #saveFeatures.
	self installIcon: help as: #help.
	self installIcon: passedResult as: #passedResult.
	self installIcon: failedResult as: #failedResult.
	self installIcon: errorResult as: #errorResult.
	self installIcon: runningResult as: #runningResult
]

{ #category : 'accessing' }
HeraSettings class >> uniqueInstance [

	^ uniqueInstance
]

{ #category : 'accessing' }
HeraSettings >> errorResultColor [

	^ Color fromHexString: 'FE0000'
]

{ #category : 'accessing' }
HeraSettings >> failedResultColor [

	^ Color fromHexString: 'FE9900'
]

{ #category : 'accessing' }
HeraSettings >> humanReadableDuration: aDuration [

	aDuration isZero ifTrue: [ ^ 'Less than a nanosecond' ].
	aDuration < (Duration seconds: 1) ifTrue: [ ^ 'Less than a second' ].
	^ (aDuration truncateTo: (Duration seconds: 1)) humanReadablePrintString
]

{ #category : 'test api' }
HeraSettings >> iconCount [

	^ Icons size
]

{ #category : 'accessing' }
HeraSettings >> iconNamed: aSymbol [

	^ Icons at: aSymbol ifAbsent: [ Smalltalk ui icons iconNamed: aSymbol ]
]
