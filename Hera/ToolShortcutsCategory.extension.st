Extension { #name : 'ToolShortcutsCategory' }

{ #category : '*Hera' }
ToolShortcutsCategory >> openHeraFeatureBrowser [

	<shortcut>
	^ KMKeymap
		  shortcut: $o meta , $f meta
		  action: [ HeraFeatureBrowser new open ]
]
