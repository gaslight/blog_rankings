class blogRanking.Filter
  
  dateFormat = "yyyy-MM-dd"
  
  defaultStartDate: ->
    date = null
    today = Date.today()

    if today.is().monday() || today.is().sunday()
      date = today.last().monday()
    else
      date = today.last().week().last().monday()

    date.toString(dateFormat)

  defaultEndDate: ->
    date = null
    today = Date.today()

    if today.is().sunday()
      date = today
    else
      date = today.last().sunday()

    date.toString(dateFormat)
  
  constructor: ->
    @startDate = @defaultStartDate() unless @startDate
    @endDate   = @defaultEndDate()   unless @endDate

