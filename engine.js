/*
function dispatcher () {this.run = function (top) {};};
function instantiateCompositeTemplate () {};
function compositeSend (self, pin, message) {};
function compositeInject (self, pin, message) {};
function foreignSend (self, pin, message) {};
function compositeDeliverMessage (self, pin, message) {};
*/

function instantiateCompositeTemplate (self) {
    var instance = new runnable (self);
    self.components.forEach (c => {
	child = instantiateComponent (self, c);
	instance.children.push (child);
    });
    return instance;
}


function compositeInput (self, tag, data) {
    deliverInput (self, tag, data);
}

function compositeInject (self, tag, data) {
    // send in an input from the outside world
    // dispatcher needs to be notified
    send (self, tag, data);
    dispatcher.run ();
}

function send (self, msg) {
    self.ouputQueue = msg;
}

function foreignSend (self, msg) {
    send (self, msg);
}



function deliverCompositeInput (self, tag, mxxxxx) {
    // input to composite is delivered to children of composite
    self.connections.forEach (x => {
	x.maybeDeliver (self, tag, data);
    });
}

