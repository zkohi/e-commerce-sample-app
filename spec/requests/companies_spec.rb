require 'rails_helper'

RSpec.describe "Companies", type: :request do

  describe "GET /companies/sign_in" do
    it "creates a Admin and redirects to the Product's page and sign_out and sign_in" do
      company = FactoryGirl.create(:company)

      post new_company_session_path, params: {
        company: {
          email: company.email,
          password: company.password
        }
      }

      expect(response).to redirect_to(companies_stocks_path)
      follow_redirect!

      expect(response).to render_template(:stocks)

      get destroy_company_session_path

      expect(response).to redirect_to(new_company_session_path)
      follow_redirect!

      expect(response).to render_template(:new)
    end
  end

  describe "GET /backoffice/companies" do
    it "shows Companies" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      get backoffice_companies_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /companies/:id" do
    it "shows Company" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      company = FactoryGirl.create(:company)

      get backoffice_company_path company
      expect(response).to render_template(:show)
    end
  end

  describe "GET /backoffice/companies/new" do
    it "creates a Company and redirects to the Company's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      get new_backoffice_company_path
      expect(response).to render_template(:new)

      post backoffice_companies_path, params: {
        company: {
          email: "test@gmail.com",
          password: "companypassword",
          password_confirmation: "companypassword",
          name: "My Company"
        }
      }

      expect(response).to redirect_to([:backoffice, assigns(:company)])
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("業者が作成されました")
    end
  end

  describe "GET /backoffice/companies/:id" do
    it "updates a Company and redirects to the Company's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      company = FactoryGirl.create(:company)

      get edit_backoffice_company_path company
      expect(response).to render_template(:edit)

      patch backoffice_company_path company, params: {
        company: {
          email: "test-edit@gmail.com",
          password: "companypasswordedit",
          password_confirmation: "companypasswordedit",
          name: "My Company Edit"
        }
      }

      expect(response).to redirect_to([:backoffice, company])
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("業者が更新されました")
    end
  end

  describe "DELETE /backoffice/companies/:id" do
    it "deletes a Company and redirects to the Company's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      company = FactoryGirl.create(:company)

      delete backoffice_company_path company
      expect(response).to redirect_to(backoffice_companies_path)
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to include("業者が削除されました")
    end
  end
end
