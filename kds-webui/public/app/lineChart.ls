{split, take, join, lists-to-obj, sum} = require 'prelude-ls'
Ractive.DEBUG = /unminified/.test -> /*unminified*/

kds-data=
    * product-id: 2426
      amount:14
      reason:"sebep aa"
      date:2
    * product-id: 2426
      amount:18
      reason:"sebep bb"
      date:5
    * product-id: 2426
      amount:11
      reason:"sebep cc"
      date:5
    * product-id: 2426
      amount:40
      reason:"sebep dd"
      date:5
    * product-id: 2458
      amount:30
      reason:"ie bozuk"
      date:15
    * product-id: 2458
      amount:10
      reason:"ui bozuk"
      date:20

LineChart = Ractive.extend do
    template: '#linechart'
    data:
        convert-to-svg-points: ->
            /* converts points for the following format: 
            
                @points = 
                    * x: 1
                      y: 5
                    * x: 15
                      y: 16
                      
            to:
                
                "1 5,15 16"
            */
            
            points = @get "points" 
            join ',' ["#{..x} #{..y}" for points]
            
            
            
            
                    
convert-kds-to-linechartpoints = (selected-id)-> 
    /* converts kds to line chart points 
        kds=
            * product-id: 2458
              amount:30
              reason:"ie bozuk"
              date:15
            * product-id: 2458
              amount:10
              reason:"ui bozuk"
              date:20
        to:
            points = 
                    * x: 15 # date
                      y: 30 # amount
                    * x: 20
                      y: 10
    */       
    console.log "selected-list: "
    selected-list = [.. for kds-data when ..product-id is (selected-id |> parse-int)]
    console.log selected-list
    #[x as date, y as amount in.. for selected-list] 
    points=[{x: ..date, y: ..amount} for selected-list]
    console.log points
    points
 
ractive = new Ractive do
    el: '#main-output'
    template: '#main-template'
    data:
        domates-zayiat-datasi:
            * x: 1
              y: 5
            * x: 15
              y: 15
            * x: 25
              y: 25
            * x: 35
              y: 35
            * x: 45
              y: 45
            * x: 55
              y: 40
            * x: 60
              y: 105
        points: convert-kds-to-linechartpoints 2458     
    components:
        linechart: LineChart

ractive.on do
    select : (event,id)->if event.hover then @set 'id',id else @set 'id',null
    get-kds-data: (event,id) -> ractive.set "kds", kds-data

products=
    * id: 2426
      name: "domates"
    * id: 2458
      name: "patates"

ractive.on 'complete', !->
    ractive.set \products products