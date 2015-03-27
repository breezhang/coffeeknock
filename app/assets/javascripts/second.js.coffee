# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
console.group("js libs versions list")
console.log "jquery " + $.fn.jquery if $
console.log "knockout " + ko.version if ko
console.log "underscore " + _.VERSION if _
console.log "route " + Sammy.VERSION if Sammy
console.groupEnd("versions")

