class UsersController < ApplicationController
    before_action :set_user, only: [:update, :show, :destroy]

    def create
        @user = User.new(user_params)

        if @user.save
            render status: 200, json: {user: @user}
        else 
            render status: 400, json: {message: @user.errors}
        end
    end

    def index
        @users = User.all

        if @users.exists?
            render status: 200, json: {users: @users}
        else
            render status: 404, json: {message: "No users found"}
        end

    end

    def show
        render status: 200, json: {user: @user}
    end

    def update
        if @user.update(user_params)
            render status: 200, json: {user: @user}
        else
            render status: 400, json: {message: @user.errors}
        end

    end

    def destroy
        if @user.destroy
            render status: 200, json: {message: "Successfully deleted user"}
        else
            render status: 400, json: {message: "Unable to delete user"}
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :password_digest)
    end

end
