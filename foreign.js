'use strict';
// empty

function initialize (name) {
    scopeAdd ('name', name);
    scopeAdd ('counter', 0);
}

function gen () {
    var i = scopeGet ("counter");
    scopeModify ("counter", i + 1);
    return i.toString ();
}

function newObject () {
    let name = scopeGet ('name');
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

// function editSlashes (s) {
//     return s.replace(/\//g,'_');
// }

// function pushNewObject () {
//     let parent = scopeGet ('object');
//     let prefix = scopeGet ('prefix');
//     let newID = prefix + "_" + gen ();
//     scopeAdd ('parent', parent);
//     scopeAdd ('object', newID);
// }


// function id () {
//     return scopeGet ('object');
// }

// function parent () {
//     return scopeGet ('parent');
// }

// function initialize (name) {
//     scopeAdd ('prefix', name);
//     scopeAdd ('counter', 0);
//     let newID = name + "_" + gen ();
//     scopeAdd ('parent', "id0");
//     scopeAdd ('object', newID);
// }

// function arrowid () {
//     return scopeGet ('object') + "_a";
// }

