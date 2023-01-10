class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      # Envia para todos os usuários que estão conectados no streaming comment_channel o novo comentário criado por um outro usuário utilizando websockets. 
      CommentChannel.broadcast_to("comment_channel",
        post_id: @comment.post_id,
        comment_created: render_to_string(partial: @comment))

      redirect_to @comment.post, notice: "Comentário enviado com sucesso."
    else
      @post = @comment.post
      flash.now[:alert] = @comment.errors.full_messages.to_sentence
      render "posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :body)
  end
end