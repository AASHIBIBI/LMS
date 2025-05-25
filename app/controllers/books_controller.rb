class BooksController < ApplicationController
  # Only enable basic browsing functions for frontend-only app
  
  # GET /books
  def index
    @books = Book.all
  end
  
  # GET /books/1
  def show
    @book = Book.find(params[:id])
  rescue => e
    flash[:alert] = "Error: This action requires database access which is disabled in this demo."
    redirect_to books_path
  end
  
  # Search books
  def search
    # Simple search that works with mock data
    query = params[:search].to_s.downcase
    
    if query.present?
      # Filter books based on the query
      @books = Book.all.select do |book|
        book.title.downcase.include?(query) || 
        book.author.downcase.include?(query) || 
        book.subject.downcase.include?(query)
      end
    else
      @books = Book.all
    end
    
    render :index
  end
  
  # Database-dependent actions
  # These methods just show a notice and redirect
  
  def checkout
    redirect_with_db_notice
  end
  
  def returnBook
    redirect_with_db_notice
  end
  
  def bookmark
    redirect_with_db_notice
  end
  
  def unbookmark
    redirect_with_db_notice
  end
  
  def requestBook
    redirect_with_db_notice
  end
  
  def books_students
    redirect_with_db_notice
  end
  
  def librarian_book_view
    redirect_with_db_notice
  end
  
  def getBookmarkBooks
    redirect_with_db_notice
  end
  
  def list_checkedoutBooks
    redirect_with_db_notice
  end
  
  def list_checkedoutBooksAndStudentsAdmin
    redirect_with_db_notice
  end
  
  private
  
  def redirect_with_db_notice
    flash[:alert] = "This action requires database access which is disabled in this demo."
    redirect_to books_path
  end
end
