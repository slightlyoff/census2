(function(){
	var now = function(){
		return (new Date()).getTime();
	};

	var ticStack = [];

	timing = {
		_timings: {},
		_sizes: {},
		_totalTimeName: "total",
		_initStart: now(),
		_testName: (new dojo._Url(window.location)).path.split("/").pop(),
		setTestName: function(name){
			this._testName = name||this._testName;
		},
		setTime: function(name, time){
			return this._timings[name] = time;
		},
		tic: function(name){
			ticStack.push(name);
			this._timings[name] = now();
		},
		toc: function(name){
			var lname = ticStack.pop();
			if(!name){ 
				if(!lname){ return; }
				name = lname;
			}
			var start = this._timings[name];
			if(start){
				return this._timings[name] = (now() - start);
			}else{
				return this.tic(name);
			}
		},
		size: function(name, value){
			if(dojo.isString(value) || dojo.isArrayLike(value)){
				value = value.length;
			}
			this._sizes[name] = value;
		},
		report: function(){
			this.setTime(this._totalTimeName, (now()-this._initStart));
			var p = window.parent;
			if(p == window){
				console.debug("can't report to parent window!");
				// FIXME:
				//		log out timings and such to the console
				return;
			}
			
			// if we're the sub window, try to report up to the parent about
			// our results
			try{
				if(p.reportResults){
					p.reportResults(this._testName, dojo.delegate(this._timings, this._sizes));
				}
			}catch(e){
				console.error("could not report the results:", e);
			}
		}
	};
})();
