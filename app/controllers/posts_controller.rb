class PostsController < ApplicationController
  before_action :set_post, only: %i[ show ]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    # Permissão para somente o usuário logado criar o post
    @post = Post.new(post_params.merge(created_by: current_user))

    if @post.save
      redirect_to post_url(@post), notice: "Post foi criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:description)
  end
end
