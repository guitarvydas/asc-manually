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


