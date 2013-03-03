function obj2str(obj) {
	var str = '';
    for (var p in obj) {
        if (obj.hasOwnProperty(p)) {
            str += p + '::' + obj[p] + '\n';
        }
    }
    return str;
}

// require sarissa.js
function xml2str(xml) {
	var xmlser = new XMLSerializer()
	return xmlser.serializeToString(xml);
}