Class {
	#name : 'HeraWorldMenu',
	#superclass : 'Object',
	#category : 'Hera-Menu',
	#package : 'Hera-Menu'
}

{ #category : 'menu' }
HeraWorldMenu class >> menu00HeraOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Toto)
		parent: #Tools;
		label: 'Hera';
		icon: (Hera settings iconNamed: #crown);
		help: 'A Behaviour Driven Development framework';
		order: 500
]

{ #category : 'world menu' }
HeraWorldMenu class >> menu01OpenHeraFeatureBrowser: aBuilder [
	<worldMenu>
	self haltOnce.
	(aBuilder item: #OpenHera)
		parent: #Hera;
		order: 1;
		keyText: 'o, f';
		label: HeraFeatureBrowser windowTitle;
		icon: HeraFeatureBrowser windowIcon;
		action: [ HeraFeatureBrowser new open ];
		withSeparatorAfter
]

{ #category : 'world menu' }
HeraWorldMenu class >> menu02BrowseSourcesOn: aBuilder [
	<worldMenu>

	(aBuilder item: #BrowseHera)
		parent: #Hera;
		order: 2;
		label: 'Browse Hera packages';
		icon: (Smalltalk ui icons iconNamed: #nautilus);
		action: [ Smalltalk tools browser open packageView filterField setText: 'Hera' ];
		withSeparatorAfter
]

{ #category : 'see class side' }
HeraWorldMenu >> seeClassSide [
]
