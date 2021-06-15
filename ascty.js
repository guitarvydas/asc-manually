function niy (s) {
    throw s;
}

function initializeTypeTable () {
    scopeAdd ('typeTable', []);
}

function displayTypeTable () {
    let typeTable = scopeGet ('typeTable');
    typeTable.forEach (table => console.log (JSON.stringify(table)));
}

function makeElsewhereType (id) {
    let typeTable = scopeGet ('typeTable');
    typeTable.push ({ typename: id, type: "", collection: "", elsewhere: true });
    scopeModify ('typeTable', typeTable);
    return "";
}

function makeEquivalentType (id, ty) {
    let typeTable = scopeGet ('typeTable');
    typeTable.push ({ typename: id, type: ty, collection: "", elsewhere: false});
    scopeModify ('typeTable', typeTable);
    return "";
}

function makeCollectionType (id, ty) {
    return makeNamedCollectionType (id, ty, "%list");
}

function makeNamedCollectionType (id, ty, collectorType) {
    let typeTable = scopeGet ('typeTable');
    typeTable.push ({ typename: id, type: ty, collection: collectorType, elsewhere: false});
    scopeModify ('typeTable', typeTable);
    return "";
}

// npm install ohm-js
'use strict';

const grammar =
      `
ASCType {
   typedefinitions = typedef+
   typedef = equivalence | typedefinition
   
   equivalence = elsewheretype | typecollection | basicequivalence
   elsewheretype = ident "=" ws* "elsewhere" ws*
   basicequivalence = ident "=" ws* identOrBuiltin ws*
   typecollection = ident "=" ws* lbracket identOrBuiltin rbracket

   typedefinition = ident "{" ws* typedefinitionbody+ "}" ws*
   typedefinitionbody =   collectionDefinition
			| includeFields
                        | listDefinition
                        | field
                        | basicDefinition
                        | other
   basicDefinition = ident ":" ws* ident
   collectionDefinition = ident ":" ws* lbracket ident rbracket
   listDefinition = ident ":" ws* ident lbracket ident rbracket


   includeFields = "include" ws* ident ws*
   field =   ident ":" ident -- named
           | ident ~":" -- unnamed


   identOrBuiltin = builtin | ident
   builtin = anytype
   anytype = "any" ws*
   
   other = notInstantiable | methodDef
   notInstantiable = "not" ws* "instantiable" ws*
   methodDef = "method" ws* toEol ws*

   toEol = notNewline+ newline
   newline = "\\n"
   notNewline = ~newline any

   keyword = "not" | "instantiable" | "method" | "any" | "elsewhere"

   ident = ~keyword id ws*
   id = idFirst idRest*
   idFirst = "A" .. "Z" | "a" .. "z"
   idRest = "_" | "0" .. "9" | idFirst

   ws = " " | newline

   lbracket = "[" ws*
   rbracket = "]" ws*
   
}


   

`;


function ohm_parse (grammar, text) {
    var ohm = require ('ohm-js');
    var parser = ohm.grammar (grammar);
    var cst = parser.match (text);
    if (cst.succeeded ()) {
	return { succeeded: true, message: "OK", parser: parser, cst: cst };
    } else {
	//console.log (parser.trace (text).toString ());
	//throw "glue: Ohm matching failed";
        
        return { succeeded: false, message: cst.message, parser: parser, cst: cst };
    }
}

function getNamedFile (fname) {
    var fs = require ('fs');
    if (fname === undefined || fname === null || fname === "-") {
	return fs.readFileSync (0, 'utf-8');
    } else {
	return fs.readFileSync (fname, 'utf-8');
    }	
}
'use strict'

var _scope;

function scopeStack () {
    this._stack = [];
    this.pushNew = function () {this._stack.push ([])};
    this.pop = function () {this._stack.pop ()};
    this._topIndex = function () {return this._stack.length - 1;};
    this._top = function () { return this._stack[this._topIndex ()]; };
    this.scopeAdd = function (key, val) {
	this._top ().push ({key: key, val: val});
    };
    this._lookup = function (key, a) { 
      return a.find (obj => {return obj && obj.key && (obj.key == key)}); };
    this.scopeGet = function (key) {
	var i = this._topIndex ();
	for (; i >= 0 ; i -= 1) {
	    var obj = this._lookup (key, this._stack [i]);
	    if (obj) {
		return obj.val;
	    };
	};
        process.stderr.write ('*** scopeGet error key=' + key + ' ***' + "\n");
	process.stderr.write (this._stack.toString () + "\n");
	process.stderr.write (key.toString () + "\n");
	process.exit (1);
    };
    this.scopeModify = function (key, val) {
	var i = this._topIndex ();
	for (; i >= 0 ; i -= 1) {
	    var obj = this._lookup (key, this._stack [i]);
	    if (obj) {
              obj.val = val;
              return val;
	    };
	};
        process.stderr.write ('*** scopeModify error key=' + key + ' ***' + "\n");
	process.stderr.write (this._stack.toString () + "\n");
	process.stderr.write (key.toString () + "\n");
	process.exit (1);
    };
}

