$(function(){
	$(".in_place_editable").click(function(){
		var inPlaceEditField = $('<input type="text" />')
		var uneditableContent = $(this).find("span")
		var currentText = uneditableContent.html()
		
		uneditableContent.replaceWith(inPlaceEditField)
		inPlaceEditField.val(currentText)
		inPlaceEditField.focus()
		return false
	}).submit(function(){
		var self = $(this)
		var authenticityToken = self.find("input[name=authenticity_token]").val()
		var inputField = self.find("input[type=text]")
		var plainText = inputField.val()
		var paramName = self.find("input.params_provider").attr("name")
		
		inputField.replaceWith($("<span>" + plainText + "</span>"))
		
		data = {}
		data["_method"] = "put"
		data["authenticity_token"] = authenticityToken
		data[paramName] = plainText
		
		$.ajax({
			type: "POST",
			url: self.attr("action"),
			data: data
		})
		
		return false
	})
})