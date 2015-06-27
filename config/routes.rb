Rails.application.routes.draw do
  
scope defaults: { format: 'json'} do

  post 'users/login', to: 'users#login'
  post 'users/register', to: 'users#register'
  
end

end
