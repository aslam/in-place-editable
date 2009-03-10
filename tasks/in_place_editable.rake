require 'fileutils'
namespace :in_place_editable do
  desc "Copies the javascripts into [Rails.root]/public/"
  task :copy_javascripts => :environment do
    target_directory = File.join(Rails.root, "public", "javascripts")
    source_file = File.join(File.dirname(__FILE__), "..", "lib", "in_place_editable.js")
    target_file = File.join(target_directory, "in_place_editable.js")

    FileUtils.mkdir_p(target_directory)
    FileUtils.cp source_file, target_file

    puts "Successfully copied the javascript!"
    puts "Remember to add 'in_place_editable' to your <%= javascripts_include_tag %>."
  end
end