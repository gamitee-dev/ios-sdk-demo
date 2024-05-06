/* ========================================================================== */
/*  SDK mobile JS content, JSMain.js                                          */
/* ========================================================================== */
function test() {
    
    let payload = {
        "type" : "action_page_load",
    };
    window.webkit.messageHandlers.handler_bridge.postMessage(payload);
};
// test()
