function define_keys(map, dict) {
    for (var key in dict)
        define_key(map, key, dict[key])
}

function dictMap(fn, dict) {
    for (var key in dict)
        fn(key, dict[key])
}

function define_webjumps(dict) {
    dictMap(define_webjump, dict)
}

function define_opensearch_webjumps(dict) {
    dictMap(define_opensearch_webjump, dict)
}

function session_prefs(dict) {
    dictMap(session_pref, dict)
}
function clear_prefs() {
    for (var i = arguments.length; --i > -2; )
    {
        try { clear_pref(arguments[i]) } catch (e) {}
        try { clear_default_pref(arguments[i]) } catch (e) {}
    }
}

function enable_javascript() {
    session_prefs({"javascript.enabled": true})
}

function disable_javascript() {
    session_prefs({"javascript.enabled": false})
}

interactive("enable-javascript",
            "Enable JavaScript.",
            function (I) {
                enable_javascript()
            })
interactive("disable-javascript",
            "Disable JavaScript.",
            function (I) {
                disable_javascript()
            })

function enable_anon(proxyport) {
    if (proxyport == undefined)
        proxyport = 0
    disable_javascript()
    session_prefs({
        "network.proxy.type": (proxyport > 0 ? 1 : 0)
        ,"network.proxy.http": "127.0.0.1"
        ,"network.proxy.http_port": proxyport
        ,"network.proxy.ftp": "127.0.0.1"
        ,"network.proxy.ftp_port": proxyport
        ,"network.proxy.ssl": "127.0.0.1"
        ,"network.proxy.ssl_port": proxyport
        ,"network.http.sendRefererHeader": 1
        ,"network.http.sendSecureXSiteReferrer": false
        ,"network.security.ports.banned": "8123,8118,9050,9051"
    })
}

function disable_anon() {
    enable_javascript()
    session_prefs({
        "network.proxy.type": 0
        ,"network.http.sendRefererHeader": 2
        ,"network.http.sendSecureXSiteReferrer": true
        ,"network.security.ports.banned": ""
    })
}

function enable_many_connections() {
    session_prefs({
        "network.http.max-connections-per-server": 100
        ,"network.http.max-persistent-connections-per-proxy": 100
        ,"network.http.max-persistent-connections-per-server": 100
    })
}

function disable_many_connections() {
    session_prefs({
        "network.http.max-connections-per-server": 15
        ,"network.http.max-persistent-connections-per-proxy": 16
        ,"network.http.max-persistent-connections-per-server": 6
    })
}

function enable_tor() {
    enable_anon(8123)
}

function disable_tor() {
    disable_anon()
}

interactive("enable-tor",
            "Enable Tor.",
            function (I) { enable_tor() })
interactive("disable-tor",
            "Disable Tor.",
            function (I) { disable_tor() })

function enable_i2p() {
    enable_anon(4444)
    enable_many_connections()
}

function disable_i2p() {
    disable_anon()
    disable_many_connections()
}

interactive("enable-i2p",
            "Enable i2p.",
            function (I) { enable_i2p() })
interactive("disable-i2p",
            "Disable i2p.",
            function (I) { disable_i2p() })

function enable_freenet() {
    enable_anon()
    enable_many_connections()
}

function disable_freenet() {
    disable_anon()
    disable_many_connections()
}

interactive("enable-freenet",
            "Enable Freenet.",
            function (I) { enable_freenet() })
interactive("disable-freenet",
            "Disable Freenet.",
            function (I) { disable_freenet() })

function router_authenticate() {
    load_url_in_current_buffer(
        "javascript:"
            + "document.getElementById('loginUsername').value = 'admin';"
            + "document.getElementById('loginPassword').value ='"
            + router_password + "';"
            + "document.getElementsByName('login')[0].submit();")
}

interactive("router-authenticate",
            "Authenticate on Speedport W 724V login page.",
            function (I) { router_authenticate() })

function clear_4chan_cookies() {
    var cookies = cookie_manager.getCookiesFromHost("4chan.org");
    while (cookies.hasMoreElements()) {
        var cookie = cookies.getNext();
        if (cookie instanceof Components.interfaces.nsICookie) {
            cookie_manager.remove(cookie.host, cookie.name, cookie.path,
                                  false, null);
        }
    }
}

interactive("clear-4chan-cookies",
            "Clear cookies from 4chan.",
            function (I) { clear_4chan_cookies();
                         })

provide("taylan-lib")
