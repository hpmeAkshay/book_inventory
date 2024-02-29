ActiveAdmin.register Category do
  permit_params :name, :description
  menu priority: 3
  index do
    column :name
    column :description
  end
end
