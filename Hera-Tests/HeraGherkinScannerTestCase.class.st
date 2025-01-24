Class {
	#name : 'HeraGherkinScannerTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tests-Gherkin parser',
	#package : 'Hera-Tests',
	#tag : 'Gherkin parser'
}

{ #category : 'running' }
HeraGherkinScannerTestCase >> describedClass [

	^ HeraGherkinScanner
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testDocStringToken [

	subject on: '"""' readStream.
	self assert: subject scanToken equals: (HeraDocStringToken new start: 1; end: 3)
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanAndToken [

	subject on: 'And' readStream.
	self assert: subject scanToken equals: (HeraAndToken new start: 1; end: 3)
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanBackgroundToken [

	subject on: 'Background:' readStream.
	self assert: subject scanToken equals: (HeraBackgroundToken new start: 1; end: 11)
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanButToken [

	subject on: 'But' readStream.
	self assert: subject scanToken equals: (HeraButToken new start: 1; end: 3)
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanDataTableToken [

	subject on: '|' readStream.
	self assert: subject scanToken equals: (HeraDataTableToken new start: 1; end: 1)
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanEndOfFileToken [

	subject on: '' readStream.
	self assert: subject scanToken equals: HeraEndOfFileToken new
]

{ #category : 'tests - scanning lines' }
HeraGherkinScannerTestCase >> testScanFeatureLine [

	| token |
	subject on: 'Feature: Signing in' readStream.
	self assert: subject scanToken equals: (HeraFeatureToken new start: 1; end: 8).
	token := subject scanToken.
	self assert: token equals: (HeraTextToken new start: 10; end: 19).
	self assert: token text equals: 'Signing in'
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanFeatureToken [

	subject on: 'Feature:' readStream.
	self assert: subject scanToken equals: (HeraFeatureToken new start: 1; end: 8)
]

{ #category : 'tests - scanning full descriptions' }
HeraGherkinScannerTestCase >> testScanFullFeature [

	| description token |
	description := '
	@accessing_the_system
	Feature: Signing in

		Scenario: Successful sign-in
			
			Given I have credentials to sign in
			When I enter my credentials
			And I press the button to sign in
			Then I see the home page'.
	subject on: description readStream.
	self assert: subject scanToken equals: HeraEndOfLineToken new.

	token := subject scanToken.
	self assert: token equals: (HeraTagToken new start: 3; end: 23).
	self assert: token text equals: 'accessing_the_system'.
	self assert: subject scanToken equals: HeraEndOfLineToken new.
	self assert: subject scanToken equals: (HeraFeatureToken new start: 26; end: 33).
	token := subject scanToken.
	self assert: token equals: (HeraTextToken new start: 35; end: 44).
	self assert: token text equals: 'Signing in'.
	self assert: subject scanToken equals: HeraEndOfLineToken new.

	self assert: subject scanToken equals: HeraEndOfLineToken new.

	self assert: subject scanToken equals: (HeraScenarioToken new start: 49; end: 57).
	token := subject scanToken.
	self assert: token equals: (HeraTextToken new start: 59; end: 76).
	self assert: token text equals: 'Successful sign-in'.
	self assert: subject scanToken equals: HeraEndOfLineToken new.

	self assert: subject scanToken equals: HeraEndOfLineToken new.

	self assert: subject scanToken equals: (HeraGivenToken new start: 85; end: 89).
	token := subject scanToken.
	self assert: token equals: (HeraTextToken new start: 91; end: 119).
	self assert: token text equals: 'I have credentials to sign in'.
	self assert: subject scanToken equals: HeraEndOfLineToken new.

	self assert: subject scanToken equals: (HeraWhenToken new start: 124; end: 127).
	token := subject scanToken.
	self assert: token equals: (HeraTextToken new start: 129; end: 150).
	self assert: token text equals: 'I enter my credentials'.
	self assert: subject scanToken equals: HeraEndOfLineToken new.

	self assert: subject scanToken equals: (HeraAndToken new start: 155; end: 157).
	token := subject scanToken.
	self assert: token equals: (HeraTextToken new start: 159; end: 187).
	self assert: token text equals: 'I press the button to sign in'.
	self assert: subject scanToken equals: HeraEndOfLineToken new.

	self assert: subject scanToken equals: (HeraThenToken new start: 192; end: 195).
	token := subject scanToken.
	self assert: token equals: (HeraTextToken new start: 197; end: 215).
	self assert: token text equals: 'I see the home page'.

	self assert: subject scanToken equals: HeraEndOfFileToken new
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanGivenToken [

	subject on: 'Given' readStream.
	self assert: subject scanToken equals: (HeraGivenToken new start: 1; end: 5)
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanScenarioToken [

	subject on: 'Scenario:' readStream.
	self assert: subject scanToken equals: (HeraScenarioToken new start: 1; end: 9)
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanTagToken [

	| token |
	subject on: ('{1}@accessing_the_system{2}' format: { Character tab . Character cr}) readStream.
	token := subject scanToken.
	self assert: token equals: (HeraTagToken new start: 2; end: 22).
	self assert: token text equals: 'accessing_the_system'
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanTextToken [

	| token |
	subject on: 'Signing in' readStream.
	token := subject scanToken.
	self assert: token equals: (HeraTextToken new start: 1; end: 10).
	self assert: token text equals: 'Signing in'
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanThenToken [

	subject on: 'Then' readStream.
	self assert: subject scanToken equals: (HeraThenToken new start: 1; end: 4)
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanWhenToken [

	subject on: 'When' readStream.
	self assert: subject scanToken equals: (HeraWhenToken new start: 1; end: 4)
]

{ #category : 'tests - scanning tokens' }
HeraGherkinScannerTestCase >> testScanningTextTrimsTheText [

	| token |
	subject on: '     Signing in  ' readStream.
	token := subject scanToken.
	self assert: token equals: (HeraTextToken new start: 6; end: 15).
	self assert: token text equals: 'Signing in'
]
