function basename (relid_string) {
    return relid_string.replace (/\(relid \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\"\)/,"$3");
}

function has_simple_path (port) {
    let r = port.match (/\(relid "\." "." "[^"]+"\)/);
    return r.index === 0;
}

function choose_send (portA, portB) {
    if (has_simple_path (portA)) {
	return "send-downward";
    } else {
	return "send-upward";
    }
}

