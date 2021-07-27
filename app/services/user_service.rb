class UserService
    class << self
        def getAllUsers
            @users = UserRepository.getAllUsers
        end

        def createUser(user)
            @is_user_create = UserRepository.createUser(user)
        end

        def getUserByID(id)
            @user = UserRepository.getUserByID(id)
        end

        def updateUser(user, user_params)
            @is_user_update = UserRepository.updateUser(user, user_params)
        end

        def destroyUser(user)
            UserRepository.destroyUser(user)
        end
        
        def findByEmail(email)
            @user = UserRepository.findByEmail(email)
        end

        def updateProfile(user, user_params)
            @is_update_profile = UserRepository.updateProfile(user, user_params)
        end

        def updatePassword(user, password)
            @is_update_password = UserRepository.updatePassword(user, password)
        end
    end
end