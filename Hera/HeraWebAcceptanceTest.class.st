"
In order to use this class, load Seaside and Parasol.

Metacello new
 baseline:'Seaside3';
 repository: 'github://SeasideSt/Seaside:master/repository';
 load.

Metacello new
    baseline: 'Parasol';
    repository: 'github://SeasideSt/Parasol:master/repository';
    load: 'default'.
"
Class {
	#name : 'HeraWebAcceptanceTest',
	#superclass : 'HeraAcceptanceTest',
	#instVars : [
		'driver'
	],
	#category : 'Hera-Web',
	#package : 'Hera',
	#tag : 'Web'
}

{ #category : 'hooks' }
HeraWebAcceptanceTest >> afterScenario [

	driver quit.
	super afterScenario
]

{ #category : 'hooks' }
HeraWebAcceptanceTest >> beforeScenario [
	
	| webDriverClass |
	super beforeScenario.
	webDriverClass := Smalltalk at: #BPRemoteWebDriver ifAbsent: [ self error: 'Please load Seaside and Parasol. See the comment of class HeraWebAcceptanceTest.' ].
	driver := webDriverClass withCapabilities: self chromeOptions
]

{ #category : 'private' }
HeraWebAcceptanceTest >> chromeOptions [
	"Answer the options to use for the Chrome driver."

	"Access Smalltalk to avoid undeclared class names if Parasol is not loaded."
	^ (Smalltalk at: #BPChromeOptions) new
]

{ #category : 'helpers' }
HeraWebAcceptanceTest >> clickButtonLabeled: aButtonLabel [

	| xpath |
	xpath := '//button[text()=''{1}'']' format: { aButtonLabel }.
	(driver findElementByXPath: xpath) click
]

{ #category : 'helpers' }
HeraWebAcceptanceTest >> enter: aString inFieldIdentifiedBy: labelOrPlaceholder [

	(self findInput: labelOrPlaceholder) sendKeys: aString , (String with: BPKeys return)
]

{ #category : 'helpers' }
HeraWebAcceptanceTest >> fillIn: aString inFieldIdentifiedBy: labelOrPlaceholder [

	(self findInput: labelOrPlaceholder) sendKeys: aString
]

{ #category : 'helpers' }
HeraWebAcceptanceTest >> findInput: labelOrPlaceholder [

	| xpath |
	xpath := '//input[contains(@placeholder,''{1}'')]' format: { labelOrPlaceholder }.
	^ driver findElementByXPath: xpath
]

{ #category : 'helpers' }
HeraWebAcceptanceTest >> press: aKey [

	| mapping |
	mapping := Dictionary
		with: 'enter' -> BPKeys return
		with: 'escape' -> BPKeys escape.
	driver getKeyboard sendKeys: (String with: (mapping at: aKey))
]

{ #category : 'private' }
HeraWebAcceptanceTest >> screenshotLocation [

	^ FileLocator imageDirectory
]

{ #category : 'steps' }
HeraWebAcceptanceTest >> stepIEnter: aString inField: labelOrPlaceholder [

	<heraStepDefinition: #(When match 'I enter {string} in the {string} field')>

	self enter: aString inFieldIdentifiedBy: labelOrPlaceholder
]

{ #category : 'steps' }
HeraWebAcceptanceTest >> stepIFillIn: labelOrPlaceholder with: aString [

	<heraStepDefinition: #(When match 'I fill in the {string} field with {string}')>

	self fillIn: aString inFieldIdentifiedBy: labelOrPlaceholder
]

{ #category : 'steps' }
HeraWebAcceptanceTest >> stepIOpenURL: url [

	<heraStepDefinition: #(When match 'I open {}')>

	driver get: url
]

{ #category : 'steps' }
HeraWebAcceptanceTest >> stepIPress: aKey [

	<heraStepDefinition: #(When match 'I press {}')>

	self press: aKey
]

{ #category : 'steps' }
HeraWebAcceptanceTest >> stepIPressButton: aButtonLabel [

	<heraStepDefinition: #(When match 'I press the {string} button')>

	self clickButtonLabeled: aButtonLabel
]

{ #category : 'steps' }
HeraWebAcceptanceTest >> stepISeeAPageWithH1: h1String [

	<heraStepDefinition: #(Then match 'I see a page with main header {string}')>

	self assert: (driver findElementByCSSSelector: 'h1') getText equals: h1String
]

{ #category : 'steps' }
HeraWebAcceptanceTest >> stepITakeAScreenshot [

	<heraStepDefinition: #(When 'I take a screenshot')>

	self takeScreenshot
]

{ #category : 'steps' }
HeraWebAcceptanceTest >> stepTheCurrentURLIs: url [

	<heraStepDefinition: #(Then match 'the current URL is {}')>

	self
		waitUntil: [ driver getCurrentURL = url ]
		ifTimeout: [ self signalFailure: ('Expected URL is {1}, but after a timeout, the URL is {2}' format: { url . driver getCurrentURL }) ]
]

{ #category : 'helpers' }
HeraWebAcceptanceTest >> takeScreenshot [

	| now filename file |
	now := DateAndTime now.
	filename := 'Screenshot {1} at {2}.png' format: {
		now asDate yyyymmdd .
		now asTime print24 copyReplaceAll: ':' with: '.' }.
	file := (self screenshotLocation / filename) asFileReference.
	file ensureDelete.
	file binaryWriteStreamDo: [ :str | str nextPutAll: driver getScreenshotAsByteArray ].
	^ file fullName
]

{ #category : 'helpers' }
HeraWebAcceptanceTest >> waitUntil: aCondition ifTimeout: timeoutBlock [
	"Adapted copy of Parasol's BPWebDriverTestCase>>#waitUntil:ifTimeout:"

	^ self waitUntil: aCondition ifTimeout: timeoutBlock times100MsToWait: 20
]

{ #category : 'helpers' }
HeraWebAcceptanceTest >> waitUntil: aCondition ifTimeout: timeoutBlock times100MsToWait: times [
	"Copied from Parasol's BPWebDriverTestCase>>#waitUntil:ifTimeout:times100MsToWait:"

	| delay100ms |
	delay100ms := Delay forMilliseconds: 100.
	times timesRepeat: [ aCondition value ifTrue: [ ^ true ] ifFalse: [ delay100ms wait ] ].
	^ timeoutBlock value
]
