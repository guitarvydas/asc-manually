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

function newName (_namespace, _componentPath, _componentNamespace, _basename) {
    let namespace = _namespace._glue ();
    let componentPath = "";
    let componentNamespace = "";
    let basename = _basename._glue ();
    let newID = scopeGet ('rootname') + "_" + gen ();
    if ("" !== _componentPath) {componentPath = _componentPath._glue () };
    if ("" !== _componentNamespace) { componentNamespace = _componentNamespace._glue () };
    scopeAdd ('name', newID);
    scopeAdd ('namespace', namespace);
    scopeAdd ('componentPath', componentPath);
    scopeAdd ('componentNamespace' , componentNamespace);
    scopeAdd ('basename', basename);
}

function name () { return scopeGet ('name') ; }
function componentPath () { return scopeGet ('componentPath') ; }
function componentNamespace () { return scopeGet ('componentNamespace') ; }
function namespace () { return scopeGet ('namespace') ; }
function basename () { return scopeGet ('basename') ; }

function emit (s) { console.log (s); }
