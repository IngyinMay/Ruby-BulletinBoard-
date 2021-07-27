class UserRepository
    class << self
        def getAllUsers
            @users = User.all.order("id DESC")
        end

        def createUser(user)
            @is_user_create = user.save
        end

        def getUserByID(id)
            @user = User.find(id)
        end

        def updateUser(user, user_params)
            @is_update_user = user.update(user_params)
        end

        def destroyUser(user)
            user.destroy
        end

        def findByEmail(email)
            @user = User.find_by(email: email)
        end

        def updateProfile(user, user_params)
            @is_update_profile = user.update(user_params)
        end

        def updatePassword(user, password)
            @is_update_password = user.update_attribute(:password, password)
        end

    end
end