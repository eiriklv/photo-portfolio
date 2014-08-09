# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require jquery-ui/sortable
#= require bootstrap-sprockets
#= require chosen-jquery

p = ->
$.browser = {browser: {msie: false}}

ready = ->
  initChosen()
  initSortable()

initChosen = ->
  $('.chosen').removeClass('chosen').each ->
    $me = $(this)
    width = $me.attr('width') or '100%'
    $me.chosen
      allow_single_deselect: true
      no_results_text: 'Not found: '
      search_contains: true
      width: width
      disable_search_threshold: 10
      disable_search: $(this).hasClass('nosearch')

initSortable = ->
  $('table.table').sortable
    handle: 'td.acol .btn-default'
    items: 'tr'
    containment: 'parent'
    axis: 'y'
    helper: (e, tr) ->
      $originals = tr.children()
      $helper = tr.clone()
      $helper.children().each (index) ->
        # Set helper cell sizes to match the original sizes
        $(this).width($originals.eq(index).outerWidth())
      $helper
    update: ->
      sortURL = $(this).attr 'data-sort-url'
      ids = []
      $(this).find('tr').each ->
        ids.push $(this).attr 'data-id'
      $.post sortURL,
        ids: ids.join ','

$(document).ready ready
$(document).on 'page:change', ready