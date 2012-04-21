class AdminController < ApplicationController
  # These should be routed inside an authenticate(:admin) block, but just to be sure:
  before_filter :admin_only!
end
