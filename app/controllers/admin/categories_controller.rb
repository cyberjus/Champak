class Admin::CategoriesController < Admin::BaseController
  before_filter :authenticate
  
  def index 
    @categories = Category.order('name').paginate(:page => params[:page])
    @title = "Categories"
  end
  
  def new
    @category = Category.new
    @title = "Add Category" 
  end
  
  def create 
    @category = Category.new(params[:category])
    if @category.save
      redirect_to admin_categories_path
    else
      @title = "Add Category"
      render 'new'
    end
  end
  
  def edit
    @category = Category.find(params[:id])  
    @title = "Edit Category"
  end
  
  def update
    @category = Category.find(params[:id])
  	if @category.update_attributes(params[:category])
  		flash[:success] = "Category updated."
  		redirect_to admin_categories_path
  	else
  		@title = "Edit Category"
  		render 'edit'
  	end
  end
  
  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category Deleted"
    redirect_to admin_categories_path  
  end
  
end
