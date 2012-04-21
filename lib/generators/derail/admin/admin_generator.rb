require 'derail'

module Derail::Generators
  class AdminGenerator < Base
    def add_admin_before_filter
      inject_into_file "app/controllers/application_controller.rb", :before => /\n[ \t]*end\s*\Z/m, <<-RUBY.redent(2)

        # Before filter for asseting an administrator is logged in

        def admin_only!
          authenticate_user! && begin
            forbidden unless current_user.admin?
          end
        end
      RUBY
    end

    def copy_admin_controller
      template "admin_controller.rb"
    end
  end
end
