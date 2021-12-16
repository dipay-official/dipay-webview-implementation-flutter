javascript:(function() {
    function callback(e){
        /* Only allow origin from Evy WebView URL */
//        if(e.origin !== 'http://192.168.88.159:3001'){
//            return;
//        }
        /* Stringify the json */
        var data = JSON.stringify(e.data.callback);

        /* Check the type of postMessage */
        if(e.data.type == 'ACTIVATION'){
            /* Call JavaScript Interface onActivation */
            window.flutter_inappwebview.callHandler('ActivationHandler', data);

        } else if(e.data.type == 'PAYMENT'){
            window.flutter_inappwebview.callHandler('Payment', data);

        } else if(e.data.type == 'CLOSE_WEBVIEW'){
            /* Call JavaScript Interface onClose */
            window.flutter_inappwebview.callHandler('CloseWebView', data);
        } else if(e.data.type == "UNLINK") {
            window.flutter_inappwebview.callHandler('UnlinkAccount', data);
        }
    }

    /* Add Event Listener for onMessage */
    window.addEventListener('message', callback, false);

})()