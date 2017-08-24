class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:destroy]

  def destroy
    @line_item.destroy
    redirect_to cart_path, notice: 'Line item was successfully destroyed.'
  end

  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end
end
