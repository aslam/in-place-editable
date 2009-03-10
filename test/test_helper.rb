require "rubygems"
require "active_support"
require "active_record"
require "action_controller"
require "action_controller/test_case"
require "test/unit"

# Load the plugin
ActiveSupport::Dependencies.load_paths << File.join(File.dirname(__FILE__), "..", "lib")
require "../init"

# We need a model because of the form_for related things we do
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")

silence_stream(STDOUT) {
  ActiveRecord::Schema.define(:version => 1) do
    create_table(:posts) {|t| t.string :title }
  end
}

class Post < ActiveRecord::Base; end


# We need these routes, they will be called by the view.
ActionController::Routing::Routes.draw do |map|
  map.resources :posts
  map.namespace(:admin) {|a| a.resources :posts }
  map.connect ":controller/:action/:id"
end

# The actions the test cases will use to test the output of the helper.
class PostsController < ActionController::Base
  def flat
    @post = Post.new(:title => "Flat")
    render :inline => %{
      <%= in_place_editable(@post, :title) %>
    }
  end
  
  def polymorphic
    @post = Post.new(:title => "Polymorphic")
    render :inline => %{
      <%= in_place_editable([:admin, @post], :title) %>
    }
  end
end