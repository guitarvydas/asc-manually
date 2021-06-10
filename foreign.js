'use strict';
// empty

function initialize (name) {
    scopeAdd ('rootname', name);
    scopeAdd ('counter', 0);
}

function gen () {
    var i = scopeGet ("counter");
    scopeModify ("counter", i + 1);
    return i.toString ();
}

function newObject () {
    let name = scopeGet ('rootname');
    let newID = name + "_" + gen ();
    scopeAdd ('object', newID);
    scopeAdd ('container', newID);
}

function pushContainer () {
    let obj = scopeGet ('object');
    scopeAdd ('container', obj);
}

function resetBlock () {
    scopeAdd ('block' , 0);
}

function convertIndentationToBlockNumber (octoString) {
    return octoString.length;
}

function asNumber (s) {
    return parseInt (s, 10);
}


function emitopenparen (block) {
    return emitOpen (block, "(");
}

function emitcloseparen (block) {
    return emitClose (block, ")");
}

function emitopenbrace (block) {
    return emitOpen (block, "{");
}

function emitclosebrace (block) {
    return emitClose (block, "}\n");
}

function emitOpen (block, c) {
    let prevblock = scopeGet ('block');
    let s = '';
    let b = asNumber (block);
    if (b > prevblock) {
	while (b > prevblock) {
	    s = s + c;
	    b -= 1;
	}
	return spaces (block) + s + '\n';
    } else {
	return '';
    }
    }

function emitClose (block, c) {
    let prevblock = scopeGet ('block');
    let s = '';
    let b = asNumber (block);
    if (b < prevblock) {
	while (b < prevblock) {
	    s = s + c;
	    b += 1;
	}
	return spaces (block) + s + '\n';
    } else {
	return '';
    }
}

function shiftblock (block) {
    scopeModify ('block', block);
    return "";
}

function spaces (n) {
    let s = '';
    while (n > 0) {
	s = s + ' ';
	n -= 1;
    }
    return s;
}

function newRootRelativeName (_namespace, _basename) {
    let namespace = _namespace._glue ();
    let basename = _basename._glue ();
    let nsdID = newNSD ("root", namespace);
    let nameID = newName(nsdID, basename);
    scopeAdd ('name', nameID);
}

function newComponentRelativeName (_componentName, _namespace, _basename) {
    let basename = _basename._glue ();
    let componentName = _componentName._glue ();
    let namespace = _namespace._glue ();

    let nsdID = newNSD ("root", "c", componentName);
    let nameID = newName (nsdID, componentName);
    let nsdID2 = newNSD (nameID, namespace);
    let nameID2 = newName (nsdID2, basename);
    scopeAdd ('name', nameID2);

    return nameID2;
}




function newName (nsdID, basename) {	
    let id = newNameDescriptorID ();
    emitFact (`${id} name nil`);
    emitFact (`${id} namestr "${basename}"`);
    emitFact (`${id} namespace ${nsdID}`);
    return id;
}

function newNSD (component, namespace) {
    let id = newNamespaceDescriptorID ();
    emitFact (`${id} namespacedescriptor nil`);
    emitFact (`${id} ns ${namespace}`);
    emitFact (`${id} component ${component}`);
    return id;
}



function newNameDescriptorID () {
    return "nd_" + gen ();
}

function newNamespaceDescriptorID () {
    return "nsd_" + gen ();
}

function name () { return scopeGet ('name') ; }

function emit (s) { console.log (s); }
function emitFact (s) { console.log (`FACT ${s}`); }
