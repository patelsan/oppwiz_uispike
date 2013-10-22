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
    #will create the field map dynamically, hardcoding it for now

    this.fieldMap.push({InfoGroup: 'Summary', GroupID:'summary',Fields: ko.observableArray([this.defineField('Opportunity Name','opportunityname'), this.defineField('Opportunity Status','opportunitystatus'), this.defineField('Transaction Type','transactiontype'), this.defineField('Transaction Sub Type','transactionsubtype'), this.defineField('Close Probability','closeprobability'), this.defineField('Client','client')])})
    this.fieldMap.push({InfoGroup: 'Properties', GroupID:'properties',Fields: ko.observableArray([this.defineField('Property Location Market','propertylocationmarket'), this.defineField('Low Property Value','lowpropertyvalue'), this.defineField('High Property Value','highpropertyvalue'), this.defineField('Capital Raised','capitalraised')])})
    this.fieldMap.push({InfoGroup: 'Key Dates', GroupID:'keydates',Fields: ko.observableArray([this.defineField('Start Date','startdate'), this.defineField('Pitch Proposal Date','pitchproposaldate'), this.defineField('Listing Expiration Date','listingexpirationdate')])})
    this.fieldMap.push({InfoGroup: 'Commission', GroupID:'commission',Fields: ko.observableArray([this.defineField('Total Commission','totalcommission'), this.defineField('Fee Percentage','feepercentage')])})
    this.fieldMap.push({InfoGroup: 'Key Contacts', GroupID:'keycontacts',Fields: ko.observableArray([this.defineField('Primary Client Contact','primaryclientcontact'), this.defineField('Bill To Contact','billtocontact'), this.defineField('Generating Market','generatingmarket'), this.defineField('Deal Market','dealmarket')])})
    this.fieldMap.push({InfoGroup: 'Competitors', GroupID:'competitors',Fields: ko.observableArray([this.defineField('Primary1','primary1')])})
    this.fieldMap.push({InfoGroup: 'Deal costs', GroupID:'dealcosts',Fields: ko.observableArray([this.defineField('Primary2','primary2')])})
    this.fieldMap.push({InfoGroup: 'Documents', GroupID:'documents',Fields: ko.observableArray([this.defineField('Primary3','primary3')])})

  defineField: (name, id)=>
    return {Name: name,ID: id, Display: ko.observable(true)}

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

  isCompleted:(fieldId)=>
    ko.computed(=> Boolean(fieldId.length % 2))

namespace 'Models', (exports)->
  exports.Opportunity = Opportunity

class OpportunityViewModel
  constructor: ->
    @data = new Models.Opportunity()

namespace 'Models', (exports)->
  exports.OpportunityViewModel = OpportunityViewModel