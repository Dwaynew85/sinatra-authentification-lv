class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "auth_demo_lv"
  end

  get '/' do
    "Hello World!"
  end

  helpers do
    def logged_in?
      #!!session[:email]
      !!current_user
    end
    

    def current_user
      @current_user ||= User.(:email => session[:email]) if session[:email]
    end

    def login(email, password)
      # check if a user with thise email exists
      # if so, set the session
      user = User.find_by(:email => email)
      binding.pry
      if user && user.authenticate(password)
        # if I find a user AND I can authenticate that user with their password, then I log them in
        session[:email] = user.email
      else 
        redirect '/login'
      end
    end

    def logout!
      session.clear
      # Emailing them to let them know they logged out
    end

  end

end
