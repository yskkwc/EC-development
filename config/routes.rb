Rails.application.routes.draw do

  mount Spree::Core::Engine, :at => '/'

  namespace :potepan do
    resources :products, only: :show
    get '/',                        :to => 'sample#index'
    get 'index',                    :to => 'sample#index'
    get :product_grid_left_sidebar, :to => 'sample#product_grid_left_sidebar'
    get :product_list_left_sidebar, :to => 'sample#product_list_left_sidebar'
    get :single_product,            :to => 'sample#single_product'
    get :cart_page,                 :to => 'sample#cart_page'
    get :checkout_step_1,           :to => 'sample#checkout_step_1'
    get :checkout_step_2,           :to => 'sample#checkout_step_2'
    get :checkout_step_3,           :to => 'sample#checkout_step_3'
    get :checkout_complete,         :to => 'sample#checkout_complete'
    get :blog_left_sidebar,         :to => 'sample#blog_left_sidebar'
    get :blog_right_sidebar,        :to => 'sample#blog_right_sidebar'
    get :blog_single_left_sidebar,  :to => 'sample#blog_single_left_sidebar'
    get :blog_single_right_sidebar, :to => 'sample#blog_single_right_sidebar'
    get :about_us,                  :to => 'sample#about_us'
    get :tokushoho,                 :to => 'sample#tokushoho'
    get :privacy_policy,            :to => 'sample#privacy_policy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
