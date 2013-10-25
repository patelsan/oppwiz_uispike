namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  for item in name.split '.'
    if item.length > 0
      target = target[item] or= {}
    else
      target = window

  block target, top

class NavigationViewModel
  constructor:->
    @opportunity = new Models.Opportunity() #ToDo: this represents the actual model instance and needs to be injected
    @fieldMap = ko.observableArray()
    @fieldSearchText = ko.observable()
    @createFieldMap()

    @fieldSearchText.subscribe((newVal)=> this.filterFields(newVal))

  createFieldMap: =>
    $('div[data-group]').each((index,groupElement)=>
      id = $(groupElement).attr('id')
      throw new Error('Id for the group element is required in order to collapse/ expand it..') if !id?
      dataGroup = this.defineField($(groupElement).data('group'), id)

      $('div[data-field]', groupElement).each((index, fieldElement)=>
        id = $(fieldElement).attr('id')
        throw new Error('Id for the field element is required for navigation.') if !id?
        field = this.defineField($(fieldElement).data('field'), id)
        dataGroup.Fields.push(field))

      this.fieldMap.push(dataGroup)
      )

  defineField: (definition, elementId)=>
    throw new Error('Error while creating the field map. Attribute names must have double qotes around it.') if typeof(definition) != 'object'
    return {Name: definition.name,ID: elementId, Attibute: definition.attribute,Fields: ko.observableArray(),Display: ko.observable(true)}

  filterFields: (searchTerm)=>
    return if !searchTerm?
    searchTerm = searchTerm.toLowerCase()
    this.fieldMap().forEach((section)-> section.Fields().forEach((field)->
      if field.Name.toLowerCase().indexOf(searchTerm) == -1 then field.Display(false) else field.Display(true)))

namespace 'Models', (exports)->
  exports.NavigationViewModel = NavigationViewModel

class Opportunity
  constructor:->
    @OpportunityName = ko.observable()
    @TransactionType = ko.observable()
    @Commission = ko.observable()
    @StartDate = ko.observable()
    @AwardDate = ko.observable()

  isRequired:(fieldId)=>
    ko.computed(=> Boolean(fieldId.length % 2))

  isSupplied:(fieldId)=>
    ko.computed(=> Boolean(fieldId.length % 2))

namespace 'Models', (exports)->
  exports.Opportunity = Opportunity

class OpportunityViewModel
  constructor: ->
    @data = new Models.Opportunity()

namespace 'Models', (exports)->
  exports.OpportunityViewModel = OpportunityViewModel
  