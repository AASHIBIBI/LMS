module ApplicationHelper
  # Helper methods for authentication
  
  def current_student
    @current_student ||= session[:student_id] && Student.find(session[:student_id])
  end
  
  def current_librarian
    @current_librarian ||= session[:librarian_id] && Librarian.find(session[:librarian_id])
  end
  
  def current_admin
    @current_admin ||= session[:admin_id] && Admin.find(session[:admin_id])
  end
  
  def student_signed_in?
    !!current_student
  end
  
  def librarian_signed_in?
    !!current_librarian
  end
  
  def admin_signed_in?
    !!current_admin
  end
  
  def user_signed_in?
    student_signed_in? || librarian_signed_in? || admin_signed_in?
  end
  
  def current_user
    current_student || current_librarian || current_admin
  end
  
  def current_user_role
    if student_signed_in?
      "student"
    elsif librarian_signed_in?
      "librarian"
    elsif admin_signed_in?
      "admin"
    else
      "guest"
    end
  end
end
