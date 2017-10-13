class Company::ApplicationController < ApplicationController
  layout "company"
  before_action :authenticate_company!
end
