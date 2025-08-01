Rails.application.routes.draw do
  resources :tasks
  # Trang chính là trang danh sách bài viết
  root "posts#index"

  # CRUD cho bài viết
  resources :posts do
    resources :comments, only: [:create, :destroy]  # Nếu muốn bình luận bài viết
  end

  # # CRUD cho todo (nếu dùng cho mục riêng biệt hoặc mẫu học tập)
  # resources :todos do
  #   member do
  #     patch :toggle  # Toggle hoàn thành
  #   end
  # end

  # CRUD người dùng (đăng ký tài khoản)
  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  # Đường dẫn tùy chỉnh cho đăng ký / đăng nhập / đăng xuất
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete '/logout', to: 'sessions#destroy'

end
