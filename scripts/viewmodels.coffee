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
    @createFieldMap()

  createFieldMap: =>
    #will create the field map dynamically, hardcoding it for now
    this.fieldMap.push({InfoGroup: 'Summary', GroupID:'summary',Fields: ko.observableArray([{Name: 'Opportunity Name', ID: 'opportunityname'}, {Name: 'Opportunity Status', ID: 'opportunitystatus'}, {Name: 'Transaction Type', ID: 'transactiontype'}, {Name: 'Client', ID: 'client'}])})
    this.fieldMap.push({InfoGroup: 'Properties', GroupID:'properties',Fields: ko.observableArray([{Name: 'Property Location Market', ID: 'propertylocationmarket'}, {Name: 'Low Property Value', ID: 'lowpropertyvalue'}, {Name: 'High Property Value', ID: 'highpropertyvalue'}, {Name: 'Capital Raised', ID: 'capitalraised'}])})
    this.fieldMap.push({InfoGroup: 'Key Dates', GroupID:'keydates',Fields: ko.observableArray([{Name: 'Start Date', ID: 'startdate'}, {Name: 'Pitch Proposal Date', ID: 'pitchproposaldate'}, {Name: 'Listing Expiration Date', ID: 'listingexpirationdate'}, {Name: 'Close Probability', ID: 'closeprobability'}])})
    this.fieldMap.push({InfoGroup: 'Commission', GroupID:'commission',Fields: ko.observableArray([{Name: 'Total Commission', ID: 'totalcommission'}, {Name: 'Fee Percentage', ID: 'feepercentage'}])})
    this.fieldMap.push({InfoGroup: 'Key Contacts', GroupID:'keycontacts',Fields: ko.observableArray([{Name: 'Primary Client Contact', ID: 'primaryclientcontact'}, {Name: 'Bill To Contact', ID: 'billtocontact'}, {Name: 'Generating Market', ID: 'generatingmarket'}, {Name: 'Deal Market', ID: 'dealmarket'}])})
    this.fieldMap.push({InfoGroup: 'Competitors', GroupID:'competitors',Fields: ko.observableArray([{Name: 'Primary', ID: 'primary'}])})
    this.fieldMap.push({InfoGroup: 'Deal costs', GroupID:'dealcosts',Fields: ko.observableArray([{Name: 'Primary', ID: 'primary'}])})
    this.fieldMap.push({InfoGroup: 'Documents', GroupID:'documents',Fields: ko.observableArray([{Name: 'Primary', ID: 'primary'}])})

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