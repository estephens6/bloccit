module PostsHelper
    
def user_is_authorized_for_post?(post, action)
    if current_user && (current_user == post.user || current_user.admin?)
        return true
    elsif current_user && current_user.moderator? && (action == 'edit')
    return true
    else
        return false
    end
end
end