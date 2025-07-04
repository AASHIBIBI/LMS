class LibrariesController < ApplicationController
  # Only enable basic browsing functions for frontend-only app
  
  # GET /libraries
  def index
    @libraries = Library.all
  end
  
  # GET /libraries/1
  def show
    @library = Library.find(params[:id])
    
    # Get books for this library
    @books = Book.all.select { |book| book.library_id == @library.id }
  rescue => e
    flash[:alert] = "Error: This action requires database access which is disabled in this demo."
    redirect_to libraries_path
  end

  # GET /libraries/new
  def new
    @library = Library.new
  end

  # GET /libraries/1/edit
  def edit
  end

  # POST /libraries
  # POST /libraries.json
  def create
    @library = Library.new(library_params)

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'Library was successfully created.' }
        format.json { render :show, status: :created, location: @library }
      else
        format.html { render :new }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /libraries/1
  # PATCH/PUT /libraries/1.json
  def update
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to @library, notice: 'Library was successfully updated.' }
        format.json { render :show, status: :ok, location: @library }
      else
        format.html { render :edit }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  def destroy
    @library.destroy
	if current_admin.nil? 
		respond_to do |format|
		  format.html { redirect_to libraries_url, notice: 'Library was successfully destroyed.' }
		  format.json { head :no_content }
		end
	else
		respond_to do |format|
		  format.html { redirect_to show_libraries_url, notice: 'Library was successfully removed.' }
		  format.json { head :no_content }
		end
	end
  end

  def student_libraries_index
    @libraries = Library.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_params
      params.require(:library).permit(:name, :university, :location, :borrow_limit, :overdue_fines)
    end
end
