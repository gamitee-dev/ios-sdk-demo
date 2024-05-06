/* ========================================================================== */
/*  SDK mobile JS content, JSEvents.js                                        */
/* ========================================================================== */
function trigger_toggle_event() {
    jndApp.toggleContainerState();
    return true;
};

function trigger_report_transaction(payload) {
    jndApp.reportTransaction(payload);
    return true;
};

function trigger_store_user_data() {
    
    var payload = {};
    payload.name = 'storeUserData';
    payload.payload = {};
    payload.localStorage = JSON.stringify(localStorage);
    window.webkit.messageHandlers.handler_events.postMessage(payload);
};

function event_listener_load() {
    
    window.addEventListener('joynedMessage', event => {
        window.webkit.messageHandlers.handler_events.postMessage(event.detail);
    });
};
event_listener_load();
