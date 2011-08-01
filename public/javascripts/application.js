// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
	$('#sidebar-left ul li').hover(function() {
		$('#sidebar-left ul li.selected').addClass('selected-leave');
		$('#sidebar-left ul li.selected').removeClass('selected');
	}, function(){
		$('#sidebar-left ul li.selected-leave').addClass('selected');
	});
});


/* textbox class on request-page */

$(document).ready(function() {
	$('input[type="radio"]').click(function() {
		$('label.active').removeClass('active');
		$(this).next().addClass('active');
	});	
});

//dojo.registerModulePath("sen", "../../sen");          // DEVELOPMENT ENVIRONMENT
dojo.registerModulePath("sen", "../../release/sen");    // BUILD ENVIRONMENT
dojo.require("sen.app");

dojo.ready(function() {
	sen.app.init();
    
    dojo.query("#item_description").forEach(function(node) {
        var text = dojo.attr(node, "value");
        
        dojo.connect(node, "onfocus", function(e) {
            dojo.addClass(e.target, "active");
            if (dojo.attr(e.target, "value") == text) {
                dojo.attr(e.target, "value", "");
            }
        });
        
        dojo.connect(node, "onblur", function(e) {
            if (dojo.attr(e.target, "value") == "") {
                dojo.attr(e.target, "value", text);
                dojo.removeClass(e.target, "active");
            }
        })
    });
    
    /*dojo.query("textarea").forEach(function(node) {
        var text = dojo.attr(node, "value");
        
        dojo.connect(node, "onfocus", function(e) {
            dojo.addClass(e.target, "active");
        });
        
        dojo.connect(node, "onblur", function(e) {
            if (dojo.attr(e.target, "value") == "") {
                dojo.attr(e.target, "value", text);
                dojo.removeClass(e.target, "value");
            }
        })
    });*/
});
