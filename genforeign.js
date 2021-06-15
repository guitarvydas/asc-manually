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

