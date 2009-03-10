require "test_helper"

class PostsControllerTest < ActionController::TestCase
  def test_flat_helper_output
    get :flat
    assert_select "form.in_place_editable"
    assert_select "input[type=hidden].params_provider"
    assert_select "span", "Flat"
    
    assert_select "form[action=/posts]"
  end
  
  def test_polymorphic_helper_output
    get :polymorphic
    assert_select "form.in_place_editable"
    assert_select "input[type=hidden].params_provider"
    assert_select "span", "Polymorphic"
    
    assert_select "form[action=/admin/posts]"
  end
end

class InPlaceEditableTest < Test::Unit::TestCase
  def test_nothing
    
  end
end
