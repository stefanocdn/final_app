jQuery ->
  $('#lesson_category_tokens').tokenInput('/categories.json',
  theme: 'facebook',
  prePopulate: $('#lesson_category_tokens').data('load'))

  $('#query').autocomplete
    source: $('#query').data('autocomplete-source')