require 'logger'
class PostRepository
    class << self

        # function getAllPosts
        # get post
        # @return [<Type>] @posts
        def getAllPosts(current_user)
            if current_user
                @posts = Post.all.order("created_at DESC")
            else 
                @posts = Post.where(public_flag: true).order("created_at DESC")
            end
        end

        # function getPostById
        # @param [<int>] id <postID>
        # @return [<Type>] <post>
        def getPostById(id)
            @post = Post.find(id)
        end

        # function createPost
        # @param [<Type>] post <description>
        # @return [<Type>] <is_save_post>
        def createPost(post)
            @is_save_post = post.save
        end

        # function : updatePost
        # @param [<Type>] post <description>
        # @param [<Type>] post_params <description>
        # @return [<Type>] is_update_post
        def updatePost(post, post_params)
            @is_update_post = post.update(post_params)
        end

        # function : destroyPost
        # delete post
        # @param [<Type>] post <description>
        # @return [<Type>] <description>
        def destroyPost(post)
            post.destroy
        end

        # function filter
        # filter posts
        # @param [<Type>] filter_by <description>
        # @param [<Type>] user_id <description>
        # @return [<Type>] <posts>

        def filter(filter_by, user_id)
            case filter_by 
            when '1' 
                @posts = Post.all.order("created_at DESC")
            when '2'
                @posts = Post.where(created_by: user_id).order("created_at DESC")
            when '3'
                @posts = Post.where.not(created_by: user_id).order("created_at DESC")
            end
        end

        # function search
        # search posts
        # @param [<Type>] search_keyword <description>
        # @return [<Type>] <posts>
        def search(search_keyword)
            @posts = Post.where("title LIKE :title or description LIKE :desc", {:title => "%#{search_keyword}%", :desc => "%#{search_keyword}%"})
        end
    end
end
