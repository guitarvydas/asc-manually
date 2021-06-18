function niy (s) {
    throw s;
}

function initializeTypeTable () {
    scopeAdd ('typeTable', []);
}

function getTypeTable () {
    let typeTable = scopeGet ('typeTable');
    //typeTable.forEach (table => console.log (JSON.stringify(table)));
    return typeTable;
}

function newType (_id) {
    let id = _id._glue ();
    let ty = {kind: "type", name: id};
    scopeAdd ('type', ty);
    let typeTable = scopeGet ('typeTable');
    typeTable.push (ty);
    return "";
}

function typeName () {
    let ty = scopeGet ('type');
    return ty.name;
}

function setTypeDescriptor (collection, base) {
    let ty = scopeGet('type');
    process.stderr.write("setTypeDesc " + ty.name + " " + collection + " " + base);
    ty.desc = {collection: collection, base: base};
    return "";
}

function newField (fieldname, tyname) {
    let ty = scopeGet ('type');
    let f = {kind: "field", name: fieldname, owner: ty.name, desc: {collection:"",base: tyname}};
    scopeAdd ('field', f);
    let typeTable = scopeGet ('typeTable');
    typeTable.push (f);
    return "";
}

function newInclude (name) {
    let ty = scopeGet ('type');
    let f = {kind: "includefields", name: name, owner: ty.name};
    scopeAdd ('field', f);
    let typeTable = scopeGet ('typeTable');
    typeTable.push (f);
    return "";
}


// npm install ohm-js
'use strict';

const grammar =
      `
ASCType {
   typedefinitions = typedef+
   typedef = equivalence | typedefinition
   
   equivalence = ident "=" ws* typeref
     typeref = elsewheretype | typedcollectiontyperef | genericcollectiontyperef | builtintyperef | identtyperef
       elsewheretype = "elsewhere" ws*
       typedcollectiontyperef = ident lbracket identOrBuiltin rbracket
       genericcollectiontyperef = lbracket identOrBuiltin rbracket
       builtintyperef = builtintype
       identtyperef = identtype

	 builtintype = anytype
	     anytype = "any" ws*
	 identtype = ident
	 identOrBuiltin = builtintype | identtype

   typedefinition = ident "{" ws* field+ "}" ws*

   field =   includeFields
           | unnamedField

   includeFields = "include" ws* ident ws*
   unnamedField = ident

   newline = "\\n"
   notNewline = ~newline any

   keyword = "any" | "elsewhere" | "include"

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
var _result = `${JSON.stringify (getTypeTable ())}`;
_ruleExit ("typedefinitions");
return _result;
},
typedef : function (_td,) {
_ruleEnter ("typedef");

var td = _td._glue ();
var _result = `${console.log(td)}`;
_ruleExit ("typedef");
return _result;
},
equivalence : function (_id,_k,_ws
,_tr,) {
_ruleEnter ("equivalence");
newType (_id) 
var id = _id._glue ();var k = _k._glue ();var ws = _ws._glue ().join ('');var tr = _tr._glue ();
var _result = `${typeName ()}`;
_ruleExit ("equivalence");
return _result;
},
typeref : function (_tr,) {
_ruleEnter ("typeref");

var tr = _tr._glue ();
var _result = ``;
_ruleExit ("typeref");
return _result;
},
elsewheretype : function (_k,_ws2
,) {
_ruleEnter ("elsewheretype");

var k = _k._glue ();var ws2 = _ws2._glue ().join ('');
var _result = `${setTypeDescriptor ("","?"), typeName ()}`;
_ruleExit ("elsewheretype");
return _result;
},
typedcollectiontyperef : function (_id1,_lb,_id2,_rb,) {
_ruleEnter ("typedcollectiontyperef");

var id1 = _id1._glue ();var lb = _lb._glue ();var id2 = _id2._glue ();var rb = _rb._glue ();
var _result = `${setTypeDescriptor (id1, id2)}`;
_ruleExit ("typedcollectiontyperef");
return _result;
},
genericcollectiontyperef : function (_lb,_id,_rb,) {
_ruleEnter ("genericcollectiontyperef");

var lb = _lb._glue ();var id = _id._glue ();var rb = _rb._glue ();
var _result = `${setTypeDescriptor ("*", id)}`;
_ruleExit ("genericcollectiontyperef");
return _result;
},
builtintyperef : function (_id,) {
_ruleEnter ("builtintyperef");

var id = _id._glue ();
var _result = `${setTypeDescriptor ("", id)}`;
_ruleExit ("builtintyperef");
return _result;
},
identtyperef : function (_id,) {
_ruleEnter ("identtyperef");

var id = _id._glue ();
var _result = `${setTypeDescriptor ("", id)}`;
_ruleExit ("identtyperef");
return _result;
},
builtintype : function (_id,) {
_ruleEnter ("builtintype");

var id = _id._glue ();
var _result = `${id}`;
_ruleExit ("builtintype");
return _result;
},
anytype : function (_k,_ws
,) {
_ruleEnter ("anytype");

var k = _k._glue ();var ws = _ws._glue ().join ('');
var _result = `?`;
_ruleExit ("anytype");
return _result;
},
identtype : function (_id,) {
_ruleEnter ("identtype");

var id = _id._glue ();
var _result = `${id}`;
_ruleExit ("identtype");
return _result;
},
identOrBuiltin : function (_id,) {
_ruleEnter ("identOrBuiltin");

var id = _id._glue ();
var _result = `${id}`;
_ruleExit ("identOrBuiltin");
return _result;
},
typedefinition : function (_id,_lb,_ws1
,_fields
,_rb,_ws2
,) {
_ruleEnter ("typedefinition");
newType (_id), setTypeDescriptor ("", ".")
var id = _id._glue ();var lb = _lb._glue ();var ws1 = _ws1._glue ().join ('');var fields = _fields._glue ().join ('');var rb = _rb._glue ();var ws2 = _ws2._glue ().join ('');
var _result = ``;
_ruleExit ("typedefinition");
return _result;
},
field : function (_f,) {
_ruleEnter ("field");

var f = _f._glue ();
var _result = `${f}`;
_ruleExit ("field");
return _result;
},
includeFields : function (_k,_ws1
,_id,_ws2
,) {
_ruleEnter ("includeFields");

var k = _k._glue ();var ws1 = _ws1._glue ().join ('');var id = _id._glue ();var ws2 = _ws2._glue ().join ('');
var _result = `${newInclude (id)}`;
_ruleExit ("includeFields");
return _result;
},
unnamedField : function (_id,) {
_ruleEnter ("unnamedField");

var id = _id._glue ();
var _result = `${newField (id, id)}`;
_ruleExit ("unnamedField");
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
var _result = `${c}`;
_ruleExit ("lbracket");
return _result;
},
rbracket : function (_c,_ws
,) {
_ruleEnter ("rbracket");

var c = _c._glue ();var ws = _ws._glue ().join ('');
var _result = `${c}`;
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
