require('jquery-ui/sortable');

SurveyAdmin =
  init: ->
    console.log 'hi'
    @initSortable()

  initSortable: ->
    $sortable = $('[data-sortable]')
    question_group_id = $sortable.data 'sortable'
    $sortable.sortable
      axis: 'y'
      items: '.row--survey-question'
      cursor: 'move'
      sort: (e, ui) ->
        ui.item.addClass 'active-item-shadow'
      stop: (e, ui) ->
        ui.item.removeClass 'active-item-shadow'
      update: (e, ui) ->
        item_id = ui.item.data 'item-id'
        console.log item_id
        position = ui.item.index()
        $.ajax
          type: 'POST'
          url: "/surveys/question_groups/#{question_group_id}/questions/update_position"
          dataType: 'json'
          data: { question_group_id: question_group_id, id: item_id, position: position }

module.exports = SurveyAdmin