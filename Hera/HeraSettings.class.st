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

	| heraRepo iconFolder iconProvider checkedCircle crown |
	Icons := Dictionary new.

	heraRepo := IceRepository repositories detect: [ :repo | repo name = 'hera-for-pharo' ].
	iconFolder := heraRepo location / 'icons'.
	iconProvider := SpLocationIconProvider newLocation: iconFolder.
	iconProvider loadAllIcons.

	crown := iconProvider iconNamed: #crown ifAbsent: [ nil ].
	checkedCircle := iconProvider iconNamed: #checkedCircle ifAbsent: [ nil ].
	self installIcon: crown as: #crown.
	self installIcon: checkedCircle as: #checkedCircle
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
