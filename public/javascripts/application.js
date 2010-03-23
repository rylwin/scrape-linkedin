// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Focus. First looks for an element with the focus class. If it cannot find any, we then look for the first form element on the page.
function set_initial_focus() {
	var to_focus = $$('.focus')
	if (to_focus == "") {
		focus_on_first_form_field();
		return;
	}

	to_focus = to_focus[0]
	if (to_focus != null)
		to_focus.activate();
}

// Focuses on the first form element on the page. Skips over forms with no_focus class.
function focus_on_first_form_field() {
	var forms = $$('form:not(.no_focus)');
	if (forms == '')
		return;
		
	forms[0].focusFirstElement();
}

// 
// The WindowEvents class(?) should be used to handle all window events in a single location.
// 
var WindowEvents = {
	
	on_load: function() {
		set_initial_focus();
	}	
}

document.observe("dom:loaded", WindowEvents.on_load);
window.onbeforeunload = WindowEvents.on_before_unload;
