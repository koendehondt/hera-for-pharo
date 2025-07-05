Class {
	#name : 'HeraWorldMenu',
	#superclass : 'Object',
	#category : 'Hera-Menu',
	#package : 'Hera-Menu'
}

{ #category : 'world menu' }
HeraWorldMenu class >> menu00HeraOn: aBuilder [

	<worldMenu>
	(aBuilder item: #HeraMainMenu)
		parent: #Tools;
		label: 'Hera';
		icon: (Hera settings iconNamed: #crown);
		help: 'A Behaviour Driven Development framework';
		order: 500
]

{ #category : 'world menu' }
HeraWorldMenu class >> menu01OpenHeraFeatureBrowser: aBuilder [

	<worldMenu>
	(aBuilder item: #HeraOpenFeaturesBrowser)
		parent: #HeraMainMenu;
		order: 1;
		keyText: 'o, f';
		label: 'Open Hera Feature Browser';
		icon: (Hera settings iconNamed: #crown);
		action: [ HeraFeatureBrowser new open ]
]

{ #category : 'world menu' }
HeraWorldMenu class >> menu02BrowseSourcesOn: aBuilder [

	<worldMenu>
	(aBuilder item: #HeraBrowseSources)
		parent: #HeraMainMenu;
		order: 2;
		label: 'Browse Hera packages';
		icon: (Smalltalk ui icons iconNamed: #nautilus);
		action: [
			Smalltalk tools browser open packageView filterField setText:
					'Hera' ]
]

{ #category : 'world menu' }
HeraWorldMenu class >> menu03ReportBugOn: aBuilder [

	<worldMenu>
	(aBuilder item: #HeraReportBug)
		parent: #HeraMainMenu;
		order: 3;
		label: 'Report a bug';
		icon: (Smalltalk ui icons iconNamed: #smallDebug);
		action: [ WebBrowser openOn: Hera repositoryUrl , '/issues/new' ]
]

{ #category : 'see class side' }
HeraWorldMenu >> seeClassSide [
]
