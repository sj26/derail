<%= module_namespacing do %>
class <%= controller_name %> < ApplicationController
  respond_to :html

  before_filter :find_<%= singular_table_name %>, :only => [:show, :edit, :update, :destroy]

  def index
    respond_with @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
  end

  def new
    respond_with @<%= singular_table_name %> = <%= class_name %>.new
  end

  def create
    respond_with @<%= singular_table_name %>
  end

  def edit
    respond_with @<%= singular_table_name %>
  end

  def update
    respond_with @<%= singular_table_name %>
  end

  def destroy
    @<%= singular_table_name %>.destroy
    respond_with @<%= singular_table_name %>
  end

protected

  def find_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= class_name %>.find params[:id]
  end
end
<% end %>