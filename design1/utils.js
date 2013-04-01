// requires jQuery
function strescape(str) {
	return $('<div/>').text(str).html();
}

function obj2str(obj) {
	var str = '';
    for (var p in obj) {
        if (obj.hasOwnProperty(p)) {
            str += p + '::' + obj[p] + '\n';
        }
    }
    return strescape(str);
}

// requires Sarissa
function xml2str(xml) {
	var xmlser = new XMLSerializer()
	return strescape(xmlser.serializeToString(xml));
}

// requires Sarissa
function str2xml(str) {
	var dompar = new DOMParser();
	return dompar.parseFromString(str, "text/xml");
}
