function component () {
    this.recursiveBusy = function () {
	var isBusy = false;
	this.components.forEach (child => {
	    isBusy = isBusy && child.busy ();
	});
	return isBusy;
    };
    this.ready = function ()  {
	return (this.inputQueue.length > 0);
    }
    this.initially = function () { throw "not instantiable" };
    this.react = function (message) { throw "not instantiable" };
    
}


function composite () {
    inherit from component;
    
