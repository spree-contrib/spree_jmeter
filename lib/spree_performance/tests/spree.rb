require 'ruby-jmeter'

module SpreePerformance::Tests
  class Spree < SpreePerformance::Test

    def plan
      # Define listeners to graph & report results with.
      aggregate_graph
      aggregate_report
      graph_results
      response_time_graph
      summary_report
      view_results_tree

      threads @users, {ramp_time: @ramp, duration: @length, continue_forever: true} do
        extract name: 'authenticity_token', regex: 'meta content="(.+?)" name="csrf-token"'

        random_timer 5000, 10000

        transaction '01_GET_home_page' do
          visit '/'
        end

        transaction '02_GET_view_product' do
          visit '/products/ruby-on-rails-tote'
        end

        transaction '03_POST_add_product' do
          submit '/orders/populate', {
            fill_in: {
              'utf8'               => '%E2%9C%93',
              'authenticity_token' => '${authenticity_token}',
              'variant_id'         => '1',
              'quantity'           => '1',
              'commit'             => 'Add To Cart'
            }
          }
        end

        transaction '04_GET_view_products' do
          visit '/products'
        end

        transaction '05_GET_view_product' do
          visit '/products/ruby-on-rails-jr-spaghetti'
        end

        transaction '06_POST_add_product' do
          submit '/orders/populate', {
            fill_in: {
              'utf8'               => '%E2%9C%93',
              'authenticity_token' => '${authenticity_token}',
              'variant_id'         => '1',
              'quantity'           => '1',
              'commit'             => 'Add To Cart'
            }
          }
        end

        transaction '07_GET_search' do
          visit '/products?utf8=%E2%9C%93&taxon=&keywords=rails'
        end

        transaction '08_GET_cart' do
          visit '/cart'
        end

        transaction '09_GET_home_page' do
          visit '/'
        end

      end
    end

  end
end
