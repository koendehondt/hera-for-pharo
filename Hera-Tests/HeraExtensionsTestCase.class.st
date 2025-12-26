Class {
	#name : 'HeraExtensionsTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Extensions',
	#package : 'Hera-Tests',
	#tag : 'Extensions'
}

{ #category : 'running' }
HeraExtensionsTestCase >> describedClass [

	^ Hera
]

{ #category : 'tests - String' }
HeraExtensionsTestCase >> testHeraParameterFormat [

	self assert: ('I own 5 oranges' heraParameterFormat: (Dictionary with: 'fruit' -> 'apples')) equals: 'I own 5 oranges'.
	self assert: ('I own 7 <fruit>' heraParameterFormat: (Dictionary with: 'fruit' -> 'apples')) equals: 'I own 7 apples'.
	self assert: ('I own <number> <fruit>' heraParameterFormat: (Dictionary with: 'number' -> '5' with: 'fruit' -> 'apples')) equals: 'I own 5 apples'.
	self assert: ('I own <count> <Fruit>' heraParameterFormat: Dictionary new) equals: 'I own <count> <Fruit>'.
]

{ #category : 'tests - String' }
HeraExtensionsTestCase >> testHeraPluralizeFor [

	self assert: ('item' heraPluralizeFor: 0) equals: '0 items'.
	self assert: ('item' heraPluralizeFor: 1) equals: '1 item'.
	self assert: ('item' heraPluralizeFor: 2) equals: '2 items'
]

{ #category : 'tests - String' }
HeraExtensionsTestCase >> testHeraSorted [

	self assert: #() heraSorted equals: #().
	self assert: { 'F' } heraSorted equals: { 'F' }.
	self assert: { 'F' . 'c' } heraSorted equals: { 'c' . 'F' }
]
