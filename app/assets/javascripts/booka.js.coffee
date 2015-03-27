console.group("js libs versions list")
console.log "jquery " + $.fn.jquery if $
console.log "knockout " + ko.version if ko
console.log "underscore " + _.VERSION if _
console.log "route " + Sammy.VERSION if Sammy
console.groupEnd("versions")

app = $.sammy('#app1', () ->
  that = {}

  $("#myTabs a").on('click', (e)-> that.t = e.currentTarget)


  @get('#/:s', () ->
    if that.t
      p = @params.s
      se = $(that.t).attr('href').replace(/#\//g, '')
      num = se.match(/[0-9]/g)
      activeui = $("div div[class=\"tab-pane active\"]")
      activeliafter  = $(that.t).parent('li')
      activelibefore = $(that.t).parent('li').siblings('li').filter(()-> $(@).hasClass('active'))
      activelibefore.removeClass('active') if activelibefore
      activeliafter.addClass('active') if  activeliafter && !activeliafter.hasClass('active')

      w = $('div div').filter((i) -> $(@).hasClass('tab-pane')) if num

      w = w.filter(() -> $(@).attr('id').indexOf(num) > -1) if w

      activeui.removeClass('active') if activeui

      w.addClass('active') if w

  )

  @get('', ()-> @app.runRoute('get', '#/'))
)
$ ->
  app.run()
