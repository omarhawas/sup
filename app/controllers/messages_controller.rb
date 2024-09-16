class MessagesController < ApplicationController
    before_action :set_chat
    before_action :set_message, only: [:show, :update, :destroy]

    def create
        @message = @chat.messages.new(message_params)

        if @message.save
            render status: 200, json: {message: @message}
        else
            render status: 400, json: {message: @message.errors}
        end

    end

    def index
        @messages = @chat.messages

        if @messages.exists?
            render status: 200, json: {messages: @messages}
        else
            render status: 404, json: {message: "No messages found"}
        end

    end

    def show
        render status: 200, json: {message: @message}
    end

    def update
        if @message.update(message_params)
            render status: 200, json: {message: @message}
        else
            render status: 400, json: {error: @message.errors}
        end

    end

    def destroy
        if @message.destroy
            render status: 200, json: {message: "Successfully deleted message"}
        else
            render status: 400, json: {error: "Unable to delete message "}
        end
    end

    private

    def set_chat
        @chat = Chat.find(params[:chat_id])
    end

    def set_message
        @message = @chat.messages.find(params[:id])
    end

    def message_params
        params.require(:message).permit(:content)
    end

end
