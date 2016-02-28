class window.CheekBone

  constructor: ->

  @form_for: (object) ->
    instance = new @
    instance.object = object
    instance
    
  get: (attr) ->
    if @object.cid?
      val = @object.get(attr)
    else
      val = @object[attr]
      
    val = '' if val is undefined
    val
    
  build_attributes: (options) ->
    attributes = ''
    
    for key, value of options
      attributes += " #{key}='#{value}'"
      
    attributes
  
  text_field_tag: (attr, options = {}) ->
    val = @get(attr)
    val = to_currency(val) if (options.class || '').indexOf('filter-amount') >= 0
    val = dateFormatter(val, "dd mmmm yyyy") if val not in ["", null] and (options.class || '').indexOf('datepicker-input') >= 0
    val = "" if val is null
    attributes = @build_attributes(options)
    
    "<input id='#{attr}' name='#{attr}' type='text' value='#{val}' #{attributes} />"
    
  select_tag: (attr, options_string, options = {}) ->
    attributes = @build_attributes(options)
    
    "<select name='#{attr}' id='#{attr}' #{attributes}>#{options_string}</select>"
  
  options_for_select: (options_array, selected = null) ->
    options_string = ""
    
    _.each options_array, (option) =>
      if typeof(option) is 'object' and (option instanceof Array)
        options_string += "<option value='#{option[0]}' selected='selected'>#{option[1]}</option>" if option[0] is selected
        options_string += "<option value='#{option[0]}'>#{option[1]}</option>" if option[0] isnt selected
      else
        options_string += "<option value='#{option}' selected='selected'>#{option}</option>"  if option is selected
        options_string += "<option value='#{option}'>#{option}</option>" if option isnt selected 
    
    options_string
    
  radio_button_tag: (attr, id, value, checked = false) ->
    if checked is true
      "<input checked='checked' name='#{id}' id='#{attr}' value='#{value}' type='radio' />"
    else
      "<input name='#{id}' id='#{attr}' value='#{value}' type='radio' />"
      
  check_box_tag: (name, value = "1", checked = false, options = {}) ->
    options.checked = 'checked' if checked
    attributes = @build_attributes(options)
    
    "<label class='checkbox'>
      <input id='#{options.id}' name='#{name}' type='checkbox' value='#{value}' #{attributes} />
        #{options.label}
      </label>"
  
class window.SwordfishCheekBone extends window.CheekBone
  
  text_field_tag: (attr, options = {}) ->
    custom_options = {}
    standard_options = {}
    
    # partition into standard and custom options
    
    _.each options, (value, key) ->
      if key in ['note', 'label', 'no_decorator', 'prepend', 'append']
        custom_options[key] = options[key]
      else
        standard_options[key] = options[key]
      
    content = super(attr, standard_options)
    return content if custom_options.no_decorator
    
    span_class = if @get(attr) in ["", null] then 'text_holder' else 'text_holder_info'
    note = if custom_options.note? then "<em class='form-note'>#{custom_options.note}</em>" else ""
    
    if custom_options.label
      label = "<label class='control-label'>#{custom_options.label}</label>"
    else
      label = ""
  
    if custom_options.prepend
      "<div class='control-group'>
         #{label}
         <div class='controls'>
           <div class='input-prepend'><span class='add-on'>#{custom_options.prepend}</span>#{content}</div>
         </div>
       </div>"
    else if custom_options.append
      "<div class='control-group'>
         #{label}
         <div class='controls'>
           <div class='input-append'>#{content}<span class='add-on'>#{custom_options.append}</span></div>
         </div>
       </div>"
    else
      "<div class='control-group'>
         #{label}
         <div class='controls'>#{content}</div>
       </div>"
  
  currency_field_tag: (attr, options = {}) ->      
    options.prepend = "R"
    options.class or= ''
    options.class = options.class + ' filter-amount input-small'
    @text_field_tag(attr, options)
      
  select_tag: (attr, options_string, options = {}) ->
    content = super(attr, options_string, options)
    span_class = if @get(attr) in ["", null] then 'text_holder' else 'text_holder_hidden'

    "<div class='control-group'>
       <label class='control-label'>#{options.label}</label>
       <div class='controls'>      
         #{content}
       </div>
     </div>"
    
  text_field_counter: (attr, options) ->
    value = @get(attr) or 0
    
    "
    <div class='control-group'>
         <label class='control-label'>#{options.label}</label>
         <div class='controls'>
        <div class='counter'>
        <input type='text' id='#{attr}' name='#{attr}' value='#{value}' />
        <ul class='btns'>
          <li><a href='#' class='inc'>Increase</a></li>
          <li><a href='#' class='dec'>Decrease</a></li>
        </ul>
        </div>
      </div>
    </div>"
  
 
  check_box_tag: (name, value = "1", checked = "", options = {}) ->
    super(name, value, checked, options)
      
  radio_button_tag: (attr, id, value, checked = false) ->
    super(attr, id, value, checked)
    
  switcher_tag: (attr, id, options = [], html_options = {}) ->    
    options_html = ""
    
    _.each options, (option) =>
      if option.value is @get(attr) or option.checked is true
        options_html = options_html + "<a href='#' class='btn active' data-value='#{option.value}'>#{option.label}</a>"
      else
        options_html = options_html + "<a href='#' class='btn' data-value='#{option.value}'>#{option.label}</a>"
    
    "<div class='control-group'>
       <label class='control-label'>#{options.label or ''}</label>
       <div class='controls'>
         <div id='#{attr}' class='btn-group' data-toggle='buttons-radio'>
           #{options_html}
         </div>
       </div>
     </div>"
    
  datepicker_tag: (attr, options = {}) ->
    options.class = 'datepicker-input init-datepicker ' + (options.class || '')
    options.no_decorator = true
    content = @text_field_tag(attr, options)
    
    "<div class='control-group'>
       <label class='control-label'>#{options.label}</label>
       <div class='controls'>
         #{content}
       </div>
     </div>"

  @daterangepicker_tag: (options = {}) ->
    options.class = 'daterangepicker-input init-daterangepicker pull-right ' + (options.class || '')
    ranges = JSON.stringify(options.ranges)
    start_date = dateFormatter(options.ranges[0].start_date)
    end_date = dateFormatter(options.ranges[0].end_date)
    "<div class='#{options.class}' data-ranges='#{ranges}'>
      <i class='icon-calendar icon-large'></i>
      <span>#{start_date} - #{end_date}</span> <b class='caret'></b>
    </div>"
     
  @search_field_tag: ->
    "<div class='controls'>
      <div class='input-prepend'>
        <span class='add-on'><i class='icon-search'></i></span><input type='text' class='span4' placeholder='Search' id='search' />
      </div>
    </div>"

  @popover: (title, content) ->
    "<a class='popover-info btn btn-mini' data-content='#{content}' rel='popover' href='#' data-original-title='#{title}'><i class='icon-info-sign'></i></a>"
