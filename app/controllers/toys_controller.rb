class ToysController < ApplicationController
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.new(toy_params)
    if toy.save
      render json: toy, status: :created
    else
      render json: { errors: toy.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    toy = Toy.find_by(id: params[:id])
    toy.update(toy_params)
  end
  
  def like
    toy = Toy.find(params[:id])
    toy.likes += 1
    if toy.save
      render json: toy, status: :ok
    else
      render json: { errors: toy.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    toy = Toy.find(params[:id])
    if toy.destroy
      head :no_content
    else
      render json: { errors: toy.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end
end