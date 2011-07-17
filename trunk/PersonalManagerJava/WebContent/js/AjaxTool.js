function readRemoteUrl(url, handler, targetId, params, HttpMethod, headers)
{
    if (!HttpMethod) {
        HttpMethod = "GET";
    }
 /*   if(url.indexOf('?')>=0){
    	url=url+"&reformat=ajax";
    }else{
    	url=url+"?reformat=ajax";
    }*/
    var req = initXMLHTTPRequest();
    if (req) {
        function onReadyState()
        {
            var ready = req.readyState;
            var data = null;
            if (ready == 4) {                                                        //ready
                data = req.responseText;
                handler(data);
            }
            else {
                data = "Loading...";
                if (targetId) {
                    document.getElementById(targetId).innerHTML = data;
                }
            }
        }

        req.onreadystatechange = onReadyState;
        req.open(HttpMethod, url, true);
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.setRequestHeader("If-Modified-Since", "0");
        req.setRequestHeader("Cache-Control", "no-cache");
        
        if (headers != null) {
            for (var p in headers) {
                req.setRequestHeader(p, headers[p]);
            }
        }
        req.send(params);
    }
}

//Init XML Http Request
function initXMLHTTPRequest()
{
    var xRequest = null;
    if (window.XMLHttpRequest) {
        xRequest = new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {
        xRequest = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return xRequest;
}
