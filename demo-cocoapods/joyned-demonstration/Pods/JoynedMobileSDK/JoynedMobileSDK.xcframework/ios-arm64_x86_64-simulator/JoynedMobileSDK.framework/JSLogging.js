/* ========================================================================== */
/*  SDK mobile JS content, JSLogging.js                                       */
/* ========================================================================== */
function logging_load() {
    
    var _log = function _log(emoji, type, args) {
        window.webkit.messageHandlers.handler_logging.postMessage(
          `${emoji} JS ${type}: ${Object.values(args)
          .map(v => typeof(v) === "undefined" ? "undefined" : typeof(v) === "object" ? JSON.stringify(v) : v.toString())
          .map(v => v.substring(0, 3000))
          .join(", ")}`
        );
    };

    let originalLog   = console.log;
    let originalWarn  = console.warn;
    let originalError = console.error;
    let originalDebug = console.debug;

    console.log   = function() { _log("📗", "log"    , arguments); originalLog.apply(null, arguments); };
    console.warn  = function() { _log("📙", "warning", arguments); originalWarn.apply(null, arguments); };
    console.error = function() { _log("📕", "error"  , arguments); originalError.apply(null, arguments); };
    console.debug = function() { _log("📘", "debug"  , arguments); originalDebug.apply(null, arguments); };

    window.addEventListener("error", function(e) {
       _log("💥", "Uncaught", [`${e.message} at ${e.filename}:${e.lineno}:${e.colno}`]);
    });
};
logging_load();
