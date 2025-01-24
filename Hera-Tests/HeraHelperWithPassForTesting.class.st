Class {
	#name : 'HeraHelperWithPassForTesting',
	#superclass : 'HeraHelperForTesting',
	#instVars : [
		'seenTheHomePage',
		'givenFieldLabelArgument',
		'givenButtonLabelArgument'
	],
	#category : 'Hera-Tests-Support',
	#package : 'Hera-Tests',
	#tag : 'Support'
}

{ #category : 'test api' }
HeraHelperWithPassForTesting >> givenButtonLabelArgument [

	^ givenButtonLabelArgument
]

{ #category : 'test api' }
HeraHelperWithPassForTesting >> givenFieldLabelArgument [

	^ givenFieldLabelArgument
]

{ #category : 'test api' }
HeraHelperWithPassForTesting >> seenTheHomePage [

	^ seenTheHomePage
]

{ #category : 'steps' }
HeraHelperWithPassForTesting >> stepIFillInTheFieldLabeled: fieldLabel [

	<heraStepDefinition: #(When match 'I fill in the field labeled {string}')>

	givenFieldLabelArgument := fieldLabel
]

{ #category : 'steps' }
HeraHelperWithPassForTesting >> stepIPressTheButtonLabeled: buttonLabel [

	<heraStepDefinition: #(When regex 'I press the button labeled "([^"]+)"')>

	givenButtonLabelArgument := buttonLabel
]

{ #category : 'steps' }
HeraHelperWithPassForTesting >> stepISeeTheHomePage [

	<heraStepDefinition: #(Then 'I see the home page')>

	seenTheHomePage := true
]
