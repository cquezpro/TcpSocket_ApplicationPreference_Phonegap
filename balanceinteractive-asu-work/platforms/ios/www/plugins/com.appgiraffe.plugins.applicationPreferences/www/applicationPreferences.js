cordova.define("com.appgiraffe.plugins.applicationPreferences.applicationPreferences", function(require, exports, module) {
    var applicationPreferences = {

        get : function(key, success, fail) {
               var args = {};
               args.key = key;
               cordova.exec(success,fail,"applicationPreferences","getSetting",[args]);
        },
               
        set : function(key, value, success, fail) {
               var args = {};
               args.key = key;
               args.value = value;
               cordova.exec(success,fail,"applicationPreferences","setSetting",[args]);
        }

}
// applicationPreferences

module.exports = applicationPreferences;

});
