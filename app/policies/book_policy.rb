# frozen_string_literal: true

##
class BookPolicy < ApplicationPolicy
  def details?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def detail_guides?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def quantity_history?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def rental_history?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def amazon_history?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def guide_data_history?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def amazon_orders?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def history_chart?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def sales_rank_history?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def amazon_prices_history?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def link_oe_isbn?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def link_oe_isbn_import?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def add_isbn?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end

  def add_isbn_import?
    user.is_super_admin? || user.has_permission(
      record, __method__, @route_permissions
    )
  end
end
