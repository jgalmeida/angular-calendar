angular.module("Scheduler").directive "openDialog", ->
  openDialog =
  	restrict: "A",
  	link: (scope, element, attrs) ->
    openDialog = ->
      modal = angular.element("#eventModal")
      ctrl = modal.controller()
      ctrl.setModel(name: "", description: "", date: attrs.openDialog)
      modal.modal("show")
    element.bind("click", openDialog)

  openDialog