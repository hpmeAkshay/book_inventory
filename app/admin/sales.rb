ActiveAdmin.register Sale do
  permit_params :book_id, :quantity, :amount, :sold_at
  menu priority: 5
  actions :all, except: [:new, :destroy]

  action_item :total_quantity, only: :index do
    total_quantity = collection.sum(:quantity)
    render 'admin/sales/total_quantity', total_quantity: total_quantity
  end

  action_item :amount, only: :index do
    total_amount = collection.sum(:amount)
    render 'admin/sales/total_amount', total_amount: total_amount
  end

  index do
    selectable_column
    column :book
    column :quantity
    column :amount
    column :sold_at
  end

  filter :book
  filter :amount
  filter :sold_at
  filter :book
end
