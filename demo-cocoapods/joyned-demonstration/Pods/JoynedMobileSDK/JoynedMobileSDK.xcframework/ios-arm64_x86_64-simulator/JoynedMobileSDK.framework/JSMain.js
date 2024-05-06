/* ========================================================================== */
/*  SDK mobile JS content, JSMain.js                                          */
/* ========================================================================== */
function main_load() {
    
    let payload = {
        "type" : "action_page_load"
    };
    window.webkit.messageHandlers.handler_bridge.postMessage(payload);
};
// addLoadWindowEvent(main_load);
