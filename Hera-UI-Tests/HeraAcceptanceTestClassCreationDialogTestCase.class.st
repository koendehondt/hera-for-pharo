Class {
	#name : 'HeraAcceptanceTestClassCreationDialogTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-UI-Tests-Feature Browser',
	#package : 'Hera-UI-Tests',
	#tag : 'Feature Browser'
}

{ #category : 'running' }
HeraAcceptanceTestClassCreationDialogTestCase >> describedClass [

	^ HeraAcceptanceTestClassCreationDialog
]

{ #category : 'helpers' }
HeraAcceptanceTestClassCreationDialogTestCase >> openAndDo: aBlock [

	| dialogPresenter |
	SpWindowSimulateOpenModal 
		value: [ :aDialogPresenter | aBlock value ]
		during: [ dialogPresenter := subject openModal].
	^ dialogPresenter
]

{ #category : 'tests' }
HeraAcceptanceTestClassCreationDialogTestCase >> testExistingClassName [

	| dialogPresenter |
	dialogPresenter := self openAndDo: [
		subject
			enterClassName: 'Object';
			clickCancelButton ].
	self assert: dialogPresenter isCancelled.
	self assert: subject messageText equals: 'That class name is already taken. Please choose another name.'.
	self assert: subject hasDisabledOkButton.
	self assert: subject hasEnabledCancelButton
]

{ #category : 'tests' }
HeraAcceptanceTestClassCreationDialogTestCase >> testInvalidClassName [

	| dialogPresenter |
	dialogPresenter := self openAndDo: [
		subject
			enterClassName: 'testClassName';
			clickCancelButton ].
	self assert: dialogPresenter isCancelled.
	self assert: subject messageText equals: 'Please enter a valid class name.'.
	self assert: subject hasDisabledOkButton.
	self assert: subject hasEnabledCancelButton
]

{ #category : 'tests' }
HeraAcceptanceTestClassCreationDialogTestCase >> testMissingClassName [

	| dialogPresenter |
	dialogPresenter := self openAndDo: [
		subject
			enterClassName: '';
			clickCancelButton ].
	self assert: dialogPresenter isCancelled.
	self assert: subject messageText equals: 'Please enter a name for the acceptance class.'.
	self assert: subject hasDisabledOkButton.
	self assert: subject hasEnabledCancelButton
]

{ #category : 'tests' }
HeraAcceptanceTestClassCreationDialogTestCase >> testMissingPackage [

	| dialogPresenter |
	dialogPresenter := self openAndDo: [
		subject
			enterClassName: 'TestClassName';
			clickCancelButton ].
	self assert: dialogPresenter isCancelled.
	self assert: subject messageText equals: 'Please select a package.'.
	self assert: subject hasDisabledOkButton.
	self assert: subject hasEnabledCancelButton
]

{ #category : 'tests' }
HeraAcceptanceTestClassCreationDialogTestCase >> testResultWithNonDefaultSuperclass [

	| classCreator dialogPresenter |
	dialogPresenter := self openAndDo: [
		subject
			enterClassName: 'TestClassName';
			selectSuperclass: HeraWebAcceptanceTest;
			selectPackageNamed: 'Hera';
			selectTagNamed: 'AST';
			clickOkButton ].
	self assert: dialogPresenter isOk.
	self assert: subject messageText equals: ''.
	self assert: subject hasEnabledOkButton.
	self assert: subject hasEnabledCancelButton.
	classCreator := subject classCreator.
	self assert: classCreator targetClassName equals: 'TestClassName'.
	self assert: classCreator targetPackage name equals: 'Hera'.
	self assert: classCreator targetSuperclass equals: HeraWebAcceptanceTest.
	self assert: classCreator targetTag name equals: 'AST'
]

{ #category : 'tests' }
HeraAcceptanceTestClassCreationDialogTestCase >> testResultWithTag [

	| classCreator dialogPresenter |
	dialogPresenter := self openAndDo: [
		subject
			enterClassName: 'TestClassName';
			selectPackageNamed: 'Hera';
			selectTagNamed: 'AST';
			clickOkButton ].
	self assert: dialogPresenter isOk.
	self assert: subject messageText equals: ''.
	self assert: subject hasEnabledOkButton.
	self assert: subject hasEnabledCancelButton.
	classCreator := subject classCreator.
	self assert: classCreator targetClassName equals: 'TestClassName'.
	self assert: classCreator targetPackage name equals: 'Hera'.
	self assert: classCreator targetSuperclass equals: HeraSpecAcceptanceTest.
	self assert: classCreator targetTag name equals: 'AST'
]

{ #category : 'tests' }
HeraAcceptanceTestClassCreationDialogTestCase >> testResultWithoutTag [

	| classCreator dialogPresenter |
	dialogPresenter := self openAndDo: [
		subject
			enterClassName: 'TestClassName';
			selectPackageNamed: 'Hera';
			clickOkButton ].
	self assert: dialogPresenter isOk.
	self assert: subject messageText equals: ''.
	self assert: subject hasEnabledOkButton.
	self assert: subject hasEnabledCancelButton.
	classCreator := subject classCreator.
	self assert: classCreator targetClassName equals: 'TestClassName'.
	self assert: classCreator targetPackage name equals: 'Hera'.
	self assert: classCreator targetSuperclass equals: HeraSpecAcceptanceTest.
	self assert: classCreator targetTag isNil
]
