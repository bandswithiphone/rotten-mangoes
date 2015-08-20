class SessionsController < ApplicationController

      def new
      end

      def create
        # binding.pry
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"
        else
          flash.now[:alert] = "Log in failed..."
          render :new
        end
      end

      def destroy
        binding.pry
        session[:user_id] = nil
        redirect_to movies_path, notice: "Adios!"
      end

end

