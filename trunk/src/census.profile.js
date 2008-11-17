dependencies = {
	//Strip all console.* calls except console.warn and console.error. This is basically a work-around
	//for trac issue: http://bugs.dojotoolkit.org/ticket/6849 where Safari 3's console.debug seems
	//to be flaky to set up (apparently fixed in a webkit nightly).
	//But in general for a build, console.warn/error should be the only things to survive anyway.
	stripConsole: "normal",

	layers: [
		{
			name: "../dijit/dijit.js",
			dependencies: [
				"dijit.dijit"
			]
		},
		/*
		{
			name: "../dijit/dijit-all.js",
			layerDependencies: [
				"../dijit/dijit.js"
			],
			dependencies: [
				"dijit.dijit-all"
			]
		},
		*/
		{
			name: "../dojo/cookie.js",
			dependencies: [
				"dojo.cookie"
			]
		},
		{
			name: "../dojox/grid/DataGrid.js",
			layerDependencies: [
				"../dijit/dijit.js",
			],
			dependencies: [
				"dojox.grid.DataGrid",
				"dojo.data.ItemFileReadStore",
			]
		},
		{
			name: "../dojox/charting/widget/Chart2D.js",
			layerDependencies: [
				"../dijit/dijit.js",
			],
			dependencies: [
				"dojox.charting.widget.Chart2D",
				"dojox.charting.widget.Sparkline",
				"dojox.charting.widget.Legend",
			]
		},
		{
			name: "../dojo/census.js",
			dependencies: [
				"dojox.gfx",
				"dijit.dijit",
				"dijit.layout.BorderContainer",
				// "dojox.grid.DataGrid",
				"dojox.charting.widget.Chart2D",
				"dojox.charting.widget.Sparkline",
				"dojox.charting.widget.Legend",
				// "dojox.data.XmlStore",
				// "dojox.data.QueryReadStore",
				"dijit.form.CheckBox",
				"dijit.form.Button",
				"dojox.widget.Iterator",
				"dijit.layout.TabContainer",
				"dijit.layout.ContentPane",
				"dojox.lang.functional.sequence",
				"dojox.charting.Theme",
			]
		},
	],

	prefixes: [
		[ "dijit", "../dijit" ],
		[ "dojox", "../dojox" ]
	]
}
