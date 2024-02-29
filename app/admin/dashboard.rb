# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
      columns do
        column do
          panel "Total Sales" do
            para "Total sales count: #{Sale.count}"
          end
        end
  
        column do
          panel "Total Revenue" do
            para "Total revenue: #{number_to_currency(Sale.sum(:amount), unit: '₹', format: '%u %n')}"
          end
        end
      end
  
      columns do
        column do
          panel "Top 5 Bestselling Books" do
            ul do
              Sale.group(:book_id).order('sum_quantity desc').limit(5).sum(:quantity).each do |book_id, quantity|
                li "#{Book.find(book_id).title}: #{quantity} copies sold"
              end
            end
          end
        end
  
        # column do
        #   panel "Monthly Sales Trend" do
        #     line_chart Sale.group_by_month(:sold_at, format: "%b %Y").sum(:total_amount)
        #   end
        # end
      end
    # end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
