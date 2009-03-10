module InPlaceEditable
  module Helpers
    def in_place_editable(path_spec_or_object, attribute)
      case path_spec_or_object
      when ActiveRecord::Base
        instance = path_spec_or_object
        path = polymorphic_path(path_spec_or_object)
      when Array
        instance = path_spec_or_object.last
        path = polymorphic_path(path_spec_or_object)
      end
      
      object_name = ActionController::RecordIdentifier.singular_class_name(instance)
      hidden_params_provider = fields_for(object_name) {|f| f.hidden_field attribute, :class => "params_provider" }
      
      %{
        #{form_tag(path, {:class => "in_place_editable", :method => :put})}
          #{hidden_params_provider}
          <span>#{h(instance[attribute])}</span>
        </form>
      }
    end
  end
end