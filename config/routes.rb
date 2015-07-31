Rails.application.routes.draw do

  scope path: '/', module: 'api' do
    scope path: '/v1', module: 'v1' do
      scope '/welcome' do
        get '/' => 'welcome#index'
      end
      scope '/login' do
        post '/' => 'login#submit'
      end
    end
  end
end
