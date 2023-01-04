class UsersController < ApplicationController
    # Incluindo o concern
    include SuggestedUsers

    # Usuários sugeridos somente na tela inicial
    before_action :set_suggested_users, only: %i[show]

    def show
        # Buscar pelo parâmetro username ao invés do ID como é padrão
        user = User.find_by(username: params[:username])
        @posts = user.posts

        render "posts/index"
    end

    def edit
    end

    def update
        # Para permiitir que somente o usuário logado alterem seu próprio user
        if current_user.update(user_params)
        redirect_to root_path, notice: "Seu perfil foi atualizado com sucesso."
        else
        flash.now[:alert] = current_user.errors.full_messages.to_sentence
        render :edit
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :avatar)
    end
end  