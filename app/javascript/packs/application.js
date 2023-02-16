// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// import the bootstrap javascript module
import "bootstrap"

// import the site.scss we created for the bootstrap CSS (if you are not using assets stylesheet)
import "../css/site"
var jQuery = require('jquery')

// include jQuery in global and window scope (so you can access it globally)
// in your web browser, when you type $('.div'), it is actually refering to global.$('.div')
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

function params_filter(param_key, param_value) {
  debugger
  let url = window.location.href;
  if(url.split("?"+ param_key).length > 1) {
    let replace = url.split('?'+param_key)[0] + `?${param_key}=${param_value}`;
    if (url.split("?"+param_key)[1].indexOf("&") != -1)
      {
        replace += window.location.href.split('?'+param_key)[1].substring(window.location.href.split('?'+param_key)[1].indexOf("&"));
      }
    location.replace(replace);
  }
  else if (url.split("&"+param_key).length > 1) {

    let replace = url.split('&'+param_key)[0]+ `&${param_key}=${param_value}`;
    if (url.split("&"+param_key)[1].indexOf("&") != -1)
      {
        replace += window.location.href.split('&'+param_key)[1].substring(window.location.href.split('&'+param_key)[1].indexOf("&"));
      }
    location.replace(replace);
  }
  else {
    if(url.indexOf("?") == -1) {
       location.replace(`${url}?${param_key}=${param_value}`);
    } else {
      location.replace(`${url}&${param_key}=${param_value}`);
    }
  }
}