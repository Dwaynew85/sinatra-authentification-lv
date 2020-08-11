class PostsController < ApplicationController

  get '/posts' do
    "You are logged in as #{session[:email]}"
  end

  get '/posts/new' do
    # Checking if they are logged in
    if !logged_in?
      redirect "/login" # Redirecting if they aren't
    else
      "A new post form" # Rendering if they are
    end
  end

  get 'posts/:id/edit' do
    if !logged_in?
      redirect "/login"
    else
      if post = current_user.posts.find_by(params[:id])
        "An edit post form #{current_user.id} is editing #{post.id}"
      else
        redirect "/posts"
      end
    end
  end
end
