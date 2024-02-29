ActiveAdmin.register BookSummary do

  permit_params :book_id, :total_quantity_sold, :total_revenue
  
  index do
    selectable_column
    column :book
    column :total_quantity_sold
    column :total_revenue do |summary|
      number_to_currency(summary.total_revenue, unit: "₹")
    end
    actions
  end
end
