function dispatcher () {
    this.allComponents;
    this.setTop = function (top) {
	this.allComponents = listComponentsRecursively (top);
    };
    this.run = function () {
	let again = true;
	while (again) {
	    again = false;
	    this.allComponents ( component => {
		if (component.ready () && !component.busy ()) {
		    again = true;
		    let msg = component.popInput ();
		    component.react (msg);
		    this.deliverOutputs (component);
		}
	    });
    };
}


function maybeDeliver (connection, sendingMessage) {
    /*
      connections are:
	{ 
	    name: "x1", 
	    sender: "./i/1"
	    receiver: "./c/hwhello/i/1"
	}
      if message.tag matches sender then
          create a new message with a new tag (given by .receiver field)
          if receiver.namespace is input then
            push new message onto input queue of receiver
          elseif receiver.namespace is ouput then
            send (receiver.component, receiver.tag, data)
          else panic

      end if            
    */
    if (connection.senderMatches (sendingMessage)) {
	let data = sendingMessage.data;
	let newMessage = new message (connection.receiver, data);
	if isInput (connection.receiver) {
	    this.inputQueue.enqueue (newMessage);
	} else if isOutput (connection.receiver) {
	    this.send (newMessage);
	} else {
	    panic ();
	}
    }
}
    
