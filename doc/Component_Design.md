## Component Design Guide

1. Use `Ractive.components['your-component-name'] = Ractive.extend ...`

    Reason:
        Otherwise, component users must define your component in their
        ractive instance as `{... components: {'your-component': ...}}` which
        will lead verbose, unnecessarily complex and possibly inconsistent code.  

2. Use `isolated: yes` in components.

## Testing

* If not matches with **MOST IMPORTANT**: Your component is alpha, not ready to go.
* If not matches with **IMPORTANT**: Your component is beta, ready to go with parallel development effort
* If not matches with **MEDIUM**: Your component is ready to go, but buggy.
* If not matches with **LOW**: Your component is ready to go, another developer might finalize it.
* If matches all: Congratulations! Your component is rock solid!

| #  | Importance     | Task                                                                                                                                                                               | See                                                                                                                                               | Tip                                                                                                                            |
|----|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| 1  | MOST IMPORTANT | Implement example usage of your component in `showcase/your-component.pug` as in the case of [example-component](../src/client/pages/showcase/example-component.pug)             |                                                                                                                                                   |                                                                                                                                |
| 2  | IMPORTANT      | Place a simple ractive variable by your component                                                                                                                                  | we can observe variables.                                                                                                                         |                                                                                                                                |
| 3  | IMPORTANT      | Place 2 unbound instances of your component.                                                                                                                                       | Your component does not interfere with new instances.                                                                                             | Does your component use any elements which has static `id` field?                                                              |
| 4  | MOST IMPORTANT | Place one or more of:  <ul> <li> a pair of bound instances </li> <li> `input` field </li>  <li> streaming live feed (via functions)  </li> that will change component's variable.  | Component properly updates itself whenever main Ractive instance's variable is changed.                                                           | Does your component use `observe`? Does your component implements an `.on \change` (or similar) event if it uses jQuery in it? |
| 5  | IMPORTANT      | Place a checkbox that will toggle an `{{#if}} ... {{/if}}` block.                                                                                                                  | Your component appears and disappears correctly on render and re-render.                                                                          | Check that `oninit()` and `onrender()` functions work correctly in your,component                                              |
| 6  | MEDIUM         | Test your code in mobile.                                                                                                                                                          | Your component is usable in mobile device.                                                                                                        |                                                                                                                                |
| 7  | MEDIUM         | Set width and height to different sizes                                                                                                                                            | Your component resizes correctly.                                                                                                                 |                                                                                                                                |
| 8  | LOW            | Your component must match with theme colors                                                                                                                                        | It looks good.                                                                                                                                    | Ask a friend.                                                                                                                  |
| 9  | IMPORTANT      | Add a quick checklist to [`your-component.pug`](../src/client/showcase/example-component.pug) to show that which tests has been performed and which tests your component passes. |                                                                                                                                                   |                                                                                                                                |
| 10 | MOST IMPORTANT | Is your component a container component (like theme or the [page](../src/client/components/page) component? If yes, it SHOULD NOT be defined with `isolated: yes` parameter and should `{{yield}}` or `{{yield right}}` in order to place content(s) in component, not partials (`{{>content}}` or `{{>right}}`).       | Create a button in your container component, define an event handler in your main ractive instance, see you can fire that event on button click.  |                                                                                                                                |

Example checklist for `your-component.pug`:

```
//-
    Match with Design Guide status:

        [x] 1. Example implementation
        [x] 2. Simple variable
        [x] 3. Unbound instances
        [x] 4. Bound instances and/or live feed
        [x] 5. {{#if }} ... {{/if}} block
        [ ] 6. Test on mobile
        [ ] 7. Change sizes
        [x] 8. Match theme
        [x] 9. This checklist
```    
## Example component

Look at the [example-component](../src/client/components/example-component) is used in [showcase](../src/client/pages/showcase/example-component.pug).
