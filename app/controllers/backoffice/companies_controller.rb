class Backoffice::CompaniesController < Backoffice::ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.all.page(params[:page])
  end

  def show
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to backoffice_company_path(@company), notice: '業者が作成されました'
    else
      render :new
    end
  end

  def update
    if @company.update(company_params)
      redirect_to backoffice_company_path(@company), notice: '業者が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to backoffice_companies_url, notice: '業者が削除されました'
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:email, :password, :password_confirmation, :name, :quantity_per_box)
    end
end
