require! 'prelude-ls': {filter, each, find}

Ractive.components['button-group'] = Ractive.extend do
    template: RACTIVE_PREPARSE('index.pug')
    isolated: yes

    onrender: ->
        @on do
            _itemStateChanged: (ev, curr-state, next-state, id) ->
                __ = @
                user = @get \user
                button-list = @get \list

                ev.component.fire \state, \doing
                ev.component.set \selfDisabled, yes
                err, res <- __.fire \statechange, next-state, button-list
                if err
                    ev.component.fire \state, \error, err.message if err
                    ev.component.fire \state, curr-state
                    return 
                ev.component.fire \state, next-state
                ev.component.set \selfDisabled, no


                return
                # add new action to the log
                item = find (.id is id), __.get \checklist
                item.is-done = next-state is \checked
                log = @get \log
                log.unshift do
                    what:
                        str: "state of #{id} is changed from #{curr-state} to #{next-state}"
                        id: id
                        old-value: curr-state
                        new-value: next-state
                    whom: user?name
                    when: Date.now!
                @set \log, log
                @update \checklist

    data: ->

        log: []
        is-editing: (id) ->
            id is @get \editingItem
