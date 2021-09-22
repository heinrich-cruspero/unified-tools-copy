# frozen_string_literal: true

##
class FeaturesController < ApplicationController
  before_action :set_feature, only: %i[edit update destroy]

  def index
    authorize Feature
    @features = Feature.all
  end

  def new
    authorize Feature
    @feature = Feature.new
  end

  def create
    authorize Feature
    @feature = Feature.new(feature_params)

    respond_to do |format|
      if @feature.save
        format.html do
          redirect_to features_path,
                      notice: 'Feature was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit
    authorize Feature
  end

  def update
    authorize Feature
    respond_to do |format|
      if @feature.update(feature_params)
        format.html do
          redirect_to features_path,
                      notice: 'Feature was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize Feature
    @feature.destroy
    respond_to do |format|
      format.html do
        redirect_to features_path,
                    notice: 'Feature was successfully destroyed.'
      end
    end
  end

  private

  def set_feature
    @feature = Feature.find(params[:id])
  end

  def feature_params
    params.require(:feature).permit(:name, :description)
  end
end
