class Companies::ProductStocksController < Companies::ApplicationController
  before_action :set_product_stock, only: [:show, :edit, :update, :destroy]

  def index
    @product_stocks = ProductStock.all
  end

  def show
  end

  def new
    @product_stock = ProductStock.new
  end

  def edit
  end

  def create
    @product_stock = ProductStock.new(product_stock_params)

    if @product_stock.save
      redirect_to @product_stock, notice: 'Product stock was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product_stock.update(product_stock_params)
      redirect_to @product_stock, notice: 'Product stock was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product_stock.destroy
    redirect_to product_stocks_url, notice: 'Product stock was successfully destroyed.'
  end

  private
    def set_product_stock
      @product_stock = ProductStock.find(params[:id])
    end

    def product_stock_params
      params.require(:product_stock).permit(:product_id, :company_id, :stock)
    end
end
