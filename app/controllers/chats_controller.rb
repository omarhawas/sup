class ChatsController < ApplicationController
    before_action :set_chat, only: [:show, :update, :destroy]

    def create
        @chat = Chat.new(chat_params)

        if @chat.save
            render status: 200, json: {chat: @chat}
        else
            render status: 400, json: {message: @chat.errors}
        end

    end

    def index
        @chats = Chat.all

        if @chats.exists?
            render status: 200, json: {chats: @chats}
        else
            render status: 404, json: {message: "No chats found"}
        end
    end

    def show
        render status: 200, json: {chat: @chat}
    end

    def update
        if @chat.update(chat_params)
            render status: 200, json: {chat: @chat}
        else
            render status: 400, json: {message: @chat.errors}
        end
    end

    def destroy
        if @chat.destroy
            render status: 200, json: {message: "Successfully deleted chat"}
        else
            render status: 400, json: {message: "Unable to delete chat"}
        end

    end

    private

    def set_chat
        @chat = Chat.find(params[:id])
    end

    def chat_params
        params.require(:chat).permit(:name, :user_id)
    end

end