function scopeAdd (key, val) {
  return _scope.scopeAdd (key, val);
}

function scopeModify (key, val) {
  return _scope.scopeModify (key, val);
}

function scopeGet (key, val) {
  return _scope.scopeGet (key, val);
}

function _ruleInit () {
    _scope = new scopeStack ();
}

function _ruleEnter (ruleName) {
    _scope.pushNew ();
}

function _ruleExit (ruleName) {
    _scope.pop ();
}

_ruleInit ();
function addSemantics (sem) {
  sem.addOperation (
'_glue',
{
typedefinitions : function (_tds
,) {
_ruleEnter ("typedefinitions");
initializeTypeTable ();
var tds = _tds._glue ().join ('');
var _result = `${displayTypeTable ()}`;
_ruleExit ("typedefinitions");
return _result;
},
typedef : function (_td,) {
_ruleEnter ("typedef");

var td = _td._glue ();
var _result = `${td}`;
_ruleExit ("typedef");
return _result;
},
equivalence : function (_ty,) {
_ruleEnter ("equivalence");

var ty = _ty._glue ();
var _result = ``;
_ruleExit ("equivalence");
return _result;
},
elsewheretype : function (_id,_eq,_ws1
,_k,_ws2
,) {
_ruleEnter ("elsewheretype");

var id = _id._glue ();var eq = _eq._glue ();var ws1 = _ws1._glue ().join ('');var k = _k._glue ();var ws2 = _ws2._glue ().join ('');
var _result = `${makeElsewhereType (id)}`;
_ruleExit ("elsewheretype");
return _result;
},
basicequivalence : function (_id,_eq,_ws1
,_b,_ws2
,) {
_ruleEnter ("basicequivalence");

var id = _id._glue ();var eq = _eq._glue ();var ws1 = _ws1._glue ().join ('');var b = _b._glue ();var ws2 = _ws2._glue ().join ('');
var _result = `${makeEquivalentType (id, b)}`;
_ruleExit ("basicequivalence");
return _result;
},
typecollection : function (_id,_eq,_ws
,_lb,_b,_rb,) {
_ruleEnter ("typecollection");

var id = _id._glue ();var eq = _eq._glue ();var ws = _ws._glue ().join ('');var lb = _lb._glue ();var b = _b._glue ();var rb = _rb._glue ();
var _result = `${makeCollectionType(id, b)}`;
_ruleExit ("typecollection");
return _result;
},
typedefinition : function (_id,_lb,_ws1
,_body
,_rb,_ws2
,) {
_ruleEnter ("typedefinition");

var id = _id._glue ();var lb = _lb._glue ();var ws1 = _ws1._glue ().join ('');var body = _body._glue ().join ('');var rb = _rb._glue ();var ws2 = _ws2._glue ().join ('');
var _result = ``;
_ruleExit ("typedefinition");
return _result;
},
typedefinitionbody : function (_b,) {
_ruleEnter ("typedefinitionbody");

var b = _b._glue ();
var _result = ``;
_ruleExit ("typedefinitionbody");
return _result;
},
basicDefinition : function (_id1,_k,_ws
,_id2,) {
_ruleEnter ("basicDefinition");

var id1 = _id1._glue ();var k = _k._glue ();var ws = _ws._glue ().join ('');var id2 = _id2._glue ();
var _result = `${makeEquivalentType (id1, id2)}`;
_ruleExit ("basicDefinition");
return _result;
},
collectionDefinition : function (_id1,_k,_ws
,_lb,_id2,_rb,) {
_ruleEnter ("collectionDefinition");

var id1 = _id1._glue ();var k = _k._glue ();var ws = _ws._glue ().join ('');var lb = _lb._glue ();var id2 = _id2._glue ();var rb = _rb._glue ();
var _result = `${makeCollectionType(id1, id2)}`;
_ruleExit ("collectionDefinition");
return _result;
},
listDefinition : function (_id1,_k,_ws
,_id2,_lb,_id3,_rb,) {
_ruleEnter ("listDefinition");

var id1 = _id1._glue ();var k = _k._glue ();var ws = _ws._glue ().join ('');var id2 = _id2._glue ();var lb = _lb._glue ();var id3 = _id3._glue ();var rb = _rb._glue ();
var _result = `${makeNamedCollectionType(id1, id2, id3)}`;
_ruleExit ("listDefinition");
return _result;
},
includeFields : function (_k,_ws1
,_id,_ws2
,) {
_ruleEnter ("includeFields");

var k = _k._glue ();var ws1 = _ws1._glue ().join ('');var id = _id._glue ();var ws2 = _ws2._glue ().join ('');
var _result = ``;
_ruleExit ("includeFields");
return _result;
},
field_named : function (_id1,_k,_id2,) {
_ruleEnter ("field_named");

var id1 = _id1._glue ();var k = _k._glue ();var id2 = _id2._glue ();
var _result = `${id1}${k}${id2}`;
_ruleExit ("field_named");
return _result;
},
field_unnamed : function (_id,) {
_ruleEnter ("field_unnamed");

var id = _id._glue ();
var _result = `${id}`;
_ruleExit ("field_unnamed");
return _result;
},
identOrBuiltin : function (_b,) {
_ruleEnter ("identOrBuiltin");

var b = _b._glue ();
var _result = `${b}`;
_ruleExit ("identOrBuiltin");
return _result;
},
builtin : function (_k,) {
_ruleEnter ("builtin");

var k = _k._glue ();
var _result = `${k}`;
_ruleExit ("builtin");
return _result;
},
anytype : function (_k,_ws
,) {
_ruleEnter ("anytype");

var k = _k._glue ();var ws = _ws._glue ().join ('');
var _result = `%any`;
_ruleExit ("anytype");
return _result;
},
other : function (_d,) {
_ruleEnter ("other");

var d = _d._glue ();
var _result = `${d}`;
_ruleExit ("other");
return _result;
},
notInstantiable : function (_k1,_ws1
,_k2,_ws2
,) {
_ruleEnter ("notInstantiable");

var k1 = _k1._glue ();var ws1 = _ws1._glue ().join ('');var k2 = _k2._glue ();var ws2 = _ws2._glue ().join ('');
var _result = ``;
_ruleExit ("notInstantiable");
return _result;
},
methodDef : function (_k,_ws1
,_cs,_ws2
,) {
_ruleEnter ("methodDef");

var k = _k._glue ();var ws1 = _ws1._glue ().join ('');var cs = _cs._glue ();var ws2 = _ws2._glue ().join ('');
var _result = `${niy("method")}`;
_ruleExit ("methodDef");
return _result;
},
toEol : function (_cs
,_nl,) {
_ruleEnter ("toEol");

var cs = _cs._glue ().join ('');var nl = _nl._glue ();
var _result = `${cs}${nl}`;
_ruleExit ("toEol");
return _result;
},
newline : function (_c,) {
_ruleEnter ("newline");

var c = _c._glue ();
var _result = `${c}`;
_ruleExit ("newline");
return _result;
},
notNewline : function (_c,) {
_ruleEnter ("notNewline");

var c = _c._glue ();
var _result = `${c}`;
_ruleExit ("notNewline");
return _result;
},
keyword : function (_k,) {
_ruleEnter ("keyword");

var k = _k._glue ();
var _result = `${k}`;
_ruleExit ("keyword");
return _result;
},
ident : function (_id,_ws
,) {
_ruleEnter ("ident");

var id = _id._glue ();var ws = _ws._glue ().join ('');
var _result = `${id}`;
_ruleExit ("ident");
return _result;
},
id : function (_c,_cs
,) {
_ruleEnter ("id");

var c = _c._glue ();var cs = _cs._glue ().join ('');
var _result = `${c}${cs}`;
_ruleExit ("id");
return _result;
},
idFirst : function (_c,) {
_ruleEnter ("idFirst");

var c = _c._glue ();
var _result = `${c}`;
_ruleExit ("idFirst");
return _result;
},
idRest : function (_c,) {
_ruleEnter ("idRest");

var c = _c._glue ();
var _result = `${c}`;
_ruleExit ("idRest");
return _result;
},
ws : function (_c,) {
_ruleEnter ("ws");

var c = _c._glue ();
var _result = `${c}`;
_ruleExit ("ws");
return _result;
},
lbracket : function (_c,_ws
,) {
_ruleEnter ("lbracket");

var c = _c._glue ();var ws = _ws._glue ().join ('');
var _result = `${c}${ws}`;
_ruleExit ("lbracket");
return _result;
},
rbracket : function (_c,_ws
,) {
_ruleEnter ("rbracket");

var c = _c._glue ();var ws = _ws._glue ().join ('');
var _result = `${c}${ws}`;
_ruleExit ("rbracket");
return _result;
},

_terminal: function () {return this.primitiveValue; }
});
}


function main () {
    // usage: node glue <file
    // grammar is inserted from grasem.ohm
    // test.grasem is read from stdin
    var text = getNamedFile ("-");
    var { succeeded, message, parser, cst } = ohm_parse (grammar, text);
    var sem = {};
    var outputString = "";
    if (cst.succeeded ()) {
	sem = parser.createSemantics ();
	addSemantics (sem);
	outputString = sem (cst)._glue ();
	return { succeeded: true, message: "OK", cst: cst, semantics: sem, resultString: outputString };
    } else {
	return { succeeded: false, message: message, cst: cst, semantics: sem, resultString: outputString };
    }
}


var { succeeded, message, cst, semantics, resultString } = main ();
if (succeeded) {
    console.log (resultString);
} else {
    process.stderr.write (`${message}\n`);
    return false;
}
