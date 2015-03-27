# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require jquery
#= require jquery_ujs
#= require knockout
#= require underscore
#= require sammy

# sammy add  client route function

console.log "%c%s jquery", "color:green", $.fn.jquery if $
console.log "%c%s knockoutjs", "color:green", ko.version if ko
console.log "%c%s uncerscroce", "color:green", _.VERSION if _

class AppViewModel
  constructor: (firstname, lastname)->
    @firstName = ko.observable(firstname)
    @lastName = ko.observable(lastname)
    @show_code = ko.observable(true)

  edisplay: () =>
    @show_code(true)
  ddisplay: () =>
    @show_code(false)

$ ->
  ko.applyBindings(new AppViewModel("Bert", "Bertington"), $('#example1')[0]);



class SeatReservation
  constructor: (@name, initialMeal) ->
    @meal = ko.observable(initialMeal)
    @formattedPrice = ko.computed () =>
      price =@meal().price
      return  if price  then "$" + price.toFixed(2) else "NONE"


class ReservationsViewModel
  constructor: () ->
    @availableMeals = [
      {mealName: "Standard (sandwich)", price: 0},
      {mealName: "Premium (lobster)", price: 34.95},
      {mealName: "Ultimate (whole zebra)", price: 290}
    ]

    @seats = ko.observableArray([
      new SeatReservation("Steve", @availableMeals[0]),
      new SeatReservation("Bert", @availableMeals[0])
    ])

    @totalSurcharge =ko.computed(() =>
      return _.reduce(_.map(@seats(),((num) -> num.meal().price)),((x1,y1) -> x1 + y1),0)
    )

    @show_code = ko.observable(false)

  addSeat: () =>
    @seats.push(new SeatReservation("", @availableMeals[0]))

  removeSeat: (seat) =>
    @seats.remove(seat)

  ddisplay : () ->
    @show_code(false)

  display : () ->
    @show_code(true)

$ ->
  ko.applyBindings(new ReservationsViewModel(), $("#example2")[0])



class  WebmailViewModel
  constructor: () ->
      self=@
      @folders = ['Inbox', 'Archive', 'Sent', 'Spam']
      @chosenFolderId = ko.observable();
      @chosenFolderData = ko.observable();
      @chosenMailData = ko.observable();

      $.sammy('#example3',() ->
        @get('#:folder' ,() ->
          console.log(@params.folder)
          self.chosenFolderId(@params.folder)
          self.chosenMailData(null)
          $.get("/mail", { folder: @params.folder }, self.chosenFolderData)
        )

        @get('#:folder/:mailId',()->
          self.chosenFolderId(@params.folder);
          self.chosenFolderData(null);
          $.get("/mail", { mailId: @params.mailId }, self.chosenMailData)
        )

        @get('',()->@app.runRoute('get', '#Inbox'))
      ).run()


  goToFolder : (folder) ->  location.hash = folder
  goToMail   : (mail)   ->  location.hash = mail.folder + '/' + mail.id


$ ->
  ko.applyBindings(new WebmailViewModel(),$("#example3")[0])















