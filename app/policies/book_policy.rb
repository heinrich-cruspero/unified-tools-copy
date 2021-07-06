# frozen_string_literal: true

##
class BookPolicy < ApplicationPolicy
  def details?
    user.is_admin?
  end

  def detail_guides?
    user.is_admin?
  end

  def all_history?
    user.is_admin?
  end

  def quantity_history?
    user.is_admin?
  end

  def rental_history?
    user.is_admin?
  end

  def amazon_history?
    user.is_admin?
  end

  def guide_data_history?
    user.is_admin?
  end

  def amazon_orders?
    user.is_admin?
  end

  def history_chart?
    user.is_admin?
  end

  def sales_rank_history?
    user.is_admin?
  end

  def amazon_prices_history?
    user.is_admin?
  end

  def link_oe_isbn?
    user.is_admin?
  end

  def link_oe_isbn_import?
    user.is_admin?
  end

  def add_isbn?
    user.is_admin?
  end

  def add_isbn_import?
    user.is_admin?
  end
end
