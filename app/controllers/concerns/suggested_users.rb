module SuggestedUsers
    extend ActiveSupport::Concern
  
    private
  
    def set_suggested_users
        # Serão exibidos somente os usuários que estão no banco retirando o atual 
        @suggested_users = User.all - [current_user]
    end
end