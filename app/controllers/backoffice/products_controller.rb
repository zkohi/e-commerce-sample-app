class Backoffice::ProductsController < Backoffice::ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.page(params[:page])
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to [:backoffice, @product], notice: '商品が作成されました'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to [:backoffice, @product], notice: '商品が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to backoffice_products_url, notice: '商品が削除されました'
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :img_filename, :price, :description, :flg_non_display, :sort_order)
    end
end
