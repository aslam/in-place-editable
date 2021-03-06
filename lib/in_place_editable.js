(function($){
	$(function(){
		$.fn.inPlaceEditable = function(){
			this.each(function(i, element){
				var element = $(element)
				element.plainTextContainer = element.find("span")
				element.data("text", element.plainTextContainer.html())
				element.authenticityToken = element.find("input[name=authenticity_token]").val()
				element.paramName = element.find("input.params_provider").attr("name")
				element.columnType = element.find("input[name=column_type]").val()
				
				if (element.columnType == "text") {
					element.inPlaceEditField = $('<textarea class="in_place_edit_field"></textarea><button>Save</button>')
				} else {
					element.inPlaceEditField = $('<input type="text" class="in_place_edit_field" />')
				}
				element.inPlaceEditField.hide()
				element.append(element.inPlaceEditField)
				
				element.plainTextContainer.click(function(){
					element.inPlaceEdit()
					return false
				})
				
				element.submit(function(){
					element.data("text", element.inPlaceEditField.val())
					element.returnToNormal()
					
					data = {}
					data["_method"] = "put"
					data["authenticity_token"] = element.authenticityToken
					data[element.paramName] = element.data("text")
					
					$.ajax({
						type: "POST",
						url: element.attr("action"),
						data: data
					})
					
					return false
				})
				
				element.keyup(function(e){
					if (e.keyCode == 27) {
						element.returnToNormal()
					}
				})
				
				element.inPlaceEditField.blur(function(){
					element.returnToNormal()
				})
				
				////////////////////
				
				element.returnToNormal = function(){
					element.plainTextContainer.show()
					element.plainTextContainer.html(element.data("text"))
					element.inPlaceEditField.hide()
				}
				
				element.inPlaceEdit = function(){
					element.plainTextContainer.hide()
					
					element.inPlaceEditField.show()
					element.inPlaceEditField.val(element.data("text"))
					element.inPlaceEditField.focus()
				}
			})

		}

		$(".in_place_editable").inPlaceEditable()
	})
})(jQuery)