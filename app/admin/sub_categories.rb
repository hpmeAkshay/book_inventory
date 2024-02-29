ActiveAdmin.register SubCategory do
  permit_params :name, :description, :category_id
  menu priority: 4
  index do
    column :name
    column :description
  end
end
