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

function newField () {
    let ty = scopeGet ('type');
    let f = {kind: "field", name: "", owner: ty.name, tydesc: {collection: "_flat_", base: ""}};
    scopeAdd ('field', f);
    let typeTable = scopeGet ('typeTable');
    typeTable.push (f);
    return "";
}

function setFieldName (n) {
    let f = scopeGet ('field');
    f.name = n;
}

function setFieldCollection (c) {
    let f = scopeGet ('field');
    f.tydesc.collection = c;
}

function setFieldBase (b) {
    let f = scopeGet ('field');
    f.tydesc.base = b;
}

function setFieldInclude (n) {
    let f = scopeGet ('field');
    f.include = n;
}

