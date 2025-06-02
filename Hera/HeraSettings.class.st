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

	| heraRepo iconFolder iconProvider heraRunner |
	Icons := Dictionary new.

	heraRepo := IceRepository repositories detect: [ :repo | repo name = 'hera-for-pharo' ].
	iconFolder := heraRepo location / 'icons'.
	iconProvider := SpLocationIconProvider newLocation: iconFolder.
	iconProvider loadAllIcons.

	heraRunner := iconProvider iconNamed: #heraRunner ifAbsent: [ nil ].
	self installIcon: heraRunner as: #heraRunner.
]

{ #category : 'accessing' }
HeraSettings class >> uniqueInstance [

	^ uniqueInstance
]

{ #category : 'accessing' }
HeraSettings >> iconForClass: aClass [

	^ self iconNamed: aClass systemIconName
]

{ #category : 'accessing' }
HeraSettings >> iconNamed: aSymbol [

	^ Icons at: aSymbol ifAbsent: [ Smalltalk ui icons iconNamed: aSymbol ]
]
