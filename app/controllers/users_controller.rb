class UsersController < ApplicationController

      def new
        @user = User.new
      end

      def create
        @user = User.new(user_params)

        respond_to do |format|
          if @user.save
            # Tell the UserMailer to send a welcome email after save
            UserMailer.welcome_email(@user).deliver_later
     
            format.html { redirect_to(@user, notice: 'User was successfully created.') }
            format.json { render json: @user, status: :created, location: @user }

            session[:user_id] = @user.id
            redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
          else
            format.html { render action: 'new' }
            format.json { render json: @user.errors, status: :unprocessable_entity }
            render :new
          end
        end
      end



      protected

      def user_params
        params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
      end

    end


