require 'rails_helper'

RSpec.describe "Admins", type: :request do

  describe "GET /backoffice/admins/sign_up" do
    it "creates a Admin and redirects to the Product's page and sign_out and sign_in" do
      get new_admin_registration_path
      expect(response).to render_template(:new)

      post admin_registration_path, params: {
        admin: {
          email: "test@gmail.com",
          password: "adminpassword",
          password_confirmation: "adminpassword"
        }
      }

      expect(response).to redirect_to(backoffice_products_path)
      follow_redirect!

      expect(response).to render_template(:index)

      get destroy_admin_session_path

      expect(response).to redirect_to(new_admin_session_path)
      follow_redirect!

      expect(response).to render_template(:new)

      post new_admin_session_path, params: {
        admin: {
          email: "test@gmail.com",
          password: "adminpassword",
        }
      }

      expect(response).to redirect_to(backoffice_products_path)
      follow_redirect!

      expect(response).to render_template(:index)
    end
  end
end
