cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/com.appgiraffe.plugins.applicationPreferences/www/applicationPreferences.js",
        "id": "com.appgiraffe.plugins.applicationPreferences.applicationPreferences",
        "clobbers": [
            "appgiraffe.plugins.applicationPreferences"
        ]
    },
    {
        "file": "plugins/com.tlantic.plugins.socket/www/socket.js",
        "id": "com.tlantic.plugins.socket.Socket",
        "clobbers": [
            "window.tlantic.plugins.socket"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "com.appgiraffe.plugins.applicationPreferences": "0.1.0",
	"com.tlantic.plugins.socket": "0.3.1"
}
// BOTTOM OF METADATA
});