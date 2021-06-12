// red rect - sequential operation
/*
react (m) {
    switch m->tag
    {
	case (. i 1) : {
	    let result = greet (self, m);
	    send (this, {this, "o","1"}", result);
	}
    }
}
*/

function app () {
    this.initially () = function {};
    this.react = function (m) { return composite.sendinput (this, m); };
    this.inputs = [
	{component: ".", ns: "i", name: "in"}
    ];
    this.outputs = [
	{component: ".", ns: "o", name: "out"}
    ];
    this.components = [
	// name X inputs X outputs

	// "dead" code
	{component: ".", ns: "c", name: "inner"} , // name
	[{component: {component: ".", ns: "c", name: "inner"}, ns: "i", name: "a"} ], // inputs [name, ...]
	[{component: {component: ".", ns: "c", name: "inner"}, ns: "o", name: "b"} ], // outputs

	// merged-in component "hwsub"
	{component: ".", ns: "c", name: "hwsub"} , // name
	[{component: {component: ".", ns: "c", name: "hwsub"}, ns: "i", name: "x"} ], // inputs [name, ...]
	[{component: {component: ".", ns: "c", name: "hwsub"}, ns: "o", name: "b"} ], // outputs
    ];
    this.connections = [
	// connectorName X sender X receiver
	{
	    //## connector (app x appNx1) (app i in) ((app c hwsub) i x)
	    connectorName: {component: ".", ns: "x", name: "appNx1"},
	    sender: {component: ".", ns: "i", name: "in"},
	    receiver: {{component: ".", ns: "c", name: "hwsub"}, ns: "i", name: "x"}
	},
	{
	    //## connector (app x appNx1) ((app c hwsub) o y) (app o out)
	    connectorName: {component: ".", ns: "x", name: "appNx1"},
	    sender: {{component: ".", ns: "c", name: "hwsub"}, ns: "o", name: "y"}
	    receiver: {component: ".", ns: "o", name: "out"},
	}
    ];
}


