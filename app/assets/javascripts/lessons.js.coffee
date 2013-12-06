jQuery ->
  $('#lesson_category_tokens').tokenInput('/categories.json',
  theme: 'facebook',
  prePopulate: $('#lesson_category_tokens').data('load'))

  $('#search').autocomplete
    source: $('#search').data('autocomplete-source')

  $('#location').autocomplete
    source: $('#location').data('autocomplete-source')