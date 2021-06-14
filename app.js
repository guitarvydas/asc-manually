function app () {
    this.initially = function () { 
	return instantiateCompositeTemplate (this);
    };
    this.react = function (m) {
	this.deliverCompositeInput (m);
    };
    this.send = compositeSend;
    this.inject = compositeInject;
    this.kindname = "app";
    this.busy = recursiveBusy;
    this.inputs = ["in"];
    this.outputs = ["out"];
    this.n = new namespace ();
    this.components = [
	{
	    instancename: "hwsub",
	    kind: "hwsub",
	    inputs: [],
	    outputs: []
	}
    ];
    this.connections = [
	{ 
	    name: "x1", 
	    sender: {component: ".", namespace: "i", tag: "in"},
	    receiver: {component: "./c/hwsub", namespace: "i", tag: "xx"}
	},
	{ 
	    name: "x2", 
	    sender: {component: "./c/hwsub", namespace: "o", tag: "yy"},
	    receiver: {component: ".", namespace: "o", tag: "out"}
	}
    ];
}

function hwsub () {
    this.initially = function () { 
	return instantiateCompositeTemplate (this);
    };
    this.react = function (m) {
	this.deliverCompositeInput (m);
    };
    this.send = compositeSend;
    this.inject = compositeInject;
    this.kindname = "hwsub";
    this.busy = recursiveBusy;
    this.inputs = ["xx"];
    this.outputs = ["yy"];
    this.components = [
	{
	    instancename: "hwhello",
	    kind: "hwhello",
	    inputs: ["1"],
	    outputs: ["1"]
	}
    ];
    this.connections = [
	{ 
	    name: "x1", 
	    sender: {component: ".", namespace: "i", tag: "1"},
	    receiver: {component: "./c/hwhello", namespace: "i", tag: "1"}
	},
	{ 
	    name: "x2", 
	    sender: {component: "./c/hwhello", namespace: "o", tag: "1"},
	    receiver: {component: ".", namespace: "o", tag: "1"}
	}
    ];
}

function hwhello () {
    this.initially = function () { 
	return this;
    };
    this.react = function (m) {
	let result = greet (this, m);
	this.send ({ component: ".", namespace: "o", tag: "1" }, result);
    };
    this.send = compositeInput;
    this.kindname = "hwhello";
    this.inputs = ["1"];
    this.outputs = ["1"];
    this.busy = false;
}


var top = new app ().initially ();
top.inject (
    {component: ".", namespace: "i", tag: "in"}, 
    true
);
var disp = new dispatcher ();
disp.run (top);

