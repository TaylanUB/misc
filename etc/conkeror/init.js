var conkeror_config_dir = getenv("CONKEROR_CONFIG_DIR")

cwd = make_file(getenv("HOME") + "/tmp")

load_paths.push("file://"+conkeror_config_dir)

require("secrets-taylan")
require("taylan-lib")

session_prefs({
    "browser.enable_automatic_image_resizing": true
    ,"browser.formfill.enable": false
    ,"signon.rememberSignons": false
    ,"general.smoothScroll": false
    ,"general.useragent.compatMode.firefox": true
    ,"network.http.sendRefererHeader": 2
    ,"network.cookie.cookieBehavior": 1
    ,"geo.enabled": false
    ,"layout.spellcheckDefault": 1
    ,"intl.accept_languages": "en-us,en;q=0.5"
    ,"browser.cache.disk.enable": false
    // ,"image.high_quality_downscaling.enabled": false
    // ,"gfx.color_management.mode": 0
    ,"media.peerconnection.video.h264_enabled": true
    // ,"privacy.donottrackheader.enabled": true
    ,"general.useragent.override":
    "Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101 Firefox/45.0"
})

url_remoting_fn = load_url_in_new_buffer
download_buffer_automatic_open_target = OPEN_NEW_BUFFER

require("eye-guide")

require("webjumps-taylan")
require("redirect-taylan")
require("history-taylan")
require("keymap-taylan")
require("restore-buffer")
