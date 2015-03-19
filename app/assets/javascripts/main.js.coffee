# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require jquery
#= require jquery_ujs
#= require knockout
#= require underscore



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

  addSeat: () =>
    @seats.push(new SeatReservation("", @availableMeals[0]))

  removeSeat: (seat) =>
    @seats.remove(seat)








$ ->
  ko.applyBindings(new ReservationsViewModel(), $("#example2")[0])