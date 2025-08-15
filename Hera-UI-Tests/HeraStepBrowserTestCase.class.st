Class {
	#name : 'HeraStepBrowserTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Step Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Step Browser'
}

{ #category : 'running' }
HeraStepBrowserTestCase >> describedClass [

	^ HeraStepBrowser
]

{ #category : 'running' }
HeraStepBrowserTestCase >> tearDown [

	subject ifNotNil: [ :browser | browser window close].
	super tearDown
]

{ #category : 'tests' }
HeraStepBrowserTestCase >> testCopyStepDescriptionToClipboard [

	| oldClipboardText |
	oldClipboardText := Clipboard clipboardText.
	[
		subject
			scope: (HeraScope new addClass: HeraAcceptanceTestWithPassForTesting);
			open;
			selectStepMethodItem: (HeraStepMethodItem new stepMethod: HeraAcceptanceTestWithPassForTesting>>#step7);
			copyStepDescriptionToClipboard.
		self assert: Clipboard clipboardText equals: 'Then I am still on the sign-in page'
	] ensure: [ Clipboard clipboardText: oldClipboardText ]
]
