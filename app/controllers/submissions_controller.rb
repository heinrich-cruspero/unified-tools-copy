# frozen_string_literal: true

require 'will_paginate/array'
##
class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[show edit update destroy]

  def index
    authorize Submission

    @submissions = policy_scope(Submission.search(
                                params[:search_term],
                                params[:approved],
                                params[:sort_field],
                                params[:page],
                                current_user.id,
                                false))

    if current_user.is_super_admin? || current_user.is_admin?
      datatable = 'SubmissionsAdminViewDatatable'
    else
      datatable = 'SubmissionsUserViewDatatable'
    end

    respond_to do |format|
      format.html
      format.csv do
        params.permit!
        params[:user_id] = current_user.id
        
        CsvDownloadJob.perform_later(
          params, datatable, 'submissions.csv', current_user.id
        )
        
        head :ok
      end
    end
  end

  def show
    authorize @submission
  end

  def new
    @submission = Submission.new
    authorize @submission
  end

  def edit
    authorize @submission
  end

  def create
    @submission = Submission.new(submission_params)
    @submission.user = current_user
    authorize @submission

    respond_to do |format|
      if @submission.save
        format.html { redirect_to submissions_path, notice: 'Submission was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize @submission

    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @submission

    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
    end
  end

  private

  def set_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:user_id, :company_name, :seller_name,
                                       :quantity, :isbn, :status, :counterfeits,
                                       :source_name, :source_address, :source_phone,
                                       :source_email, :notes, :approved)
  end
end
