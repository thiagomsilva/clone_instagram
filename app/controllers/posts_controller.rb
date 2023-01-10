class PostsController < ApplicationController
  # Incluindo o concern
  include SuggestedUsers

  before_action :set_post, only: %i[show]
  # Usuários sugeridos somente na tela inicial
  before_action :set_suggested_users, only: %i[index]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    # Setar o novo comentário na view show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    # Permissão para somente o usuário logado criar o post
    @post = Post.new(post_params.merge(created_by: current_user))

    if @post.save
      # Envia para todos os usuários que estão conectados no streaming post_channel o novo post criado por um outro usuário utilizando websockets. 
      PostChannel.broadcast_to "post_channel", post_created: render_to_string(partial: @post)

      redirect_to @post, notice: 'Post foi criado com sucesso.'
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:photo, :description)
  end
end
